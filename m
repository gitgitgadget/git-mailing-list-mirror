From: Jagan Teki <jteki@openedev.com>
Subject: Re: Show total commit count of two authors or more authors into first author
Date: Mon, 7 Dec 2015 01:45:19 +0530
Message-ID: <CAD6G_RRtH5yBqwrgMxhrSXb++n6CNA2qXcNn+Z2ALSyV8b9ZuA@mail.gmail.com>
References: <CAD6G_RQ2Ub8HasupNbUFK2LJfir25tNFTqrqU2ELoEJHOibzHA@mail.gmail.com>
	<87wpsrz843.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 21:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5gFc-0001fw-T1
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 21:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbbLFUtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 15:49:17 -0500
Received: from s159.web-hosting.com ([68.65.121.203]:60657 "EHLO
	s159.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbbLFUtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 15:49:17 -0500
X-Greylist: delayed 2035 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2015 15:49:17 EST
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36688)
	by server159.web-hosting.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.85)
	(envelope-from <jteki@openedev.com>)
	id 1a5fiK-004Ifi-Mc
	for git@vger.kernel.org; Sun, 06 Dec 2015 15:15:22 -0500
Received: by lbblt2 with SMTP id lt2so45729731lbb.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 12:15:19 -0800 (PST)
X-Received: by 10.112.136.170 with SMTP id qb10mr12713403lbb.106.1449432919275;
 Sun, 06 Dec 2015 12:15:19 -0800 (PST)
Received: by 10.25.209.206 with HTTP; Sun, 6 Dec 2015 12:15:19 -0800 (PST)
In-Reply-To: <87wpsrz843.fsf@igel.home>
X-Gmail-Original-Message-ID: <CAD6G_RRtH5yBqwrgMxhrSXb++n6CNA2qXcNn+Z2ALSyV8b9ZuA@mail.gmail.com>
X-OutGoing-Spam-Status: No, score=-2.9
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server159.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - openedev.com
X-Get-Message-Sender-Via: server159.web-hosting.com: authenticated_id: jteki@openedev.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282063>

On 7 December 2015 at 01:01, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Jagan Teki <jagannadh.teki@gmail.com> writes:
>
>> Out of which below three names are with same author which changed
>> while submitted patches.
>>   149  Jagan Teki
>>   122  Jagannadha Teki
>>   116  Jagannadha Sutradharudu Teki
>>
>> I need a command to show to add all commits and show first one as
>>    387 Jagan Teki
>>
>> Can anyone help to do this?
>
> See the "MAPPING AUTHORS" section of git-shortlog(1).
>
>        The .mailmap feature is used to coalesce together commits by the same
>        person in the shortlog, where their name and/or email address was
>        spelled differently.
>
>        If the file .mailmap exists at the toplevel of the repository, or at
>        the location pointed to by the mailmap.file or mailmap.blob
>        configuration options, it is used to map author and committer names and
>        email addresses to canonical real names and email addresses.

Thanks for the info, I'm able to map two author with e-mail but it's
not working when I group 3

$ .mailmap
Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com>

The above worked but how about 3 names mapping

$ .mailmap
Jagan Teki <a@abc.com> Jagannadha Teki <x@xynz.com> Jagannadha
Sutradharudu Teki<p@pqr.com>

Finally I need to map all 3 into Jagan Teki <a@abc.com>

-- 
Jagan.
