From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: short cuts for git add /diff etc
Date: Tue, 04 Sep 2012 11:03:38 -0700
Message-ID: <7vehmhbr7p.fsf@alter.siamese.dyndns.org>
References: <6110218480.20120904152542@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJywnYCdfJ24nXCdgJ1MbKEIgGyRCJyYnUydUJ1YnXydaGyhC?=
	 =?iso-2022-jp?B?GyRCJ1sbKEI=?= <kes@reg.ru>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8xTa-0004hh-9N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab2IDSDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757423Ab2IDSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D08D8C21;
	Tue,  4 Sep 2012 14:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2M8jJOoniyLTBLc+vyElgWIGzI8=; b=ozR16U
	B4RG/JmpnP85n/Q5gPSuGBYwFw7PqZdXI3auvCtL/KOwUy0cJLKw/t0IZEsS/CbY
	F8dEfx3HEluejxHnpfq6vwTsZEUg72a0/uK5IWKX2HF4VQh9zflv6iJWFDlGDAyS
	9KinNfdy+6xaCbsvGeTbXwvbkmoyUurjDP3VY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sixebeIjsBXMyvdXwdEA5rY+ReLuIdW+
	dZ0zF/2ZKVYQtqyez1SHsOyqh8L0fXzFHm2kIYRksha7et327Ss5NilZUV1D2tEt
	BBchHgfgTEYatau9avmcwedFkHDT1afRNyyrKLZ+q9VJ7y7lvJ+YcuPivC/daR30
	g6UUdNEcv0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A1CB8C20;
	Tue,  4 Sep 2012 14:03:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72CC28C1E; Tue,  4 Sep 2012
 14:03:40 -0400 (EDT)
In-Reply-To: <6110218480.20120904152542@reg.ru> (=?iso-2022-jp?B?Ig==?=
 =?iso-2022-jp?B?GyRCJywnYCdfJ24nXCdgJ1MbKEIJGyRCJyYnUydUJ1YnXydaJ1sbKEIi?=
 =?iso-2022-jp?B?J3M=?= message of "Tue, 4 Sep 2012 15:25:42 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB800CF8-F6BA-11E1-B5A9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204758>

Коньков Евгений <kes@reg.ru> writes:

> # git status
> # On branch yandex_mail_new_api
> # Your branch is ahead of 'origin/yandex_mail_new_api' by 2 commits.
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified(1):   a1.txt
> #       modified(2):   a2.txt
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #   (3)    new.txt
>
>
> sot this allow:
> git diff 1       same as        git diff a1.txt
> git diff 2       same as        git diff a2.txt
>
> git add 1        same as        git add a1.txt
> in case there are may be files with such names I may appply option -s,for example
> git add [ -s | --stage ] 1 . This will force to add file from list of
> 'git status' and do not use '1' as file name.
>
> git add 3        same as         git add new.txt
>
> This very handy and will keep developer from useless typing =)

When I know I want to add a1.txt, I can say "git add a1.txt", but
with your version of Git, I now have to say "git status" to first
find out what file number a1.txt corresponds to so that I can say
"git add 1"?  Worse yet, after saying "git diff 1" to check the
progress of a1.txt, which may be long and scroll the output from
"git status" off the top of my screen, I need to run "git status"
again to see what file number a2.txt corresponds to?

That does not make any sense even as a typesaver.  Besides, what if
I have a file whose name is "1" that I would want to add?

You may be looking for either "git gui", or "git add -i" (if you do
not like a windowed environment), both of which would let you choose
pathnames with fewer keystrokes.
