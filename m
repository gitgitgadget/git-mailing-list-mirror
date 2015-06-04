From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Fri, 5 Jun 2015 00:00:09 +0200 (CEST)
Message-ID: <1513043597.139303.1433455209117.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr> <CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com> <CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Allen Hubbe <allenbh@gmail.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 00:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0dBC-0007qm-2U
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 00:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbbFDV75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 17:59:57 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42669 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374AbbFDV74 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 17:59:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DC9BE4886B;
	Thu,  4 Jun 2015 23:59:53 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4eYybP7zfoV; Thu,  4 Jun 2015 23:59:53 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C28663604;
	Thu,  4 Jun 2015 23:59:53 +0200 (CEST)
In-Reply-To: <CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: send-email aliases when editing patches or using --xx-cmd
Thread-Index: EIXTOCf07S4PFicbrApKjodv9kgz4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270801>

> On Thu, Jun 4, 2015 at 5:11 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
> > <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> >> Working on git-send-email, I've seen that there's no aliases support
> >> when manually adding a recipient in a 'To' or 'Cc' field in a patch
> >> and for the --to-cmd and --cc-cmd.
> >>
> >> I would like to add this support, and I wonder if there are reasons
> >> not to do it.
> >
> > Just recently Allen Hubbe did work on alias support,
> > I did not follow that topic though.
> 
> Allen's patch added support for another aliases format file but is
> unrelated to Remi's proposal and would not conflict with it.

Yes, I have read and applied the patches, this does not seems to be a
problem.

Thanks
