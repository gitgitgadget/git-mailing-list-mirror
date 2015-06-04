From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Fri, 5 Jun 2015 00:53:31 +0200 (CEST)
Message-ID: <299923407.139591.1433458411117.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr> <CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com> <CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 00:53:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0e0q-0002oN-5j
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbbFDWxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 18:53:19 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:58780 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566AbbFDWxT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 18:53:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B41D02843;
	Fri,  5 Jun 2015 00:53:15 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 42lxxTSLiFu5; Fri,  5 Jun 2015 00:53:15 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A0A4E283B;
	Fri,  5 Jun 2015 00:53:15 +0200 (CEST)
In-Reply-To: <CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email aliases when editing patches or using --xx-cmd
Thread-Index: ZWNgwkNKCU//NvRECn0/WZ3tD3UX2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270803>

On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>
> Hi,
>
> Working on git-send-email, I've seen that there's no aliases support
> when manually adding a recipient in a 'To' or 'Cc' field in a patch
> and for the --to-cmd and --cc-cmd.
>
> I would like to add this support, and I wonder if there are reasons
> not to do it.
>
> Thanks.

I just realize that I totally messed up, Of course I don't want to add
To or Cc fields to patches.

In fact I want to add aliases support for --to-cmd and --cc-cmd options.
But the modification depends on wheter we can use aliases in fields
used by send-email (such as author or signoff-by..) when manually
editing a patch or not.

Sorry for this mistake :(
