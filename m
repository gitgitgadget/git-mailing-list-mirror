From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 17:09:17 +0200
Message-ID: <CAP8UFD0ot86bmuzxkfe8hzY1LmTiupre6h7QufkDpezT_fOsrA@mail.gmail.com>
References: <20160331123507.GC19857@collabora.co.uk>
	<CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
	<20160331143501.GE19857@collabora.co.uk>
	<56FD3ABC.2000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miklos Vajna <vmiklos@collabora.co.uk>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aleDs-0007Ee-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846AbcCaPJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:09:20 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36332 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcCaPJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:09:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id 127so137768628wmu.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1f3BNPSSvbrmI0lvXOh6asRxK5wiTLyZ95cPgxzl+TI=;
        b=VRcikW7aRlDy7hPRudfhnhB1gqLpESklzLW0U7KqSjew0uKbYJD6WWzQdwfBSEPPTv
         xD/oQ/KZjrlnZL5yOjiySx5C+MevZCsPbWTLAORU93sfTdjdicByarMq109ETNCmdpPz
         b138o29SJzM0MpdjC1XLtfksZUnomd6nSbbu/Lzhc4WCoiSwbT6Qf5/WjmcY5AeFksur
         DiJQYbUCDaYAUuYoyo+q1X+F4cJizLyXUFq+QEmnVXgoz2BZEmoo44hG0CiS9zETU7Fe
         Q8gjBG/YPEVgYgZI5uy4/E28QQPUkAXTtH0Hb8ZiBwU5In/I+5otdS6CVT8sLIAPj899
         Imbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1f3BNPSSvbrmI0lvXOh6asRxK5wiTLyZ95cPgxzl+TI=;
        b=RpvYbY17qX3xGxJSt0ZxT3vBFOUSV0h/kpUmiVDc6Sl0A8YNgP1Yj4s1xyWdbBM9eO
         LvPDjDthy6GVb1W5DwCePhtO+ICWLhufzKyp/I5KMYDW9TYvWPWLprQXDTJ1Xzqj8cHK
         z7Ei7SxMCehvNdNgJeluJhZqTRtl/AMlU+NEKQ8j/5VuonPVls+gNGN/alBnTnwB1vCF
         OAgXSOzsTu8G5ukjNYossudGn/q4ku3QeabU2TYHc0o6Kk3GWP+2QrvsbW2wYafqiLMc
         XIusytuO8nXo0fDhO6WbA91SdDrutOA8I0x4gePQJOKEM3h3HubVO2sQSRqxtapkYSLR
         gGzQ==
X-Gm-Message-State: AD7BkJLx0ZTfHMVq5W+SmW4W04k2mZhfLsV4WG0rbZg7SYFpZOPin7xSlpct+9RByrOMI/5pPK+24zMhpSyoAw==
X-Received: by 10.194.2.202 with SMTP id 10mr17155831wjw.94.1459436957947;
 Thu, 31 Mar 2016 08:09:17 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Thu, 31 Mar 2016 08:09:17 -0700 (PDT)
In-Reply-To: <56FD3ABC.2000500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290401>

On Thu, Mar 31, 2016 at 4:57 PM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
> Hi,
>
> On Thursday 31 March 2016 08:05 PM, Miklos Vajna wrote:
>> Hi,
>>
>> On Thu, Mar 31, 2016 at 07:54:47PM +0530, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Are you suggesting to use a different email address for commiting,
>>> signing off and reviewing?
>> Let's say project A has a workflow where patch authors and maintainers
>> add a "Signed-off-by: A B <a@example.com>" line. This is well-supported
>> by git, various commands have a -s option to add that line.
>>
>> However, if project B has a workflow where patch authors add no such
>> line, and reviewers add a "Reviewed-by: A B <a@example.com>" line, then
>> you have to add that line manually when you do a review.
> When making the string configurable, would it be a good idea to
> support more than one sign-off strings? For instance, often patches
> here in Git have both a Signed-Off and a Reviewed-by line. What would
> you suggest for such a case?

"git interpret-trailers" supports many kinds of trailers. There were a
lot of related discussions/bikeshedding when it was designed and
worked on.
