From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Thu, 22 Oct 2009 18:15:16 +0700
Message-ID: <fcaeb9bf0910220415v69c22ed9o4ab85b8858fbf187@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <m3ljj3es02.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 13:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ve9-0004eN-IB
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 13:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZJVLPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 07:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbZJVLPc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 07:15:32 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56755 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbZJVLPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 07:15:31 -0400
Received: by yxe17 with SMTP id 17so6861805yxe.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=30fmylNNjj1PUmxLejcuw3xR3ldxc+gJrvEsBHa8n20=;
        b=qBE9lUDDrhrAQymqIpYba9SQHdyJEqvqFvMeW5zHno7lHzw+Fcv/1lsQc7lPiOu920
         oOh6fe9XWmV75WuCCZCbcL+BzLj0rDujtnUuw959ujJy/rUrK7X+9zIv6lxNZiKhrFex
         qv1LaZliuUmZUjqEuXdmP3K49dfhqa3cw0G/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LgyilgQ24nCmd0veidQdqoUhcDgSjBXvn6IuIg0oQ+kGOwI4mGMOPudLGQPc6c9qeA
         UooLwSXQgJbnLOtFDyYu8ap3z9LpLzlTbXx99kkUXN7nVbRKfUdIeE6dmb8PjAjYAcze
         ao8zyC+dzsBkVXS6BhkJdashoyjH+NsoV1kno=
Received: by 10.100.234.26 with SMTP id g26mr5302447anh.54.1256210136106; Thu, 
	22 Oct 2009 04:15:36 -0700 (PDT)
In-Reply-To: <m3ljj3es02.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131018>

On Thu, Oct 22, 2009 at 3:46 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>> * nd/sparse (2009-08-20) 19 commits.
>> =C2=A0- sparse checkout: inhibit empty worktree
>> =C2=A0- Add tests for sparse checkout
>> =C2=A0- read-tree: add --no-sparse-checkout to disable sparse checko=
ut support
>> =C2=A0- unpack-trees(): ignore worktree check outside checkout area
>> =C2=A0- unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the f=
inal index
>> =C2=A0- unpack-trees(): "enable" sparse checkout and load $GIT_DIR/i=
nfo/sparse-checkout
>> =C2=A0- unpack-trees.c: generalize verify_* functions
>> =C2=A0- unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
>> =C2=A0- Introduce "sparse checkout"
>> =C2=A0- dir.c: export excluded_1() and add_excludes_from_file_1()
>> =C2=A0- excluded_1(): support exclude files in index
>> =C2=A0- unpack-trees(): carry skip-worktree bit over in merged_entry=
()
>> =C2=A0- Read .gitignore from index if it is skip-worktree
>> =C2=A0- Avoid writing to buffer in add_excludes_from_file_1()
>> =C2=A0- Teach Git to respect skip-worktree bit (writing part)
>> =C2=A0- Teach Git to respect skip-worktree bit (reading part)
>> =C2=A0- Introduce "skip-worktree" bit in index, teach Git to get/set=
 this bit
>> =C2=A0- Add test-index-version
>> =C2=A0- update-index: refactor mark_valid() in preparation for new o=
ptions
>
> Hmmm... what is happening with that series?

Junio concerned about CE_MATCH_IGNORE_VALID being used by both
assume-unchanged and skip-worktree bits, which I did not resolve yet.
I should really get back to the series when I have time.
--=20
Duy
