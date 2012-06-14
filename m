From: Brendan Brewster <brendan.brewster@gmail.com>
Subject: Re: Checksum incorrectly uses signed values
Date: Thu, 14 Jun 2012 10:50:30 -0400
Message-ID: <CA+-ctj5tXQmeHcZ5CC74O5QSyOH1sEYTSL-f3Rcc4MtqmGnTgA@mail.gmail.com>
References: <CA+-ctj5M4XraOQJfWRVVFmRrNsUZUJyt63_Oi__OJCcYMC=ciw@mail.gmail.com>
 <1339648521-ner-3801@calvin> <CA+-ctj7v2v+=Sa2A+wSieXp26Q4wgVrTJnwyCt_erfPBmpdcdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 16:51:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfBO8-0004sr-3c
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 16:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab2FNOux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 10:50:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34081 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2FNOuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 10:50:51 -0400
Received: by pbbrp8 with SMTP id rp8so3908409pbb.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=SaHA0uC9ukRh+Zdvc92X6P1OZSfcT0aQeA2C5Rw+l+k=;
        b=u6aFYk3HtbxI9SBG83R6jYkZrRmF+u2woLflmUt1oWk6VZ3PumZEHAWNR8sSYOkqBT
         fDZFG1Mfa/wmCuIJqSjN7hTbnyZKzztfJamWkB0uRyrMhtTHQfMLjJFXQ5fnntzYP3fQ
         6O0GoVeVvH/GXpMlFqM3Fz+nv82lmX4RPQuS45PNSmEJYgzrXLLc5Gpq6TXkqUAuQ9uT
         FgdQ7aoNqj5KYqFsFICWtMzrz2naK1o3lbSrkX6xSVRIxGIZFW35auuM3afN6kxWv1qH
         fgi+SC4XtwZE5YOd5fBbExdhW/7FGM4bzK78mlogB2q5TJnC4n35xHieSGOzJ1OoiC67
         qG5Q==
Received: by 10.68.232.201 with SMTP id tq9mr8992894pbc.70.1339685451081; Thu,
 14 Jun 2012 07:50:51 -0700 (PDT)
Received: by 10.143.161.18 with HTTP; Thu, 14 Jun 2012 07:50:30 -0700 (PDT)
In-Reply-To: <CA+-ctj7v2v+=Sa2A+wSieXp26Q4wgVrTJnwyCt_erfPBmpdcdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200009>

On Thu, Jun 14, 2012 at 12:39 AM, Brendan Brewster
<brendan.brewster@gmail.com> wrote:
> Hi Tomas/Junio,
>
> Yes, that is definitely it. The referenced 7-zip thread was my own
> that I tried to report today; I guess that's what I get for going on
> vacation and not getting a chance to submit my report here until after
> getting back :)
>
> Thanks, this is good news. I will report back to Igor on this.
>
> Thanks again,
> Brendan
>
> On Thu, Jun 14, 2012 at 12:35 AM, Tomas Carnecky
> <tomas.carnecky@gmail.com> wrote:
>> On Wed, 13 Jun 2012 21:16:21 -0400, Brendan Brewster <brendan.brewster@gmail.com> wrote:
>>> Hi,
>>>
>>> The issue, in summary, is that 7-zip was unable to untar a tar created
>>> via a "git archive" whereas gnu tar can. It seem that it may be the
>>> case that git is incorrectly using signed values when creating the
>>> checksum.
>>>
>>> Can someone please look into this and possibly redirect if needed?
>>
>> That was reported a day ago and Junio already wrote a patch. See
>> http://article.gmane.org/gmane.comp.version-control.git/199911.
>>
>> tom

Pushing this to the mailing list (sorry for the top post initially).

-Brendan
