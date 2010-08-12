From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Wed, 11 Aug 2010 23:47:34 -0600
Message-ID: <AANLkTinvWO_OakFbuHWrRWYCg4bvHuVPu8=d0_y5o0Ws@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 07:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQdi-00071S-Av
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab0HLFrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 01:47:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65288 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab0HLFrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 01:47:36 -0400
Received: by bwz3 with SMTP id 3so626927bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3zepWGE9xC4KOakFMExJ3jCAmEw/0zBPOaf3Oiy9EL4=;
        b=DhGLy/fLBqbRP9DP1+OuvkFMTZQhdOSs1nYB+180zNyqlFSp3uHutJ+Zim6VB/KJPb
         o8Rui3H/KOnrnuh1FHjsFsPjvFqioj40sLJvrVK7wVVqPWp5MeE2Pn4HADcEfZpe11XB
         krXruP4q88fpB4mX6Ozs1cmUe+jqKaMy/tdBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wkp1DVF7+nz0nW4yXb+TkaB5K4Fksbjp534CWacvopq2Ix6Xr/I/Lz9xAMgUGp4GF5
         1oxegYir3Nr3FSWo6magqh+a/8fLS8nHybKTWXEczTM6P9BWfP08u0GIPibmpg6NHdLY
         atYM5kaELGTX353eac+rVaDBRIWldYBQ85P9w=
Received: by 10.223.122.6 with SMTP id j6mr21052124far.78.1281592054825; Wed, 
	11 Aug 2010 22:47:34 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Wed, 11 Aug 2010 22:47:34 -0700 (PDT)
In-Reply-To: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153340>

Hi,

On Wed, Aug 11, 2010 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * en/rebase-against-rebase-fix (2010-08-06) 2 commits
> =C2=A0- pull --rebase: Avoid spurious conflicts and reapplying unnece=
ssary patches
> =C2=A0- t5520-pull: Add testcases showing spurious conflicts from git=
 pull --rebase

It looks like you pulled my original submission, despite the fact that
you commented on v3 of the series.  Granted, everything after v1 was
just commit log wording changes and testsuite fixups, but I'll resend
to make it easy for you to grab the latest.

> * en/fast-export-fix (2010-07-17) 2 commits
> =C2=A0- fast-export: Add a --full-tree option
> =C2=A0- fast-export: Fix dropping of files with --import-marks and pa=
th limiting
<snip>
> * en/d-f-conflict-fix (2010-07-27) 7 commits
> =C2=A0(merged to 'next' on 2010-08-03 at 7f78604)
> =C2=A0+ t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
> =C2=A0+ fast-import: Improve robustness when D->F changes provided in=
 wrong order
> =C2=A0+ fast-export: Fix output order of D/F changes
> =C2=A0+ merge_recursive: Fix renames across paths below D/F conflicts
> =C2=A0+ merge-recursive: Fix D/F conflicts
> =C2=A0+ Add a rename + D/F conflict testcase
> =C2=A0+ Add additional testcases for D/F conflicts

Out of curiosity, is there anything preventing these two series from
advancing?  I was particularly hoping that the fix (first patch) in
the en/fast-export-fix series would be applied to maint; Sverre seemed
to agree -- http://article.gmane.org/gmane.comp.version-control.git/151=
046.
 If it's just time, I understand, I was just curious if there was
anything I could or should do to help these series (or the new
en/rebase-against-rebase-fix one) along.

Thanks,
Elijah
