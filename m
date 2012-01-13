From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] merge: Make merge strategy message follow the diffstat
Date: Sat, 14 Jan 2012 02:27:01 +0700
Message-ID: <CACsJy8BmFgssTAh=1U7JgBsGG-tSaWXQzZeODND3icXY3QUxug@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <20120111184026.GA23952@windriver.com> <7vaa5rzaax.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlmn3-0007MA-CR
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909Ab2AMT1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:27:35 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53124 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2AMT1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 14:27:33 -0500
Received: by bkuw12 with SMTP id w12so205620bku.19
        for <multiple recipients>; Fri, 13 Jan 2012 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mnmuWfkSz3A/c1tggSWMXbX7CU5z6xEuqc4Fp2Qj2E8=;
        b=V6L7vnRbGX2kiZIZlXu8uUwqbOeMFSH8jVe88OTjMtWLC1yh61QdS9BZ/UwDbmYZ57
         f7/NJ75CwUpl+aLnamGExiN25Ki7NtX1gu+oQDHFbWsm3hlBRLqPRlyHNgVYqx5/B4Ga
         DYzuIYIXmkntXHqsZaebKXFPJ1FKmcwuli2LY=
Received: by 10.204.156.156 with SMTP id x28mr1009237bkw.76.1326482852337;
 Fri, 13 Jan 2012 11:27:32 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Fri, 13 Jan 2012 11:27:01 -0800 (PST)
In-Reply-To: <7vaa5rzaax.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188531>

On Sat, Jan 14, 2012 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>
>> By moving the message after the diffstat, there is a better chance that
>> people will be aware they've done a pointless merge commit.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> I think the goal of the change may be worthy

Still, diffstat from a fetch/pull is sometimes too verbose. It'd be
better if we have something that fit in one screen (dirstat or maybe
just a first few lines from diffstat then ellipsis) then refer users
to "git diff --stat HEAD@{1}" for more detail stat.
-- 
Duy
