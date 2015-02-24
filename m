From: Guilherme <guibufolo@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 13:34:19 +0100
Message-ID: <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
 <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
 <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
 <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com> <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: torvalds@linux-foundation.org, gitster@pobox.com, jim@meyering.net,
	l.s.r@web.de, namhyung@gmail.com, Duy Nguyen <pclouds@gmail.com>,
	peff@peff.net, schnhrr@cs.tu-berlin.de
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 13:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQEhn-0007PU-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 13:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbbBXMfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 07:35:03 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:42252 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbBXMfB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 07:35:01 -0500
Received: by wghl2 with SMTP id l2so4974532wgh.9
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6+BWUk9bwuS3QTgxDa/QX7naGGcG5lQMEj6MvMvpIB4=;
        b=Z56lPzH3FUMhuz5Qla4Ik61b89vE511Jwv690q9W8gwP6XN1h4FZDNbrIRamT2LU2m
         Hoqnfu62WRFIBId34sq3XUSGQZinBqNZPVZ5n5FLymfGpwCWbF2de0ZgrKjXKqvyFAtQ
         7hzCv2fqO/01hJnk6yO5VvqqGuZJTecj4OG2RaqwRlfVCQS3BvAmiDSeuiT8K+gWLVXF
         a49bBODVWg22KFEha92KkK62mqORvZHJgksc91ZHWmzOPXLVdMR5TfpOQqj0u7nDpFyf
         a14i0hiCOo8W81prSa+Z5e8QUeb5Q8tMYkcFEUIMpHue5Nw6bVe7WYxYYG6ppvnJ5odj
         cD9g==
X-Received: by 10.194.83.66 with SMTP id o2mr32773571wjy.55.1424781300033;
 Tue, 24 Feb 2015 04:35:00 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 04:34:19 -0800 (PST)
In-Reply-To: <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264325>

This is just an email to all the people i have written in private
about relicensing the files in need in TSS so they can reply to this
email and it be recorded in the mailing list.

The files are part of ctypes.c hex.c git-compat-util.h.

On Tue, Feb 24, 2015 at 1:22 PM, Guilherme <guibufolo@gmail.com> wrote:
> Hello,
>
> I'm writing to you in regards to the files ctypes.c
> which you have modified part of in the git project.
>
> I'm currently working on integrating gitignore pattern matching into
> the_sivler_searcher(http://github.com/ggreer/the_silver_searcher). PR
> https://github.com/ggreer/the_silver_searcher/pull/614
>
> For that i needed wildmatch.c and it's dependencies. That is parts of
> ctypes.c lines 8 to 31.
>
> Unfortunately TSS is Apache licensed wheras git is GPL, those licenses
> are incompatible and thus i ask if you agree that your portion if the
> code is also licensed under Apache2 for the use in TSS.
>
> You can follow the discussion under
> http://article.gmane.org/gmane.comp.version-control.git/264312
>
> Thank you very much,
> Bufolo
