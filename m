From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git
 am documentation
Date: Wed, 3 Jun 2015 19:33:33 +0200 (CEST)
Message-ID: <840759634.89013.1433352813283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpq4mmoep9y.fsf@anie.imag.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 19:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CXk-0006jN-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbbFCRd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:33:29 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40360 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753432AbbFCRd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 13:33:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 81A7848853;
	Wed,  3 Jun 2015 19:33:24 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67dGo2wHbM-q; Wed,  3 Jun 2015 19:33:24 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 693CD487BA;
	Wed,  3 Jun 2015 19:33:24 +0200 (CEST)
In-Reply-To: <vpq4mmoep9y.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-am.txt: add configuration section in git am documentation
Thread-Index: tlh7BUUWCsXpzzm9aeuwOcgjOgJjhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270705>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes

> Most git-*.txt do not have this CONFIGURATION section.
> 
> In an ideal world, we would have such section automatically generated
> (i.e. the description for each variable would exist in one place, and we
> would make sure that both "man git-config" and "man git-<command>" show
> it). In a really ideal world, it would also be propagated to the code
> and we would have a "git config --describe am.keepcr" or so that would
> return the doc.
> 
> I'm a bit worried to see documentation cut-and-pasted from config.txt to
> git-*.txt for maintainability: if the text on one side is modified,
> we're likely to forget the other and the text will diverge with time.
> 
> Not a strong objection, but I have the feeling that the more we do this
> kind of patches, the harder it will be if ever we decide to do the above.

I've seen occurences of this (mainly git-rebase.txt and
git-grep), but I agree, I think I'll remove the configuration
section.

> > +CONFIGURATION
> > +-------------
> > +
> > +am.keepcr::
> > +        If true, git-am will call git-mailsplit for patches in mbox format
> 
> `git am`
> `git mailsplit`
> 
> > +        with parameter '--keep-cr'. In this case git-mailsplit will
> 
> Likewise
> 
> > +        not remove `\r` from lines ending with `\r\n`. Can be overridden
> > +        by giving '--no-keep-cr' from the command line.
> 
> That should be backquote, not forward-quote, right?
> 
> I know it's not your code since it's a cut-and-paste from config.txt,
> but that illustrates my point above: we used to have one place with
> wrong quotes, and we'd have two after the patch.

Ok I'll correct it in a minor patch
