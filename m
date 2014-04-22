From: David Aguilar <davvid@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 22:19:39 -0700
Message-ID: <20140422051918.GC60610@gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 07:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcT7e-0004kz-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 07:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbaDVFTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 01:19:50 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62468 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaDVFTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 01:19:49 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so4449719pdj.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cLqGIw85YuvIrUayhoa4MBf5QqFXYw1J2bk4Wj1ZF4M=;
        b=0/2taxRVK/M472xyHep2Umsa06N4UNC0d+o7347BBdL21KZ6t2hLcjZQrnx7wWxJ6f
         WZKftbaWGh7anWjmfhITpm4y9v9JZ+M1bsb4OpOMIdPfxZEZz8EzMsYrTVGoTKAD2x1a
         8d/jB4g7uIsNTZ3uS7vMolP+8ew488nxdZ1klQqwveu5fMCdw6wKVLZ3EqXnvmdIA4hO
         v/G6xm0WM8tPEyzBWz1bKVABFMclzXXX2Q0V4u+qEZrGCmN1ImJXBB8RKkicv2Tpq4yX
         NBr5DUEgMMvrXDsa9vmr0f7vJwZZg/gkn+h40zbvp7uXzFmhQfbrnJRBksFoUz9K2g5E
         lWug==
X-Received: by 10.68.134.101 with SMTP id pj5mr42479619pbb.62.1398143988608;
        Mon, 21 Apr 2014 22:19:48 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id qq5sm81962400pbb.24.2014.04.21.22.19.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 22:19:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246693>

On Sun, Apr 20, 2014 at 05:41:05PM -0500, Felipe Contreras wrote:
> = Reject non-fast-forward pulls by default =
> 
> Many new-comers end up making merges by mistake when they pull because
> they don't understand what is a non-fast-forward and what they should
> actually be doing. Most people, even Linus Torvalds, agreed that by
> default `git pull` should fail and guide the user, instead of silently
> making a merge which might not be what the user wants (even though he
> doesn't know it), and messing up the project's history, which affects
> other people.
> 
> The patches were sent, the issues were addressed, people agreed, and
> yet nothing happened.

We can currently set pull.ff = only to get this behavior.
I would like it if this were the default (but I am biased).

> = Use "stage" instead of "index" =

I'm probably biased about this one too, but I should probably speak up.

git-cola has used "Staged", "Modified", "Untracked", etc. since
the beginning of time.  Sorry 'bout that, but it seemed like the
simplest word to use.

I often hear users talking about "staging" files.
I'm probably in an echo chamber, but I never really had to
explain "the staging area" since the concept is pretty natural
when interacting with the GUI.

Just my $.02.

ciao,
-- 
David
