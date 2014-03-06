From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: gc/repack has no option to lose grafted parents
Date: Thu, 6 Mar 2014 18:36:49 -0500
Message-ID: <CACPiFCLgoGP59sW73YFCt8Wq4hpxZUb0PBF-DzHz0JdxrYo4rw@mail.gmail.com>
References: <CACPiFCLqa=ZQM6Azh2G5hwBCMx96Cxa5BMN=-2aCy5x=YhBpGg@mail.gmail.com>
 <xmqqwqg6vrht.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhqo-0004dc-86
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaCFXhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:37:11 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:46506 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaCFXhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:37:10 -0500
Received: by mail-ve0-f177.google.com with SMTP id sa20so3351070veb.8
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NZFEs8QqRwqETwmjbNrGPiXVNFMZiIvS5zHUs+Y9IZI=;
        b=CTpMP1k/eEgXxaHkhq1UVI18qq872K/YpnnpLvHBfMYH7LXFZTzrCmFlhbvosvn1v5
         Xw+5rrEtu2sUY+0wRzmUPn1hePT/P56ixpkqjufST7EaEVCdWEFIlB+tbwlafnWlRL6Q
         6918cIWQC6AI6bbA9wO3fhWRIAJwyTNfJQsX6pTn1ZdueS+xDdoiSt3ry9+2fuBos5h3
         YOGBu/+ydS8dw67S92IlOMCYMZnP/I0pJX/0R+/KiWaSpmkVEpT+kNzRlRk1tI8rlQzC
         wqMCVT2eszwIuOFR6rRc1ULwx4ezPv0TRzwhtUoGJH5g0MhJZXvptiQiM2lIGdLCvBRg
         ITng==
X-Received: by 10.220.10.2 with SMTP id n2mr3418640vcn.26.1394149029809; Thu,
 06 Mar 2014 15:37:09 -0800 (PST)
Received: by 10.220.183.138 with HTTP; Thu, 6 Mar 2014 15:36:49 -0800 (PST)
In-Reply-To: <xmqqwqg6vrht.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243575>

On Thu, Mar 6, 2014 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Given that we in general frown upon long-term use of grafts (or
> "replace" for that matter), I am not sure if we want to go in that
> direction.
>
> Just a knee-jerk reaction, though.

Fair enough.

If I state my actual goals -- discarding old, uninteresting history,
in a "rolling" fashion? (periodically using a script that says "forget
anything older than one month") -- is there a better way?

The repository is not standalone, it receives pushes from hundreds of
clients, and gets pulled from a couple of clients. All clients are "in
sync", in that will be pulling every hour (vs a "time window" of one
month).

At this stage, and with careful management (ie: custom gc scripts) git
makes for an excellent async log/report transfer tool. We specially
appreciate that it has "deep buffer".

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
