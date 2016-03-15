From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Wed, 16 Mar 2016 02:48:53 +0530
Message-ID: <CAFZEwPN_OTDxHpYvO2VfZEf5fG0X8fefU65XiLFy0Lt2Fs8Hbg@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
	<CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
	<CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
	<xmqqlh5j7am8.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOK1hH8CuFc6TohDc5xq7GXpp0DBnQi4QQ6m+8dspUbeQ@mail.gmail.com>
	<xmqqh9g77879.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:19:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwMl-0006q7-1E
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbcCOVS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:18:56 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35902 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcCOVSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:18:54 -0400
Received: by mail-yw0-f179.google.com with SMTP id g3so37945183ywa.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kUJn6aS6nFS+fAu+XCbfsAQQyei8P7geBGAPx+0iOtM=;
        b=VGhNEItJVlPWLQSlxW8yLaMbTKH1RV1rfpbDxB/2xVkB76pDRrl3TYGIAshD527LHI
         LSLUXpvpH1j03QFs9Gh9DbdwWmJZLWWuC90zIHzt0Ho5ES0eWaD9shNjHnBeTnOEW8dA
         euwk9Fy/blWKCMKzWkjvJiyvMyqlWa5ItV37MC6wBxi6tcZrveLKFhzRPOMVmXmngiPd
         AtX2XSb9G1VIMdXOMX9ParWCRghx1CcXrU6MQCIGnbXzYxPKpJyB7TmOXz/JP9fS5HBM
         pLT6UlDi9SVXElKAv8Fr5WQcjPdyozB/6uO8RSD+e8Vpxo3Xc8EWsYVZkKHDvkLLbipR
         33Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kUJn6aS6nFS+fAu+XCbfsAQQyei8P7geBGAPx+0iOtM=;
        b=TLAuqhfVcn+krVDVK8GvJ4d4D2UZ/8hRZsWedPKw+0TjP9vyhVnrMxe4rqbiNyLG3T
         l1lPXpIsw2VVX6FFg+eKYQSSGnsYZe5hrg7KwbYihUwwUzlTZYwK+FKCXb7jSu/+KE7+
         Bw6McJj1kSRviGtKnpsz3HKxqdKXB5gc8utG8jkYvQJkYiwsd59Ja/H8wP1q0c7vFM8K
         z2V0FXDTIiAtDoFJTyAAWq0StUG6LCVD5LbvUdFsDt8SxO6vVTI5dASle5x1Y4cRgpPr
         AnM4GGkOp3w11WvkOztK5Cz3oIVfJ6KXwmgLAs44tY3h/jI8843QwK9/cK/6SW4xIaG1
         PHZQ==
X-Gm-Message-State: AD7BkJIOTNdmrPbV3crRHeqGzpRO1lQ05PBAFTDgDIQRNmexoim74O/KvL19B3xEeO5zySib1AyR1ViE142bdw==
X-Received: by 10.37.89.138 with SMTP id n132mr120930ybb.80.1458076733829;
 Tue, 15 Mar 2016 14:18:53 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 15 Mar 2016 14:18:53 -0700 (PDT)
In-Reply-To: <xmqqh9g77879.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288914>

On Wed, Mar 16, 2016 at 2:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> ... But then I am still not convinced for the
>> requirement of another variable `opt-verbose` as I believe that the
>> `verbose` and `config_verbose` are quite enough for this.
>> ... Or is there something else which I forgot to
>> consider?
>
> I do not think we need three variables.  If there is one "verbose"
> that is initialized to "unspecified" (which must be different from
> "no", "yes", "even more verbose"), then it is perfectly fine to
> reuse that as if it were "opt-verbose" in my outline.  I just used
> that name to make it clear where the value comes from for these two
> entities, i.e. to contrast "opt vs config" (as opposed to "(nothing)
> vs config").

I just wanted to clear out the confusion! I will send the updated
patch with tests soon!
