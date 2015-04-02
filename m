From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Thu, 2 Apr 2015 07:35:14 +0700
Message-ID: <CACsJy8AkhtG6khb6kcVfV9dZBJH1mnQbcQVC2d5LLbCTSmKTMw@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
 <551B5E64.9070906@ubuntu.com> <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
 <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
 <xmqqh9szn4t3.fsf@gitster.dls.corp.google.com> <CACsJy8Cew0t9EZ5aVSCa-BehWz+ABRhDbtLR2cJ2K9c38QeGsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 02:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdT6s-0003nv-4N
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 02:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbDBAfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 20:35:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34320 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbbDBAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 20:35:45 -0400
Received: by igcau2 with SMTP id au2so40745840igc.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4dJu1MkQps0tcb6IBab4U/A/EpxjQD3rvd2hgFFBB/0=;
        b=Wn98wWuNT/d93VffMoW5PyM/3kgJU/ao/NoXKPml4w2DB3w4teoUBe4eiK2+6xgPK5
         ZHMGlQ8+MygE6ChPaDMbuzt1+tqCnEy/XtmguL2FKevPIAnal+1dJY6xYdNo+1HpuJuc
         I2FZOw3MUR8cDbDK8cEjnjcL39Voxf95BSWa8rouIeNOZ8O7q0MYvHyZgH9mI0StH8uI
         GrtdSh8QcP8WjiVPl2hHOnreeZmXbxFH4ZYYSwdVnLgRB+DX2JEbvYY+BWCL/X1evIP7
         kwDhJmfB0lufbZluqkyvdc3bb02+RUqx5wM5ZqaVr9LxKfYBSyUhAIjPjqL3jOT6VqyA
         OwrA==
X-Received: by 10.107.46.27 with SMTP id i27mr25589955ioo.5.1427934944802;
 Wed, 01 Apr 2015 17:35:44 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 17:35:14 -0700 (PDT)
In-Reply-To: <CACsJy8Cew0t9EZ5aVSCa-BehWz+ABRhDbtLR2cJ2K9c38QeGsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266626>

On Thu, Apr 2, 2015 at 7:33 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> OK two additional options on top of what we already have:
>
>  - save .have and add extra prerequisite SHA-1.
>  - create a bundle that does not hit shallow boundary in the first
> place, roughly speaking it's "max depth minus one". This one does not
> have extra .have or prerequisites

Too fast.. the second option does need extra prerequisites.. Ignore that one.
-- 
Duy
