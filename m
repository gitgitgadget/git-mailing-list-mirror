From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Tue, 10 May 2016 18:58:56 +0700
Message-ID: <20160510115856.GA1964@lanh>
References: <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
 <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
 <20160427101833.GA5536@lanh>
 <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
 <20160501002852.GA3963@lanh>
 <20160501060009.GA30748@lanh>
 <xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
 <CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
 <CACsJy8DtFLkfqSHRjFU4N9H9C3MfVOn-XEy4yOwneQaatvvDkQ@mail.gmail.com>
 <xmqqposvxlpb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:59:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b06JY-0006SN-K3
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 13:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbcEJL64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 07:58:56 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34152 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbcEJL6z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 07:58:55 -0400
Received: by mail-pf0-f170.google.com with SMTP id y69so5232507pfb.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BuKxy2u+Pabxq0ssfUKIm8lJNlPNpf8A6FEwWgz9RBE=;
        b=SKPwGPOYp1iWdFUvMlV73k2bVaAKcdU0Qa3J51kLXhaF5uX0dCQtYK690ZcupGBswT
         CUVvI44Exx1FwBQBEfCuOuCJIxdiVqtiHGWRh0Yj3kWHkuzLX0y5P7esYjp4q6SNfi99
         qR9tp/or5qhAZ0NNZu511ZvS90Vxk9aGdWDbbydAvPsHxL0KHI0angj9KXjb5bK7aqLP
         2DfnFz8eDySap6BD9rmlt3eCVe+IDTL1P0ynT3AxWTTFaAmp3TJapiGT+PgG+w44xKk0
         wK0EuR/e01yYa/MOSkExDipZUZBib9BspOPcpdBDcKmlaPnWN8Eln6EHHqsHysfYV1Nk
         KVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BuKxy2u+Pabxq0ssfUKIm8lJNlPNpf8A6FEwWgz9RBE=;
        b=aQuWOmD7Zr5z+S7wUjV44UOozayGpKakqmc9OAx2/0lMGQYb5iQyO6B8atkK50Utk5
         ng8tuCudpOrTZEbayWj0whgfFBkN+TXmA9iXZlHZm9ocH0wdhbayKUqNPhahIcYtXM7v
         TbiN4MqrAB4vSvsimGcqE39cX9MCzZBJpOHgDDLrxo0Vx32ycCwCDK/rcvIuJBlY0Jb4
         wl6FfEmLNWr1KU3gXM11cPXXIawPIfntdGiVxVSHLHCCcu+D8HHrGNo7op2GHp3r4jsQ
         P6dszk2351DhLJjRakFcCvnHPjM2RsgmZQDMdiBasOkCusDACtrW2+pZQ2JkadaxCSEy
         VEHQ==
X-Gm-Message-State: AOPr4FUeQcb7GbMVce5AGBL35Alo1OqILsfpBoEnjY0ZuTTwN2GfcO5X3RSTNCnVExP4/A==
X-Received: by 10.98.88.4 with SMTP id m4mr57065225pfb.71.1462881534727;
        Tue, 10 May 2016 04:58:54 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id vg9sm4020313pab.35.2016.05.10.04.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 04:58:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 18:58:56 +0700
Content-Disposition: inline
In-Reply-To: <xmqqposvxlpb.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294122>

On Mon, May 09, 2016 at 09:03:44AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>=20
> > So among the options we have so far, which way should we go, or lea=
ve it as is?
>=20
> Thanks for reminding me.
>=20
> I like that version you sent with "I may have rushed to judgment"
> comment the most.  Perhaps I can just queue it with s/PATH/PROG/
> fixup?

Or a simpler, more-to-the-point patch like this?

-- 8< --
Subject: [PATCH] wrap-for-bin.sh: regenerate bin-wrappers when switchin=
g branches

Commit e6e7530 (test helpers: move test-* to t/helper/ subdirectory -
2016-04-13) moves test-* to t/helper. However because bin-wrappers/*
only depend on wrap-for-bin.sh, when switching between a branch that ha=
s
this commit and one that does not, bin-wrappers/* may not be regenerate=
d
and point to the old/outdated test programs.

This commit makes a non-functional change in wrap-for-bin.sh, just
enough for 'make' to detect and re-execute wrap-for-bin.sh. When
switching between a branch containing both this commit and e6e7530 and
one containing neither, bin-wrappers/*, we should get fresh bin-wrapper=
s/*.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wrap-for-bin.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index db0ec6a..22b6e49 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -17,6 +17,7 @@ fi
 GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLIB}=
"
 GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
+
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
=20
 if test -n "$GIT_TEST_GDB"
--=20
2.8.2.524.g6ff3d78
-- 8< --
--
Duy
