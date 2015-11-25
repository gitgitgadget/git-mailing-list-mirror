From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Documentation/git-update-index: add missing opts to synopsys
Date: Wed, 25 Nov 2015 07:56:00 +0100
Message-ID: <CAP8UFD1vPe3t=dzG7ZEObfPYk49M=H36tfDviLCcBHaMkWhxEQ@mail.gmail.com>
References: <1448366107-5179-1-git-send-email-chriscool@tuxfamily.org>
	<20151124204603.GE7174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 07:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Tzs-0002Zz-3q
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 07:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbbKYG4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 01:56:05 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37253 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbKYG4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 01:56:04 -0500
Received: by igcto18 with SMTP id to18so31250722igc.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 22:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bi/MoQVktjdwRebmeE4K+X5zOAlLgUauKSy7Urupq1U=;
        b=He0GFGsUcnIa/07iVF1inBA1KLNTupT4glRyep8thsqYKCHHFj19V7pg6w9BoXbohX
         oVYCEXixLzR+WbaeM2qmt8MZEYPSVsDh+jsR4ZCiHiG6NJn5pZZ4APcFVzRW30Fpgamb
         OemqNzdAP3ubyQLqGuARof1MHz/Ze1fhBsM0X1Q+jtmkydoXYELu1d8qwNXXwrcMyAOP
         tPfu4w04eWBRQX9rOgxFk1YsV5SZa85cNEHZEmEmN+Mk5/dX25hhvYO6x/KtrK6/hTGe
         AVX5Dq1bUqIQZPjtfpdFM8QtQvn43+hgJccy/GSRqrAyrrYQC/rNEAvvbKyY1SjbcC5/
         L2KQ==
X-Received: by 10.50.134.230 with SMTP id pn6mr2568880igb.90.1448434560557;
 Tue, 24 Nov 2015 22:56:00 -0800 (PST)
Received: by 10.36.146.68 with HTTP; Tue, 24 Nov 2015 22:56:00 -0800 (PST)
In-Reply-To: <20151124204603.GE7174@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281681>

On Tue, Nov 24, 2015 at 9:46 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 24, 2015 at 12:55:07PM +0100, Christian Couder wrote:
>
>> Untracked cache related options should appear in the synopsis.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/git-update-index.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index 1a296bc..3df9c26 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -17,6 +17,7 @@ SYNOPSIS
>>            [--[no-]assume-unchanged]
>>            [--[no-]skip-worktree]
>>            [--ignore-submodules]
>> +          [--[no-|force-]untracked-cache]
>
> Thanks, and it looks like they are already documented in the OPTIONS
> section.

Yeah, I just added this information into the commit message and sent a
v2 that also add split index related options to the synopsis.

Thanks,
Christian.
