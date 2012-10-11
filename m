From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push.default documented in "man git-push"?
Date: Thu, 11 Oct 2012 16:18:41 +0200
Message-ID: <vpqhaq13xdq.fsf@grenoble-inp.fr>
References: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
	<CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
	<CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
	<CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
	<CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
	<7vvcer4chm.fsf@alter.siamese.dyndns.org>
	<CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
	<7va9w23i45.fsf@alter.siamese.dyndns.org>
	<CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
	<7vmx00u1nz.fsf@alter.siamese.dyndns.org> <20121011124326.GA30589@do>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMJbu-0002db-8w
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 16:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab2JKOT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 10:19:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48544 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab2JKOT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 10:19:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q9BECmYX006136
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 11 Oct 2012 16:12:48 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TMJb0-0003uC-2d; Thu, 11 Oct 2012 16:18:42 +0200
In-Reply-To: <20121011124326.GA30589@do> (Nguyen Thai Ngoc Duy's message of
	"Thu, 11 Oct 2012 19:43:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 11 Oct 2012 16:12:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9BECmYX006136
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350569573.42793@DUhnX/83oEKRnXGnzHdIHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207477>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Oct 05, 2012 at 01:03:28PM -0700, Junio C Hamano wrote:
>
>> OK, the messages are supposed to advise how to turn them off, so we
>> would want some code updates in that case.
>
> Something like this? It turns out none of the advice messages says
> anything about advice.*.

Personally, I'm fine with the current situation. Advanced users can read
the documentation, and for others, the messages are usually more helpful
than annoying.

> This patch makes many output more verbose/annoying,

For example, it makes the output of git status look like:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#   Set advice.statusHints to false to turn off this message
#
#       modified:   foo.txt
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#   Set advice.statusHints to false to turn off this message
#
#       modified:   foo.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#   Set advice.statusHints to false to turn off this message
#
#       bar.txt

I think it's going really too far in verbosity, the actual information
is hidden by the advices.

> (which is good, more motivation to turn advice off).

I disagree. Having advices turned on doesn't harm anyone. I don't
remember anyone complaining about the verbosity of Git's advices. I've
seen *many* more people complaining about the user-unfriendliness of
Git.

I'm fine with very verbose (and scary) messages when the user did
something wrong (for example, the advice.implicitIdentity is something
you should never see if you configured Git properly before commiting).
But the user should not feel blamed for using the default configuration
of advice messages. The tripple repetition in "git status" shown above
really sounds like "hey, dumb user, why did you not set
advice.statusHints already", and is doubly scary for newbies, because
they are not told how to set the variable, nor what a config variable is
to Git.

I understand the motivation of making the advice.* section of "man
git-config" more easily discoverable, but then picking a reasonable
subset of the advice messages (e.g. places that are already verbose
anyway, and not places that total beginners would see on a daily basis
like "git status") would be much better than targetting exhaustivity
IMHO.

> @@ -89,7 +90,9 @@ void detach_advice(const char *new_name)
>  	"state without impacting any branches by performing another checkout.\n\n"
>  	"If you want to create a new branch to retain commits you create, you may\n"
>  	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
> -	"  git checkout -b new_branch_name\n\n";
> +	"  git checkout -b new_branch_name\n"
> +	"Set either advice.detachedHead to false to turn off this message\n\n"
             ^^^^^^

Wrong cut-and paste from "... either XXX or YYY ..."? (repeated several
times below).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
