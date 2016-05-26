From: Austin English <austinenglish@gmail.com>
Subject: Re: Please add a git config option to make --show-signature the default
Date: Wed, 25 May 2016 19:27:22 -0500
Message-ID: <CACC5Q1eaORyTn3gBzry7ove05_t0SpbJdnZia3+czYz+7NpBAw@mail.gmail.com>
References: <57438568.60707@gmail.com> <alpine.DEB.2.20.1605241313440.4449@virtualbox>
 <CACC5Q1c2s4yOtGAtKsepwnme7udq7yqyN7S5BfMHbi0L08XwzA@mail.gmail.com> <CA+DCAeSqTitycrO2y=SdutK1H2+jbzp7OzbhZ3pOYY_YOdOkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 02:33:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5jFO-0000hc-50
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcEZAdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:33:55 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35980 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbcEZAdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:33:54 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 May 2016 20:33:54 EDT
Received: by mail-it0-f41.google.com with SMTP id e62so84418930ita.1
        for <git@vger.kernel.org>; Wed, 25 May 2016 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C+B5VnNWGlq51QCbiUWrzxRBI1141k6aWaiQtl6pi7Y=;
        b=fQosf4jFxbBsuJacpG96Huqg7An2/7ulqiHmtIuSK8PBRExoa0UubOvQ8281a9kMHP
         agG3dkMZr7oc9F/sOTnEvUqXDWj7kbNjvmlj0mwvEpDl5wWZd0TTMLZfOg5DlP3B2w4S
         djNXXJL6BBsdjoak3T2WlC5zi0lKtSXVj15+4vXkL1B4A93MnuwwBlmFxW0mf5UJ4JXL
         7F2PbZTd98GQKr75oo5pmzeQboOxZRh9ZpnYZv3ueBceoxdJG9pF0LMRyNeCRHj1deUK
         nT3Q/HAjhb1eF68uUECwvXL/tavMpV639QDfLNtFR/+JloEOMYulmyqhJfL+NJyJrxJv
         waig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C+B5VnNWGlq51QCbiUWrzxRBI1141k6aWaiQtl6pi7Y=;
        b=WH/cWFIL91SEwLUF2o5WNSfODkhrBkbH+J9mP8fmMuLtpvvBBPGP2vrTaWZbzVK6p5
         8JWBbKuwbK1MjFrDkKQ/NfBLD3nyAiCevrLllCoEATwtaSp/zpTNIYs3cSGRP4F27m/u
         VAqyDWljAASCMTrAEcgWMmALwhh8DHjV2M3aczcDfzHKh+ccnxXTMnu5d0RwSTDq2War
         AwlSo0mFgcCEF4T7EHcFOv2a9g894ZtvW+v8piTwTrg9KPSCdAhBdOI7rcxxACMNjH/r
         I72SBDGb1iWTqSXqiqNtSCqa35Ozwl+ChNhyGHZWv1B4I4KNpWpaZddDtb/y7PSlKtmS
         UTyw==
X-Gm-Message-State: ALyK8tLHhIJTY7W10j6jR/u7zW44PpFXCpqbsACJBxu60WTbLqTsvk/Kl8/ws+jNWZ1RhljdsHTmLfZxMmP5cg==
X-Received: by 10.36.58.135 with SMTP id m129mr555790itm.96.1464222481768;
 Wed, 25 May 2016 17:28:01 -0700 (PDT)
Received: by 10.79.114.83 with HTTP; Wed, 25 May 2016 17:27:22 -0700 (PDT)
In-Reply-To: <CA+DCAeSqTitycrO2y=SdutK1H2+jbzp7OzbhZ3pOYY_YOdOkGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295625>

On Wed, May 25, 2016 at 1:18 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Hi,
>
> On Wed, May 25, 2016 at 9:28 AM, Austin English <austinenglish@gmail.com> wrote:
>> I'll try
>> to submit my own patch. In the meantime, it seems appropriate to file
>> a bug so that others can have the opportunity to solve the problem if
>> they're interested.
>
> If you haven't started working on it and if no one else has picked it up
> then I would like to try it out and submit a patch.

Hi Mehul,

I have not started work, Gentoo/Tails have been keeping me busy. I
would greatly appreciate you picking this up. I'm happy to test any
patches if you'd like.

-- 
-Austin
