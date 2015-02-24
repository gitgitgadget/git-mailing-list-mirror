From: Guilherme <guibufolo@gmail.com>
Subject: Fwd: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 09:08:42 +0100
Message-ID: <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:09:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQAYb-00008f-GU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 09:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbBXIJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 03:09:24 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42257 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbBXIJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 03:09:23 -0500
Received: by wghl2 with SMTP id l2so3584451wgh.9
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=de07kfDSlgc/Tr4fg5I6/3Lmarz9C+4jUFWleLhOaKs=;
        b=arprU3D12lzJHMk5XC0Afd5PYmxMIsJDPpuiB3tGUWq7Gl57Utjn9EdtDcid5cO9Dx
         SmUSwRHn/qp/txCV3P7F6IlE9cHONvVRwBwiQ36s5aB6noIkEG1lk+ATznWvJ7B344QV
         +bzKGnNx3h5vvkFp14AOenGtRvRaSTX/1V4f7WRfJZJc1Bj0tSyaKpRsw4O6VkTVI/w2
         X7Q2uZ0NoEBoiI0iNduhm6+R5dDTi9EyUVpuIAlmabiNbXgwyxOT2z5c3YaI94Yshyzt
         IURaNmb9Xm7AU8Sin52rV0YXcApvMLvadoR2S18VM647g7+vhOQ51BBAzeAmNRxj5CiY
         W5DA==
X-Received: by 10.194.2.43 with SMTP id 11mr30346744wjr.104.1424765362530;
 Tue, 24 Feb 2015 00:09:22 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 00:08:42 -0800 (PST)
In-Reply-To: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264312>

Hello,

I have already posted this to the users mailing list but i guess it's
more appropriate to have it here.

---------- Forwarded message ----------
From: Guilherme <guibufolo@gmail.com>
Date: Tue, Feb 24, 2015 at 9:02 AM
Subject: Copyright on wildmatch.c
To: "git-users@googlegroups.com" <git-users@googlegroups.com>


Hello,

I'm trying to implement support for gitignore files in
the_silver_searcher (https://github.com/ggreer/the_silver_searcher).
It is a source code optimized version of grep. And it is way faster
than ack.

The problems at hand is that I'd like to use wildmatch.c and some
dependencies (hex.c, some portions of compat-util.h) but it seems that
git is GPL whereas tss is Apache2 licensed.

Is there any possibility to re-license the files above to Apache2 for
the TSS project?

If not, is there any c library that provides support gitignore patterns?

Thank you very much,
Bufolo
