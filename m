From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 23:02:22 +0530
Message-ID: <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
 <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEQR-0003H0-EM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761097Ab3D3RdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:33:06 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:60639 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760730Ab3D3RdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:33:04 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so671941iay.18
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hrFSch5zO+sMKWDJmWnQWZUFqImNx0S/XaZcu37bwbY=;
        b=ydw71YHDoWYa+lFd13j6F/u/+yI6qh2Ev1S3tWbH3t99YeVUY9s2fGoVD865NJZd9m
         9FfSr7udXGG2Z9U/ze1VmS5SDuKm+dr6aVFCk4LY0CNGevwTW47wFHH/PiZVIylED6yp
         m6AZZQmNKL8420BfDvMtJ7V979imA92CjE3G3KrFgJn4d7KItz8QpGnEvCXo86Jd8PAz
         2ChslPATY1wxendOXVWNeKQrrxhOPWzqmTwCFiZI0IHWvh/32/2KzUgziNFaRPxWH5h2
         qN66XitAzyAr9uLHCD4se878LAwlwEcqLlS4JcQUZpsp6165CrjzspI0QF8yGNjY7stO
         qRIQ==
X-Received: by 10.42.27.146 with SMTP id j18mr21066252icc.54.1367343183061;
 Tue, 30 Apr 2013 10:33:03 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:32:22 -0700 (PDT)
In-Reply-To: <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222957>

Felipe Contreras wrote:
> Why would HEAD^0^0~4 work? Because the syntax is recursive.

That's because you can compose with ^ and ^, while you can't with @
and @.  Does @{0}@{0} resolve?
