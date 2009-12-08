From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2009, #03; Tue, 08)
Date: Tue, 8 Dec 2009 17:20:59 +0700
Message-ID: <fcaeb9bf0912080220s5a999226i944d2e3646b34d49@mail.gmail.com>
References: <7vmy1tg6ll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 11:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHxC9-0001XC-AV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 11:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZLHKVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 05:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZLHKVN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 05:21:13 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:35738 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZLHKVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 05:21:12 -0500
Received: by pzk26 with SMTP id 26so4592791pzk.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dIXdBKWjxLR1Bh2YXQt6/JdJnNHr53aT5fRxStc/jgg=;
        b=CB5d7/Uq5FEE4hbOiI7px/9Fmzdu3gg+7+3omCJnbwOYexD3OxsJdf6JqHfCFBSQ+6
         tZW6PmjTVMzhHCOp5Sv7FvYCYHW3klgHPrCWMfVTFbzTng9vRRfzXj5vjvREJCt1ccxI
         dIkpp4XZ0xYxL+/KCIeN6DUZg0PozpxmI37ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pweV9RXQkefNfOwsqdwP13gQPzUptS3IYTLDo2in9HOzehqE/+MOhe8Uop+iFW0tBI
         mveI+LHodEBV6AWanRdGEHuqpqWO6U+oxfLOTPVT1zKMmnoPeSnXde1BHOtkYU6dWbI6
         ooO162i1NnrvBjRPfnhk+eNiRrM0hTuL9qHDc=
Received: by 10.115.114.5 with SMTP id r5mr14653312wam.145.1260267679214; Tue, 
	08 Dec 2009 02:21:19 -0800 (PST)
In-Reply-To: <7vmy1tg6ll.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134853>

On Tue, Dec 8, 2009 at 4:25 PM, Junio C Hamano > * nd/sparse
(2009-11-25) 20 commits.
> =C2=A0(merged to 'next' on 2009-11-25 at 71380f5)
> =C2=A0+ tests: rename duplicate t1009
> =C2=A0(merged to 'next' on 2009-11-23 at f712a41)
> =C2=A0+ sparse checkout: inhibit empty worktree
> =C2=A0+ Add tests for sparse checkout
> =C2=A0+ read-tree: add --no-sparse-checkout to disable sparse checkou=
t support
> =C2=A0+ unpack-trees(): ignore worktree check outside checkout area
> =C2=A0+ unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the fi=
nal index
> =C2=A0+ unpack-trees(): "enable" sparse checkout and load $GIT_DIR/in=
fo/sparse-checkout
> =C2=A0+ unpack-trees.c: generalize verify_* functions
> =C2=A0+ unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
> =C2=A0+ Introduce "sparse checkout"
> =C2=A0+ dir.c: export excluded_1() and add_excludes_from_file_1()
> =C2=A0+ excluded_1(): support exclude files in index
> =C2=A0+ unpack-trees(): carry skip-worktree bit over in merged_entry(=
)
> =C2=A0+ Read .gitignore from index if it is skip-worktree
> =C2=A0+ Avoid writing to buffer in add_excludes_from_file_1()
> =C2=A0+ Teach Git to respect skip-worktree bit (writing part)
> =C2=A0+ Teach Git to respect skip-worktree bit (reading part)
> =C2=A0+ Introduce "skip-worktree" bit in index, teach Git to get/set =
this bit
> =C2=A0+ Add test-index-version
> =C2=A0+ update-index: refactor mark_valid() in preparation for new op=
tions
>
> There were some test glitches reported and at least one test seems to
> be broken in the sense that it is not testing what it is trying to.
> Fix-up expected.

Indeed. I'm working on it. Hopefully I'll have something in the next fe=
w days.
--=20
Duy
