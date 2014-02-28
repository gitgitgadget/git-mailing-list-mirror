From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: [PATCH] branch.c: delete size check of newly tracked branch names
Date: Fri, 28 Feb 2014 12:16:18 +0100
Message-ID: <CAL0uuq3fZby7SG4Q5B8R1h8wHOGOHBamT+9ZR8mbNms40if6nw@mail.gmail.com>
References: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 12:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJLQc-0000hV-JY
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 12:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaB1LQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 06:16:21 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:48957 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaB1LQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 06:16:19 -0500
Received: by mail-vc0-f179.google.com with SMTP id lh14so567390vcb.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 03:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PpvEveW/cSFScwrrHE08RrUorYD290WvVWf/VkNnz6E=;
        b=BQXEEQ25GjdANGQ9elItXfVJklR+KazNMpoSE+1qfrEzK3ngC/O8XTa+jHTQDg0g3O
         /DfJBWNaG+l7/ok41+yLr5AaD2qEZ3HqMegrjvJag1NOIheJi8p0cf+C3VEPLLfCcBbF
         a0pNmUDb6dKSmdZXFOYaIL44mJZQ5LvFaKi70Q1wpl1Wm6N8tOwvQaMdMG0SVKyrgAUR
         ST7xf5VtE7q+YlshX52TzV2viAjD4hs5HNuae/Jzx+M5/1osdxHg+P9lGxcryEr2eyDI
         f0Pxs+wrw6lhDKDg61NC7e7kQc6yGBcKH0bBFgBdmOpGq2EInMjYveQg+8olfnuFmtYq
         2iBg==
X-Received: by 10.58.201.5 with SMTP id jw5mr2008711vec.6.1393586178356; Fri,
 28 Feb 2014 03:16:18 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Fri, 28 Feb 2014 03:16:18 -0800 (PST)
In-Reply-To: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242943>

> This patch removes this unneeded check and thus allows for branch names
> longer than 1019 characters.
>

Ach! I amended the commit in my local history to read "Remove this
unneded check and thus allow for branch names longer than 1019
characters", but for some reason git format-patch -1 --signoff isn't
reflecting this change.
