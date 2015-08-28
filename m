From: John Szakmeister <john@szakmeister.net>
Subject: Re: Bug with worktrees...
Date: Fri, 28 Aug 2015 06:27:46 -0400
Message-ID: <CAEBDL5W9Ly_tsE35OG+MGZkA0V41FEoewZTWk9EPZxXQHnRF6A@mail.gmail.com>
References: <CAEBDL5UQSvS=t1dUKYqK6R=xHU6RU3bS72w-i02ey-Y_VB9KMQ@mail.gmail.com>
	<CAPig+cTkeOywRH1-_4Zi9jOd5r1cXa9vJhYAYXhF3E+SSE_GeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVGt1-00025r-6Y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 12:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbbH1K1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 06:27:49 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36778 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbH1K1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 06:27:47 -0400
Received: by igcse8 with SMTP id se8so15393042igc.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TP/zVhgtu+YUkv0D+w26BrAaZwFOpJw2R/ghoKN1Jqk=;
        b=eeHUegoDjEZoJFObE4rohe9Y59WoSIu8sd+PNbow2NpOKEV1N4nSjvp2PPpG/ZtwCB
         lTVWJ6yt8oFUw9DhodaZkx3J6ko5xX760TG7VVfK9Iy2OOoi0wVsGt4xpRLYO3auUE4S
         oECJeeM9fOECnzsXdP27IR4GMLK/MDK6t/JGtY/Fc7fFg3J2XyxXkH5kaVGlgFi5dh+X
         yBgDQOCZGSCMVwV6WXYEltqPHKNdeAlAJIDvdbq2JSDZ+At3iUkGLE2ntTh2hoa6JbGe
         QLxghnWHhAGZIEzp/6CHys3K8ZIoqQKRLYw6/Udc4plut9MPTK6Mfqjp7GIF/LLPYOSu
         Kp/Q==
X-Received: by 10.50.132.39 with SMTP id or7mr2795598igb.90.1440757666521;
 Fri, 28 Aug 2015 03:27:46 -0700 (PDT)
Received: by 10.107.187.2 with HTTP; Fri, 28 Aug 2015 03:27:46 -0700 (PDT)
In-Reply-To: <CAPig+cTkeOywRH1-_4Zi9jOd5r1cXa9vJhYAYXhF3E+SSE_GeA@mail.gmail.com>
X-Google-Sender-Auth: 1qiAPs8SW6CEcMzuuk5H1IEzvKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276715>

On Thu, Aug 27, 2015 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
[snip]
> I can reproduce with 2.5.0 but not 'master'. Bisection reveals that
> this was fixed by d95138e (setup: set env $GIT_WORK_TREE when work
> tree is set, like $GIT_DIR, 2015-06-26), and was reported previously
> here [1].

I had done a quick search but didn't turn up that thread.  Thank you Eric!

-John
