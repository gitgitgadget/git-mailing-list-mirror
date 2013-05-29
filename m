From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Wed, 29 May 2013 08:40:08 -0500
Message-ID: <CAMP44s38xDmqtzLNB44=HKQd8R+3S=edN3LS40GFfp7wfqi3hw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=QyznWZt4sJCok9OZxjrdjtMTtpStA8LHdCCbn0Oi6TA@mail.gmail.com>
	<CAMP44s0M8dg_8ke3p1wJtnPrjdtH0L-D3ZgnPPCSKH0Mx0Z=GA@mail.gmail.com>
	<CALkWK0=VieCwZS4ua-eyg3t-cqC2Y+ifa-G7gwJ=Mxt0cfoD1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhgbw-0006K8-VH
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966155Ab3E2NkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:40:11 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:37073 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966120Ab3E2NkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:40:09 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so8528349lab.7
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s/EYU01JRFfLQPxysFfyB9zzFsKSy0bU2vbOIjzP/wA=;
        b=LftLxg1nqhEJt4AL85ckmcDkxGRtd4u89SwAift2sv7jY4FgIK8W+nqHpewHMF3JwT
         hhTfafaxCpfdhbfqUyy9OOXfeoJnUymoTgA4uKtGkvLyyNCw535nSB8a/cr8o0gkFxq0
         bgVU+SVRQpgFzqXzHMMIXJPZlcMHiK72aHvRxej3PQIfphJ6h74PZ1fTNjQieMaivZi3
         ySEmI9m5WUJm93huQUuSuQ3iiITPBaYuV5WtH6uHmdvVfwwUOzoUUYcA5Dzv332Y5Pbk
         ma6kR5/SeyU9+zFHNWO3KNo5OXbRTMzDtVMb5AZ4mzFDd7DtaV6aKNaQfwLYAZ/j9xqL
         tlyQ==
X-Received: by 10.112.156.164 with SMTP id wf4mr1572511lbb.76.1369834808149;
 Wed, 29 May 2013 06:40:08 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:40:08 -0700 (PDT)
In-Reply-To: <CALkWK0=VieCwZS4ua-eyg3t-cqC2Y+ifa-G7gwJ=Mxt0cfoD1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225821>

On Wed, May 29, 2013 at 8:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Did you miss the -q option passed to 'git commit'?
>
> Ah, yes.
>
> It would help if you mentioned:
>
>     Introduce --quiet to suppress warning about skipped commits (when
> using --skip-empty) and output from 'git commit'.

I would switch them around, as the former is not important, in fact,
it's so unimportant that I wouldn't even mention it.

And in fact, it wasn't even there when I wrote this commit message I
sent for v1, it was only squashed later on.

The only really important thing this patch does is 'commit -q', and I
cannot imagine what the purpose of a -q option to cherry-pick would be
if it's not that. But yeah, it wouldn't hurt.

-- 
Felipe Contreras
