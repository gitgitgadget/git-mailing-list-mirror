From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git
 am documentation
Date: Thu, 4 Jun 2015 15:26:09 +0200 (CEST)
Message-ID: <316411029.123320.1433424369822.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpq4mmoep9y.fsf@anie.imag.fr> <840759634.89013.1433352813283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 15:26:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0V9n-0003TW-VB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 15:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbbFDNZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 09:25:59 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46368 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081AbbFDNZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 09:25:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8622448862;
	Thu,  4 Jun 2015 15:25:56 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyGj3V9JatVC; Thu,  4 Jun 2015 15:25:56 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6E1114863D;
	Thu,  4 Jun 2015 15:25:56 +0200 (CEST)
In-Reply-To: <840759634.89013.1433352813283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-am.txt: add configuration section in git am documentation
Thread-Index: tlh7BUUWCsXpzzm9aeuwOcgjOgJjhNP5G1DY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270775>

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes
> > > +CONFIGURATION
> > > +-------------
> > > +
> > > +am.keepcr::
> > > +        If true, git-am will call git-mailsplit for patches in mbox format
> >
> > `git am`
> > `git mailsplit`
> >
> > > +        with parameter '--keep-cr'. In this case git-mailsplit will
> >
> > Likewise
> >
> > > +        not remove `\r` from lines ending with `\r\n`. Can be overridden
> > > +        by giving '--no-keep-cr' from the command line.
> >
> > That should be backquote, not forward-quote, right?
> >
> > I know it's not your code since it's a cut-and-paste from config.txt,
> > but that illustrates my point above: we used to have one place with
> > wrong quotes, and we'd have two after the patch.
> 
> Ok I'll correct it in a minor patch

Actually I don't think that this is a good idea to correct
that (since there's many occurences of forward-quoted options in
git-config.txt). I'll just remove the configuration part in
the git am documentation.
