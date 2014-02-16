From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Ambiguous branch names...
Date: Mon, 17 Feb 2014 05:47:16 +0700
Message-ID: <CACsJy8Cfv0-QQBX=Psm28wWbpM8Jra4POPUGgsFbn6EB2Yk9Zw@mail.gmail.com>
References: <20140216203439.GA15538@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ingo Rohloff <lundril@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 16 23:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFAVB-0007tQ-AL
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 23:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbaBPWrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 17:47:48 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:42006 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaBPWrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 17:47:48 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so22462936qcq.4
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 14:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vz5oGiY5DGUvZInXhG2fTyn9E4kyuzk5XXU83jEocAY=;
        b=mxpE8jqANAthFjf1++rvfuukbRlBMR5yiOWUP093ZZVTYo1BUUwnJ0QcCHkm9k5tSB
         th/5fBtSWfcBKnpHuMxcEOvb3V3NK2thWHL91WBYZ5BbRtMCfDR/8NqTWOfCziKWkwi9
         GlpT3UvqgWJRpysSpEIUCY8cfN0uUjKSQ7woiZXZdYwyyicjMYAZZslNQaqIE/eJSxck
         ya5EZHZI9/xscdVw3+u2KYpoHJVNCXTOZdO2j49w+uhnFqP5oDwriqb5jc2/LiwiqwFi
         zlMnSkpO7Fb3e/yuAvvsu9ZVerRUORCny5lKtJAkapsl4pojvrESroG8J592vGkExhI+
         xAsw==
X-Received: by 10.140.109.72 with SMTP id k66mr29006703qgf.20.1392590866238;
 Sun, 16 Feb 2014 14:47:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 16 Feb 2014 14:47:16 -0800 (PST)
In-Reply-To: <20140216203439.GA15538@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242243>

On Mon, Feb 17, 2014 at 3:34 AM, Ingo Rohloff <lundril@gmx.de> wrote:
> Hello,
>
> while trying out git (version 1.7.9.5), I did this:
>
> git clone -- ssh://myserver/~rohloff/git/w1.git w1
>
> So I just cloned a test repository.
> The in the cloned "w1" repository I executed:
>
> git branch origin/master
> git branch remotes/origin/master
> git branch refs/remotes/origin/master
>
> I now have got three *local* branches with the above names, which
> now seems to make it impossible to refer to the master branch
> from the "origin" *remote* repository.
>
> Wouldn't it make sense to forbid such names for local branches ?
> For example to enforce some rules like a local branch name *must not*
> start with "remotes/" or "refs/" ?

See http://thread.gmane.org/gmane.comp.version-control.git/242096/focus=242181.
The proposal basically is you can't create those branches without -f.
-- 
Duy
