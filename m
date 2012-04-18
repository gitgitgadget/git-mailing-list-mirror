From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stg delete --empty
Date: Wed, 18 Apr 2012 12:03:15 +0100
Message-ID: <CAHkRjk7EH8m09Qx-SH2E1NHARL5yZq9M=mOKrG56LiTUY1ArhQ@mail.gmail.com>
References: <B940726E-2CFA-45CB-8B81-A8F4268D51A6@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stepan Koltsov <Stepan.Koltsov@jetbrains.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSfm-0006XR-FF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 13:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2DRLDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 07:03:37 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51190 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab2DRLDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 07:03:36 -0400
Received: by qcro28 with SMTP id o28so4410205qcr.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+z2tXZOMA/2Py/fGkwv2wjkHSy182Cqe0D0cWXJtd1w=;
        b=bUq/RT9P1I99+q+j0nIszOutb/I864pGMZ4/X0Nv2GQ9iX4SGAsn/bPHPcHb/vvp6T
         5D1dbwXNKo8W9rzlpDH7Cww9iiheAzPjgvNp9MvlslIch02jZSE3XXpxfkwP+KUdCsS3
         P+VHlwmliE1bDgF2PA7WY/GZeyGZAlqptTv4qBXXNw0Lk/j57PJ+YhAUD3kVsFbQkrma
         62Ql4ZecEBY96MKHaVN/gqCdt/g1Cnw9Ip8UiVqDGwtJHv1Rm9MNEaOOf1LLZwD1K4d+
         /MmCeVv6Xh8w03PnWfT0kjWaIREZAdR7sw8mOTCqH7AoED8thiSUD4TVOGU+YZZSdK06
         C2tg==
Received: by 10.229.137.13 with SMTP id u13mr64326qct.90.1334747016008; Wed,
 18 Apr 2012 04:03:36 -0700 (PDT)
Received: by 10.229.75.20 with HTTP; Wed, 18 Apr 2012 04:03:15 -0700 (PDT)
In-Reply-To: <B940726E-2CFA-45CB-8B81-A8F4268D51A6@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195856>

On 11 April 2012 15:12, Stepan Koltsov <Stepan.Koltsov@jetbrains.com> wrote:
> `stg delete --empty` deletes all empty patches in series. Command
> does nothing and exits with zero code if all patches are not empty.

Thanks for the patch but there is already 'stg clean' with the same
functionality.

-- 
Catalin
