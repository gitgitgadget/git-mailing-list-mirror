From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: feature request: better support for typos
Date: Sat, 15 Aug 2015 16:12:37 +0700
Message-ID: <CACsJy8DGUo0-zFm2xtAKE6wy0c2GdbiOe-X2+B0HnCNg3SKa8g@mail.gmail.com>
References: <CAN0XMOLDamBeWswDi0cn_naZ2TX+gd89+g48zNwPPKxTh+ZTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:13:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQXWb-0005PE-LI
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 11:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbHOJNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 05:13:09 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34830 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbHOJNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 05:13:07 -0400
Received: by iodt126 with SMTP id t126so107433531iod.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hbjCBsd69If/ACp5/ahg3KKfNpm43Jzqe/zLo1/Kv+4=;
        b=AQ4F+ADFfUWkU8dUsCG+5tngeInhrZR93YzUdfJvYLZd91u4s6dJYrly1p/WMctsd2
         O6Qe+RLevLNw0qdNm5yxnpGMXQwcbXmRhNljR6SVkeTsBqFVBIWLWARshz7abiSBg9B+
         KVx5CGYhviLAEco70FHkS303sZLt3kXOvP18EfYO0JTceQjh+DYhregLIi+GQaGuxROI
         RN87zJukkeQTWmSMzrwA6zyrak/0lxObcnq1VT0nl1XJ0M34MD3YYyyck48af2eyfgy3
         4XlEQ9IEtJpEKKoNU42tCZtmNPUyQA4NMLbGC0swcXog88ckX1Vl7/HURkvNygppR2fX
         V7Cg==
X-Received: by 10.107.130.153 with SMTP id m25mr40514164ioi.192.1439629987036;
 Sat, 15 Aug 2015 02:13:07 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sat, 15 Aug 2015 02:12:37 -0700 (PDT)
In-Reply-To: <CAN0XMOLDamBeWswDi0cn_naZ2TX+gd89+g48zNwPPKxTh+ZTww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275987>

On Sat, Aug 8, 2015 at 1:12 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> Hi,
>
> when a user made a typo, Git is not good in guessing what
> the user could have meant, except for git commands. I think
> this is an area with room for improvements.
> Let's look into branches. When I "clone --branch" and make
> a typo, Git could show me what branch I could have meant. It's
> the same when I try to merge or track a branch.

Good candidate for those micro-projects next year.

> It might even
> be possible to show suggestions for options for all Git commands.

You mean if you type "--brnch" it should suggest "--branch"? I was
bugged about this and wanted to do something, only to realize in most
cases git would show "git <cmd> -h", which does a much better job
because it would explain what --branch is for as well.

> What I'm trying to say is, there are arguments with a limited
> amount of possible values that Git know, so Git can show
> suggestions when the user made a typo for such an argument.
-- 
Duy
