From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/7] sha1_name: prepare to introduce AT_KIND_PUSH
Date: Fri, 24 May 2013 18:57:05 +0530
Message-ID: <CALkWK0m+PAeE1nk4a7PjXU2tymCQVXzGL1CFOgyd5AqJuVZ9Og@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
 <1369321970-7759-7-git-send-email-artagnon@gmail.com> <CAMP44s2AxHkx54HzCCK5nUsexAhWy4J_oqg4wNu0=FzvEYtXAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 15:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufs2A-0000DH-RO
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 15:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab3EXN1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 09:27:47 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64427 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3EXN1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 09:27:46 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so12323487iec.11
        for <git@vger.kernel.org>; Fri, 24 May 2013 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WeG+GFD9R9KM1YwbOkWgwpf2C4h+I9kocwrILp2br0k=;
        b=pZAqr+ss6+2Gb86YzR3sLeMb90ZY3weWc1dvGbxPRamuMKiDrMUwB7LKi7OWCemPT4
         qnvJBpEgTKIc03TnJFzzi7kya91yejpiQO9tBLppysyV20IL0VSb7Rvs8ZRr1WqxQX4/
         adkGrT0rbfLvzbeRpL/M/uRakUR3GzFptH/HF8wRafozwkZ/qHws7pj7EL45ZvXtIwgd
         Tb65eUGbBOT6QgXLTrU5fwPhkDp0Qu4paBu02SwwjFjPP+k1m3ucIpEsIPqJSWNe4PTk
         vn0t+b7jpOlGsTOG7G5HOPjBPNJMVHfsyQsAraxXdajNXD1TWhLCZOp3N9aNSDmzofMm
         lpmQ==
X-Received: by 10.42.47.77 with SMTP id n13mr12639761icf.12.1369402065995;
 Fri, 24 May 2013 06:27:45 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 06:27:05 -0700 (PDT)
In-Reply-To: <CAMP44s2AxHkx54HzCCK5nUsexAhWy4J_oqg4wNu0=FzvEYtXAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225352>

Felipe Contreras wrote:
>   git push branch@{push}
>
> Is not clear at all: push push of branch?

We can pick the name later.  I had to pick a name to write code, and
that happens to be @{push}.
