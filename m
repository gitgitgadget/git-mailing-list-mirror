From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 0/2] teach git pull to handle --log=<n>
Date: Fri, 15 May 2015 19:15:19 +0800
Message-ID: <CACRoPnQ6cH2w=4DRcq+aPGz2ahRaU3Lnabgi5EbAC8BVRPHgzg@mail.gmail.com>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
	<xmqqd22384om.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 13:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtDaT-00063D-I2
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 13:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbbEOLPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 07:15:25 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36264 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbbEOLPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 07:15:21 -0400
Received: by lagv1 with SMTP id v1so114183113lag.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SRjnM+WSLaq0bJgIuQ5AvSODtC+x3ahdGSAyiSTIL8E=;
        b=kLqEAU9SI2sZ37rrWbAL9d2A8dXZHYDn7taC8ABis5n3LVvYX19+66r1FC5G5bhUZg
         WlQ74dgDBmw3SU+gNNcQjJfaxZVPR4ijqqigw2CbR63Uo9gSk+chPMHaaNCRikzxOCmk
         F7HfIykuZ6yUIPm0LIOGD9tzCIll34Fk43T4qRaABa5Z2jxyOGz8v0W/Pvyi1MBcpxPB
         hL6Gq7OOjcgvjLmN/LBo1W7Pj39TWWckrYwdCdZ5Ko1URRiR8EAP4xEqhED35MBjT6Rc
         vn41n9xeRk2sDX8X/WtLRc58OguVzBLQ+9o959V668gg12w7lozvZ2IMMjh1LJnQMGsb
         4nwQ==
X-Received: by 10.152.4.72 with SMTP id i8mr6976847lai.32.1431688519548; Fri,
 15 May 2015 04:15:19 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 15 May 2015 04:15:19 -0700 (PDT)
In-Reply-To: <xmqqd22384om.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269139>

Hi,

On Fri, May 15, 2015 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> One advice; for a small patch like this one (and the "pull.ff vs
> merge.ff" one, too), it is not necessary or even desirable to do a
> two-step "first add a failure test and then another patch to fix and
> flip the expectation" series.  Just do the fix and add a test to
> expect success.
>
> After all, the primary reason why we add test is *not* for you to
> demonstrate that what you did works as expected.  It is to catch
> other people breaking what you did in the future.

Since I will be re-rolling all the patches to remove the use of
"verbose" I guess I will squash the patches as well.

Thanks.
