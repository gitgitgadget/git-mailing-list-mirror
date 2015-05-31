From: David Aguilar <davvid@gmail.com>
Subject: Re: Staging commits with visual diff tools?
Date: Sat, 30 May 2015 18:59:57 -0700
Message-ID: <20150531015956.GA64502@gmail.com>
References: <alpine.DEB.2.10.1505262147230.3709@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Lee <jjl@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 04:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YysY0-0002ma-HP
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 04:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbbEaCAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 22:00:07 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35765 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbbEaCAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 22:00:05 -0400
Received: by padjw17 with SMTP id jw17so12130562pad.2
        for <git@vger.kernel.org>; Sat, 30 May 2015 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CMbVcKNCq83N+Cb/t+mzcPS7v+GrKCv3/MwwcpCXZtg=;
        b=rdRDGCQ7D0sZzYUSkFQDVIMNRGq4rxW8We+7yxfncaWdlJhMxutxjp06J6APcfWw1d
         KCBESJPOkRfWzV1F04sGmaRL8K/O2VKMLkShk5I9IoNyE+/S1lftAWOoNuMKwJfujKsh
         QPf0dRwc6Kt1DLi7oFPOz1uUeCMEcXSw4iJrpHk+yyZXuWxA1g6pIkBeRuHPwoHy2g/G
         rkAPNAeiou4fxK4Xp30Lj9zIVtWXI9kxbwOK0Sj2JkXwAeSOeDEPHBQLWpLp6wUiexMe
         eyay0TxSnLu0/krtMvSC0n0LjS9CDsS8hqGbSMbeylGzVvNs32RR5qApEyOVUvji/h9n
         rxmQ==
X-Received: by 10.70.94.167 with SMTP id dd7mr28526782pdb.115.1433037604321;
        Sat, 30 May 2015 19:00:04 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id wh6sm9920242pbc.96.2015.05.30.19.00.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 30 May 2015 19:00:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1505262147230.3709@alice>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270309>

On Tue, May 26, 2015 at 09:50:49PM +0100, John Lee wrote:
> Hi
> 
> Does anybody have code to stage commits using a the visual
> diff/merge tools supported by git-difftool?  Is there support in git
> itself somewhere, even?
> 
> I'm looking for something functionally similar to git add -p
> 
> Looking at the git-difftool source I can see how to write a command
> to do it, but wanted to check if it had already been implemented.
> 
> Did I miss a way that already exists?
> 
> Thanks
> 
> 
> John

If you're interested in existing staging tools then I would
highly suggest looking at git-cola.

    https://github.com/git-cola/git-cola

    git clone git://github.com/git-cola/git-cola.git

git-cola is free software so it's pretty unique in many ways.
I also wrote it, so that makes it that much more awesome ;-)

cola has a very slick interactive staging editor, interactive
rebase, and a whole lot more.

I'm a g/vim user, so git-cola is finely tuned for keyboard
usage.  If we implement these feature in Git, we should consider
providing the same workflows/hotkeys as cola.

For staging, you can select lines, hit "s", and they'll be
staged/unstaged.  ctrl-u reverts unstaged edits, etc.
The '?' hotkey shows the help, etc.

You can get extremely granular, moreso then "add -p", which is
why it exists.  When cola's diff editor is not sufficient, you
can also use it to drive difftool, but only in ways that you can
on the command-line already.

git-cola is written in Python(2+3) so it's easy to hack on, and
quite portable.

cheers,
-- 
David
