From: Tim Larson <tim@keow.org>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Thu, 9 Feb 2006 16:44:20 +0000
Message-ID: <20060209164420.GD14116@localhost>
References: <87slqtcr2f.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 09 17:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7EtV-0003d9-Gy
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 17:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWBIQnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWBIQnn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 11:43:43 -0500
Received: from keow.org ([207.210.74.19]:49871 "HELO keow.org")
	by vger.kernel.org with SMTP id S1422764AbWBIQnm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 11:43:42 -0500
Received: (qmail 1470 invoked from network); 9 Feb 2006 16:44:20 -0000
Received: from localhost (127.0.0.1)
  by keow.org with SMTP; 9 Feb 2006 16:44:20 -0000
Received: (nullmailer pid 1465 invoked by uid 1000);
	Thu, 09 Feb 2006 16:44:20 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87slqtcr2f.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15814>

Reading bits an pieces of your email gives an idea:
[...given at the end of this email]
On Wed, Feb 08, 2006 at 04:29:44PM -0800, Carl Worth wrote:
> So, here I am as a newly converted index-embracer---no more index
> denying from me.
> 
> However, I'm still trying to wrap my brain around the various diff
> commands that git provides and how they would fit into my workflow,
> Junio and I have touched on this already in a previous thread, but I'm
> starting here with more fresh and complete analysis of the UI around
> diff.
...
> [*] It's not the original topic of this post, but now that I've
> finished this, I realize that if the diff proposal were implemented
> then "commit-files" would make a dandy replacement for "commit
> -a". That could lead to finally providing the parallel preview
> commands I originally wanted:
> 
> 	git diff-index	# as preview for
> 	git commit-index
> and:
> 	git diff-files	# as preview for
> 	git commit-files
> 
> Then "git commit" would just be a shortcut for git commit-index.
> 
> (Oh, and that would also lead to a natural "git ci" abbreviation too,
> if desired. This would parallel the "ci == checkin" abbreviation that
> some other systems provide.)
> 
> I think the separate notions of commit-index and commit-files would do
> a good job of allowing for simple tutorials, (eliminates the "what the
> heck is -a all about?" questions), that also don't contribute to
> general index-unawareness lead to later index-confusion as the current
> "git diff; git commit -a" does.
> 
> This might even lead to a natural distinction between "git
> status-index" and "git status files" too.

...and now the idea:
What if we leave the normal long commands alone, so scripts and
muscle memory are not disturbed, but create some short commands
that give intuitive true parallel previews:
  "git di" and "git ci" (diff or commit index)
  "git df" and "git cf" (diff or commit files)
  "git dm" and "git cm" (diff or commit merge)
and of course any other little bits as needed like:
  "git si", "git sf", etc. (status index, status file, etc.)
This would give a chance to "start over" with clear commands,
without causing a ruckus among existing loyal users.  WDYT?

--Tim Larson
