From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Documentation: talk about pager in api-trace.txt
Date: Thu, 3 Mar 2016 10:17:49 +0100
Message-ID: <CAP8UFD38odsz=fwE9E+0fVJXFE-4vwL1vTQT0rshyCAUYO1fcw@mail.gmail.com>
References: <1456755680-4335-1-git-send-email-chriscool@tuxfamily.org>
	<20160229213152.GC25342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 10:18:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abPOd-0000tR-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 10:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbcCCJR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 04:17:58 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35735 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbcCCJRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 04:17:51 -0500
Received: by mail-lb0-f182.google.com with SMTP id bc4so15786691lbc.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=g9NdDeLhz7DdggUsX6X6pRdaomaBWw+nbj8YRuW1dpM=;
        b=fViR+Ch4Xr65TrFJkl0Ss7CbC9DREL5Z/Q/XuWhrXoHgyTaBzuCv8VDTp1647/OwxG
         WqqbPdC9YmSGxdygOs6nz7jJVp32OBmU5HafBmWRUpbKL0k444BqSv1+1+roz5CWrHFg
         8hCjs5z5SFSJFydigfsy53TUkwaMJzNSOk55vZyoYu+T554eRL2e/OuhncxaZjpTxqts
         khpoFa3cl6qgRc0sA/TRvZIM36n3Mcz5xyvwm2NqZC0pVL08oJaDjI4wpTvaP37lbMr+
         qUcJip4bKpqLd+5BOTFk9cYRiRTupUvnylUwMMUgg+d7Fsdb/qO4h2i9cULZXlKySYuh
         DfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=g9NdDeLhz7DdggUsX6X6pRdaomaBWw+nbj8YRuW1dpM=;
        b=I6/IvlzR4knzP6of6ZviXuUjTszC/dy2bOmbTnfBkGujevMp3vH9ZAZUsyq65G2c8D
         eiZT3ikNZHyAR4236YD/yVwBnSt4hwpqzNN9tAKy4qlJZMrtJ2Xa+N1Uuq2bAy65mfLr
         8RIj1npcITai2/JaivAhD7PXMQoA8eLYaLENEEBH/tpBiq6zUV5kY1Xl0trKSBGVr+pR
         +rd8OGCeauTo2bicUITBrn5j4v41Txh66Ju0zW2nDG4kXiDkOoAi1qbZlKTFdJhdK/2r
         UoGuUopQXCFvSoeoVg411w3fi8IdBGca0YeKkmXfadLqLQjxHPD5qjkGm5cmxgGNx2DX
         Y2Qw==
X-Gm-Message-State: AD7BkJKL+qzmVS2bhixxRBIPvmWttNh51eowcEmLYu2fn0doqoPJNNsiCH4uMGAvwKL9iMLMJpFEOJFZMtYjuQ==
X-Received: by 10.112.128.225 with SMTP id nr1mr550771lbb.101.1456996669758;
 Thu, 03 Mar 2016 01:17:49 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Thu, 3 Mar 2016 01:17:49 -0800 (PST)
In-Reply-To: <20160229213152.GC25342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288169>

On Mon, Feb 29, 2016 at 10:31 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 29, 2016 at 03:21:20PM +0100, Christian Couder wrote:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/technical/api-trace.txt | 43 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>
> I think this is fine. I'm not sure how many people would look at the
> technical/api documentation in such a case, but I don't think it hurts
> to document this stuff.

Yeah.

Junio do you plan to merge this patch or would you prefer something like:

+
+Bugs & Caveats
+--------------
+
+Some git commands, like `git log`, are run by default using a
+pager. In this case, stdout and stderr are redirected to the pager and
+are closed when the pager exits.
+
+If a GIT_TRACE* environment variable has been set to "1" or "2" to
+print traces on stderr, no trace output will be printed after the
+pager has exited.
+
+This can be annoying, because GIT_TRACE_PERFORMANCE by default prints
+the performance stats for the whole command at atexit() time which
+happens after the pager has exited.
+
+So the following command will print no performance stat:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git log -1
+------------
+
+To overcome this problem, you can use for example:
+
+------------
+GIT_TRACE_PERFORMANCE=2 git --no-pager log -1
+------------

?
