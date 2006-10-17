From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:19:46 +0200
Message-ID: <vpqlknf10u5.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE>
	<vpqejt73vln.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 17 16:21:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpoH-0000t3-La
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWJQOUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJQOUo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:20:44 -0400
Received: from imag.imag.fr ([129.88.30.1]:61911 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751064AbWJQOUn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 10:20:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HEJlWH019791
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 16:19:47 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZpnG-0001vZ-E0; Tue, 17 Oct 2006 16:19:46 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZpnG-0002ea-An; Tue, 17 Oct 2006 16:19:46 +0200
To: bazaar-ng@lists.canonical.com, git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE> (Sean's message of "Tue\, 17 Oct 2006 10\:01\:50 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 16:19:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29079>

Sean <seanlkml@sympatico.ca> writes:

> Ah, okay.  Well Git can definitely manage this.  Just means you have to
> rebase any local changes before pushing.  This will keep the history
> linear and make sure that no merges are needed in the case you were asking
> about.

Sure. As I said before, the little add-on of checkouts is that you say
once "I don't want to do local commit here", and bzr reminds you this
each time you commit. Well, where it can make a difference is that it
does it in a transactional way, that is, you don't have that little
window between the time you pull and the time you push your next
commit. But this would really be bad luck ;-).

> So far, it sounds to me like bazaar and git are more alike than they are
> different.  Each have a few commands the other doesn't but all in all
> they sound very similar.

Sure. And at least, if you want to prove that your decentralized SCM
is the best, you'd better look at features other than the ability to
commit on a local branch ;-). If you want a _real_ flamewar, better
talk about rename management or revision identity.

The thing is that most people migrated from CVS/svn, so they found
their new SCM to be incredibly better the existing. But it's generally
not _so_ much better than the other modern alternatives ;-). (and
don't forget to thank Darcs and Monotone who brought most of the good
ideas you and I are using)

> But i'm a Git fanboy so I aint switching now ;o)

Probably not going to switch either, but that might happen.

-- 
Matthieu
