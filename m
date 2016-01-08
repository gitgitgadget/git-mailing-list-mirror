From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Behavior change in 2.7.0: With core.sparseCheckout some files
 have the skip-worktree bit set after a checkout.
Date: Fri, 8 Jan 2016 17:49:29 +0700
Message-ID: <CACsJy8A7LR0xmwuqCKxxiiGeApywYb+_Zxcp=PG=sHHfpeBZRg@mail.gmail.com>
References: <trinity-5caa2985-5cf1-453b-9a9e-bcce057f8615-1452249323061@3capp-gmx-bs51>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Micha Wiedenmann <mw-u2@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 11:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUcS-0006Ey-3O
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 11:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbcAHKuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 05:50:01 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33073 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbcAHKuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2016 05:50:00 -0500
Received: by mail-lb0-f180.google.com with SMTP id sv6so214965961lbb.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+1jRPldRbwvhaOHAGLQJT2op0u9E7lRq26pQQDO+46Q=;
        b=bTL8EtXgzpez1xdSj8/rn9VQmXqKRvhr8kwVU6Qv4yNRuEaG4EXVZOo3spIDaiAuXh
         iFddT928u4LTwI/iE+Ncyzcwt2qKpbrIWsCNZVXTlkXbNexAzrIXkpImBw91dZZzCA/l
         a2uXIG6hlp9NoCP3K2XxmqnzrnsACIGLCqB5gE59HzUot7K7QpQkkYTbQHl4MlfCGwbo
         ihfWv4mu6YwobBTYAxLsSW/xJVwxTfTrizJ5ZWIQoAn8AGAvJSZURSu8auG+rZT8xRe9
         V5Xye5+aD4KGCRTQh9ld7NXiLE7IGZt+klt/M5DSZol9PLbEyTIA2QNP+vnWAfDacaeQ
         Z40g==
X-Received: by 10.112.141.97 with SMTP id rn1mr20690737lbb.80.1452250198932;
 Fri, 08 Jan 2016 02:49:58 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 8 Jan 2016 02:49:29 -0800 (PST)
In-Reply-To: <trinity-5caa2985-5cf1-453b-9a9e-bcce057f8615-1452249323061@3capp-gmx-bs51>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283534>

On Fri, Jan 8, 2016 at 5:35 PM, Micha Wiedenmann <mw-u2@gmx.de> wrote:
> Hi,
>
> I want to report a change in behavior Git 2.7.0. With `core.sparseCheckout` set to true, `git checkout` results in some files with a set skip-worktree bit, which was not the case in 2.6.4. (I am using Git for Windows, but assume this is a Git issue, which is why I report it to this list.)

I might know the reason (and I'm quickly becoming king of
regressions). Checking...
-- 
Duy
