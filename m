From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 17:08:23 -0800
Message-ID: <20131211010823.GH2311@google.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
 <20131209204815.GV29959@google.com>
 <20131210084622.GC4087@linux.vnet.ibm.com>
 <CACsJy8Bsgfh=0mTHY4kFAXE6+y7ODx5AwVHcLzVgz01Biiy=7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 02:08:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYI8-00018e-6h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab3LKBIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:08:40 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61874 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3LKBIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:08:40 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so4519728yho.24
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qIFG6nIE2QSJs0RkZVnVbdSvminlFUtO09FLrQuTxS8=;
        b=I3uaWccFIbSNXqYPZD+0xHvMf1F+Uq0C2acZfu15aLPT5JtZ5qxYGTuSs7NpR2kfxW
         LTFU1JSYXGltpcwTRPcMpQPCuTdKlrTHE/auPJ1XxklhQG9/KmKkEhvKX4MLVU5J+H9+
         rPy1mhTt5rDlBZvyDMi3EI4iVG9KErftycWqDztahH1P3Cr3Q+Jj6+55ZVnAG5xKTcGW
         al5St6lfMTlMy6MMHkBP8c9d/w6daDTRzr5C17BK0mf8ad4B788U25uKnKbJkEzcjKOF
         73SoaU4Fi4dagn2K5bOWpGLwMhpZW+1b9t3W0UvdTSmOuH0VJa19Cmvm6yLdhFcAdFgT
         LWJQ==
X-Received: by 10.236.5.174 with SMTP id 34mr9622211yhl.48.1386724119513;
        Tue, 10 Dec 2013 17:08:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm25529260yhj.22.2013.12.10.17.08.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 17:08:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Bsgfh=0mTHY4kFAXE6+y7ODx5AwVHcLzVgz01Biiy=7A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239162>

Duy Nguyen wrote:

> I wonder if we could promote multiple worktree from a hack to a
> supported feature. What I have in mind is when you "clone
> --separate-worktree" it would create a .git file that describes
> separate worktree:
>
> gitbasedir: /path/to/the/original/.git
> name: foo
>
> HEAD, index and logs/HEAD would be stored in
> /path/to/the/original/.git/worktrees/foo/.

I like this idea a lot.

Jonathan
