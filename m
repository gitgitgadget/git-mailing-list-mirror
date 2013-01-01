From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/7] format-patch --reroll-count
Date: Tue, 1 Jan 2013 10:04:36 +0700
Message-ID: <CACsJy8D5Ch2W-tfV6+UuyEzxtL_5E3rkffnZc5AO9yrMDJsaXQ@mail.gmail.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 04:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpsAS-0005iW-3B
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3AADFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:05:09 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55637 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3AADFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:05:07 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so12082610oag.2
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 19:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EpH0t/3Rh8PzLxKtdXkR+f5MZF/ev9ERzTjqqbeLsh0=;
        b=x0YR38Wl2q1U24ZtcVTWupW17nGD9aGfQR7Yj8mUrImIAu39Wmj4mU2QkoHY2DSERL
         CntkLceSqZu1Ki8fxd6+KYydHEDpc1By/EHCLkniDkzuctuj/kbMp6RvStldX9qx68tq
         lTflZvHd10mwQlVR/XmP0y8E5QOysV0EyMZPA96RZBATCsifeG0pWxz/Fv0DDUYC1XBe
         0eNLCsIdj4+PB+Niq52mvoncbdHRxK8zp6r8IGK51Wz67i207uGed380IDv8vegO2d3N
         9it6+KjsPBopDOYLVcXNXZp6sRYhXCOMjvL3hhhtOewCn5zBKZwca/GCCQiL61H9V0XX
         rzUg==
Received: by 10.60.32.44 with SMTP id f12mr24368259oei.61.1357009506665; Mon,
 31 Dec 2012 19:05:06 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 31 Dec 2012 19:04:36 -0800 (PST)
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212397>

On Sat, Dec 22, 2012 at 3:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The --reroll-count=$N option, when given a positive integer:
>
>  - Adds " v$N" to the subject prefix specified.  As the default
>    subject prefix string is "PATCH", --reroll-count=2 makes it
>    "PATCH v2".
>
>  - Prefixes "v$N-" to the names used for output files.  The cover
>    letter, whose name is usually 0000-cover-letter.patch, becomes
>    v2-0000-cover-letter.patch when given --reroll-count=2.

On the same subject of format-patch improvements, perhaps we should also:

   - Keep subject line in branch.%s.description too. No point in
     keeping writing the subject on every reroll.

   - Perhaps an option to save the current tip in reflog with reroll
     count so one can easily diff between two rerolls.
-- 
Duy
