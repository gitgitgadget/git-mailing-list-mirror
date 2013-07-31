From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 23:08:21 +0200
Message-ID: <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<1375300297-6744-2-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:08:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ddQ-00039x-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760858Ab3GaVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:08:31 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:44558 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760851Ab3GaVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:08:29 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so669317qcx.11
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/WPtH3k7phzwYUgmg2hQDULHlfIYSN57Lzrw3wgal+Q=;
        b=iN15pAWlHtC03BHd+e4Ou9H957cmVxHY57aGR4/a0P+AC0aEk5VfSwv5EkXtoR4vOZ
         SVusVnYUY2M+R9pxUDbVRzVDI3LrmbcUCFipcCwlatw5dtCnAIzm1pHvR3NAgJaoGxjT
         /ENKwwyW50qPM1rasWzG+dntkgqbdqYPECfb60aCAKq9JzmCX+WCA9gm1Cmp+b6rsduk
         io7ZJqq3RDKMMtnZCCVg//VTDsIlZHCQ5MyCWD3GLG4ITbs85qR8sKILBrzUHRkX8v8v
         xlOPRJp3ZctYHf6ZV2fmnj2Rpe4KOymchd4YHPB0vqXGcBkocg9yiXscTOYOthZpCMe9
         ArNA==
X-Received: by 10.224.54.210 with SMTP id r18mr25522qag.62.1375304901825; Wed,
 31 Jul 2013 14:08:21 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Wed, 31 Jul 2013 14:08:21 -0700 (PDT)
In-Reply-To: <1375300297-6744-2-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231462>

On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com> wrote:
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------

I'm certainly not a lawyer, and I'm sorry for not reviewing the
content of the patch instead, but is that not a problem from a legal
point of view ?
I remember a video of Greg Kroah-Hartman where he talked about that
(the video was posted by Junio on G+).
