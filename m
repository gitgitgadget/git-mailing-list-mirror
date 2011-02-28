From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 11:05:09 +0100
Message-ID: <vpqr5aslbje.fsf@bauges.imag.fr>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
	<4D68D630.9000608@drmicha.warpmail.net>
	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>
	<4D6B5D09.8010806@drmicha.warpmail.net>
	<vpqwrkkpkea.fsf@bauges.imag.fr>
	<4D6B6F97.8030409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 11:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu01s-0001a6-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab1B1KIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 05:08:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:44388 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab1B1KIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 05:08:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1SA59Zc026809
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Feb 2011 11:05:11 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PtzyX-0003VK-Ls; Mon, 28 Feb 2011 11:05:09 +0100
In-Reply-To: <4D6B6F97.8030409@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 28 Feb 2011 10:49:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Feb 2011 11:05:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168096>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Matthieu Moy venit, vidit, dixit 28.02.2011 10:40:
>
>> # let's see what happens ...
>> $ git add
>> $ 
>> # ok, nothing happened ...
>> # continue hacking without noticing that a bunch of files have been added.
>
> No no, I said "add" would default to what "-u" does now (see below).

Right, that less disturbing than I wrote (but still potentially
disturbing)

>> Mercurial has taken the other way, making "hg add" add everything by
>> default, and some users do complain:
>> 
>> http://osdir.com/ml/version-control.mercurial.general/2007-08/msg00316.html
>
> Since when do we care about them (as in "hg", not in "users", mind
> you...).

If you don't care about experiences of others, I can do nothing for you.
I don't have a crystal ball, so I can't say what Git users will say
about a given feature, but I can look around me (I'm sure you can too)
and see how it went for other people.

>> If you change this for Git, you'll have people complaining about
>> backward compatibility plus people complaining about least surprise :-(
>> 
>>> - "add" should be about tracked paths by default (default pathspec "."),
>
> See, here!
>
>>>
>>> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
>>>
>>> - "-A,--all pathspec" (default pathspec ".") be about tracked and
>>> untracked paths (whether add or commit).
>> 
>> Today, "git add ." adds new content in tracked files, and new files, but
>> doesn't notice files deletions. Did I miss something, or is there no way
>> to do that with your proposal?
>
> What in
>
>> That would need a proper migration
>> plan etc., and some thinking about -i/-o. Just brain-storming.
>
> reads "proposal" to you?

What's wrong with you today? Miles asks a honnest question and gets a
dissertation about the netiquette, I ask another question, mention the
experience of other people and get this.

I did read "brainstorming" in your email, tried to brainstorm with you,
but you're not making it easy to us. I'm stopping here, sorry for
disturbing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
