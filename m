From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 12:28:15 -0500
Message-ID: <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
	<87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
	<20130430150430.GA13398@lanh>
	<7vehdsf19m.fsf@alter.siamese.dyndns.org>
	<CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXELm-0007Bv-SW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942Ab3D3R2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:28:18 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33285 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772Ab3D3R2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:28:16 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so765187lbi.15
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iu9j5gZt8C/VU5fPUEhVq4M3/W2AJVz/RncNfbdyKeQ=;
        b=kN5Z12HLRJ5pZ11D9SvyR6FMnraw4bdxrI409t4EaVJE437ZOhGoORcoNVxVGd1lUY
         LyYUYoLBZCQwITDLuCWNbbXlpMGTJHTpN7VDm0YhG47iUmvMiHJHY6DXWZZGhoILHa89
         Nj46ga/6nx3UkKGPMBXsV+nxVT7Lu5cFiw8ezSanCldtMpEGG36Bt+jGup02a0mOd9n5
         n6JbI1kGc8ubJ3dl60FqMSAgjCj9oF8cRhHCzfrn9SC6wwi9jf6nPkwtHhsYjunD9uAD
         SQE9CI4HAjbEl9uv1nSDhNuDRx1mLrlVb9tqnZ9U9wVgvUAyEFj06zAP7KjrVfZfV5T7
         rQWg==
X-Received: by 10.112.166.101 with SMTP id zf5mr686289lbb.59.1367342895198;
 Tue, 30 Apr 2013 10:28:15 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 10:28:15 -0700 (PDT)
In-Reply-To: <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222956>

On Tue, Apr 30, 2013 at 12:23 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:

>> Would @@{4} and HEAD@{4} be the same?
>
> No.  Why should they?

Why would HEAD^0^0~4 work? Because the syntax is recursive.

-- 
Felipe Contreras
