From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Wed, 29 May 2013 00:41:22 -0500
Message-ID: <CAMP44s0Zy4KpPN1n6HOVXWyCuevenbSFnH589YngMB9NVWcamQ@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZ8a-0004L8-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab3E2FlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:41:24 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:45723 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab3E2FlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:41:23 -0400
Received: by mail-wg0-f41.google.com with SMTP id k13so3767185wgh.2
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VmJMt910e6Q/IAn0ZRWRo0oH0m2AWbojSF5aB+W4jKY=;
        b=S4OnBLlEokH3DF+3L4yRDSMnSBTN7jdFlTrN85qjb7YfIpjc3sz1R2zvGrMFqomIdA
         KUIgP+m5ZdzrCxZjgwVh1Cq+67j8FwdjMAEmtT9rJ9UgAuOSdokhDmYH3fTq+1F3XIqq
         Yt9DZSgSsQhVBrTcTMLLFKYT2jMAs6WAf/D9KezLb1/JYm4dEK6GC5Jd+f/Fdyfecgj2
         //sKFJV1SSnYq+uvufTgP+Wi94tntcnPATb09dBPeP7P4MLy1BmN34OgvJflMgCndKUw
         3UYeN28w++BFB5tDndIzaLAp31ZCAiFz1wO7RjaO2u/ITqoby0cfOC8P2vcldgxo1Qpi
         i4tg==
X-Received: by 10.194.122.225 with SMTP id lv1mr865058wjb.21.1369806082501;
 Tue, 28 May 2013 22:41:22 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Tue, 28 May 2013 22:41:22 -0700 (PDT)
In-Reply-To: <CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225741>

On Wed, May 29, 2013 at 12:33 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>  As Junio asked in the previous iteration, shouldn't this have been in
> the first patch?

No, the first patch is splitting the code without introducing any
functional changes.

This is fixing a bug that already exists, we could fix it before the
split, or after, but mixing the split and the fix at the same time is
a no-no.

One change splits, the other change fixes, what's wrong with that?

This way it's easy to see what each patch does.

-- 
Felipe Contreras
