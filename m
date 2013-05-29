From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Tue, 28 May 2013 22:51:14 -0700
Message-ID: <CANiSa6h7fY=GNM0VvFXvE-LD=nVWbEBGqWbaheZ6gr518_aPNA@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
	<CAMP44s0Zy4KpPN1n6HOVXWyCuevenbSFnH589YngMB9NVWcamQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZI8-0004Iv-NV
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab3E2FvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:51:16 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:57312 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3E2FvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:51:15 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so3164216wib.8
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HBSc9wlp07mSfCwPh5D4Wk6YIedxHThY6C8mZLgoZhE=;
        b=mTO2Mgxybn/zqvPaGAn7hmmrcFw0KF6s5wPOXc3MMI3+1VgBvZk341smPUMO4VO0Hx
         DEfmidKLQrFeoIOw0zMJI0GBm2DajWdBXPCYzmGR14t8/BOq9E7gn5Q6ag1igZ4f/EA2
         Tek7faM6VYVwEvKQXtfQ8zZXJ+PoI+ulytwcsZMKcjRaOKsBrjE/Gkb1tWcNFOxfwIFO
         aQ2oG2jdUJ7vyp0VKLHLKs9/PuNe97UBXGPtkIHp5XT5+2t++x/m92g/zoPXQT75woeH
         LRsFrepva7V4l8p3Gr5ocSkOalUwFeX7OJcnr7jPjGHt3Z24wsgSIAU3NGPQUYlDcfCY
         BtIg==
X-Received: by 10.180.206.77 with SMTP id lm13mr858363wic.18.1369806674450;
 Tue, 28 May 2013 22:51:14 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 22:51:14 -0700 (PDT)
In-Reply-To: <CAMP44s0Zy4KpPN1n6HOVXWyCuevenbSFnH589YngMB9NVWcamQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225745>

On Tue, May 28, 2013 at 10:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 29, 2013 at 12:33 AM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
>>  As Junio asked in the previous iteration, shouldn't this have been in
>> the first patch?
>
> No, the first patch is splitting the code without introducing any
> functional changes.
>
> This is fixing a bug that already exists, we could fix it before the
> split, or after, but mixing the split and the fix at the same time is
> a no-no.

Oh, now I remember. I ran into that bug once.

> One change splits, the other change fixes, what's wrong with that?

I didn't say there was anything wrong. I was asking if the bug was
there before (and I didn't see an answer when Junio asked).

Thanks
