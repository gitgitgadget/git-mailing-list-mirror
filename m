From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: nd/setup
Date: Fri, 9 Apr 2010 08:56:46 +0200
Message-ID: <l2ofcaeb9bf1004082356t2c304902l3f089b701299cec0@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org> <20100408073825.GA15153@coredump.intra.peff.net> 
	<20100408214233.GA32441@progeny.tock> <q2pfcaeb9bf1004082246w3fb6e18bw21943150cbeeb5c7@mail.gmail.com> 
	<20100409055701.GA9554@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 08:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O089T-0005pC-4A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 08:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab0DIG5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 02:57:11 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:58174 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab0DIG5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 02:57:08 -0400
Received: by ewy20 with SMTP id 20so1229776ewy.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E4qBkV19O7Ox0LZRMbNRU+b9bMfwh8ODkPLWQELDb2M=;
        b=LZB8/JvMVqinVgUBYfPuCOjzSPifRiCx9oXPxOTKmZg+WvjG6vm7QcAOtgBf50i74Q
         Z+6cEAPtKbgx1kSqYpV4Zz7jHDLRTC54x2hR58V6/C54K+Ug4GmNwn2K5oKOTg/ZeQT2
         p/IUWC/Fqj/mHGUECFIbQZWdxx5bss4Ak0paQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Q/E+AM3547adznv9D62UbRbOChtMuFlgWvSpKCnTKZODoYV1TXXSul+B1a12NlsDBi
         G7qG1vpry4X9Rsn0/F+s4WuMuosJww8ymW2d4krH5a1E4L9PdSoF1203kA3QpuKQVysh
         GwBQbqaicjsC/uY+W12H3s3ZgaIdOh3rZ6Sfw=
Received: by 10.213.105.130 with HTTP; Thu, 8 Apr 2010 23:56:46 -0700 (PDT)
In-Reply-To: <20100409055701.GA9554@progeny.tock>
Received: by 10.213.55.8 with SMTP id s8mr171390ebg.57.1270796226302; Thu, 08 
	Apr 2010 23:57:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144413>

On Fri, Apr 9, 2010 at 7:57 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nguyen Thai Ngoc Duy wrote:
>> 2010/4/8 Jonathan Nieder <jrnieder@gmail.com>:
>
>>> A few of the earlier patches seem iffy, though they all start with =
a
>>> correct idea.  For example, one of them changes the semantics of
>>> rev-parse --show-prefix without documenting it.  So I have been loo=
king
>>
>> You meant "rev-parse --git-dir"?
>
> I meant --show-prefix.  ad36c84 (worktree setup: calculate prefix eve=
n
> if no worktree is found, 2010-04-05) teaches rev-parse to produce a
> nonempty prefix even when there is no workdir but didn=E2=80=99t upda=
te the
> documentation:
>
>    --show-prefix
>         When the command is invoked from a subdirectory, show the
>         path of the current directory relative to the top-level
>         directory.
>
> I suspect it=E2=80=99s a good change.  Git ought to correctly honor r=
elative
> paths on the command line even when there is no work tree.  But the
> semantics are not clear any more --- when there is no top-level
> directory, what is the prefix relative to?
>
> Probably my other words of warning were also too extreme.  I have bee=
n
> using a copy of git with nd/setup included, and aside from the
> ls-remote problem I mentioned, I haven=E2=80=99t run into any trouble=
=2E

OK. I thought it was expectation and did not check documentation. The
assumption that $GIT_DIR stays at worktree's top directory is still
around.. I'll rethink about this.
--=20
Duy
