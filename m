From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [jgit] index v2 pull request
Date: Wed, 12 Mar 2008 08:52:05 +0600
Message-ID: <7bfdc29a0803111952h3cd37b78jd884cec94afe1bc4@mail.gmail.com>
References: <20080308025027.GZ8410@spearce.org>
	 <200803100051.55367.robin.rosenberg@dewire.com>
	 <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
	 <200803102253.28469.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Dave Watson" <dwatson@mimvista.com>,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 03:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZH5F-0001SM-G7
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYCLCwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYCLCwK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:52:10 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:8770 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYCLCwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:52:09 -0400
Received: by an-out-0708.google.com with SMTP id d31so650772and.103
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ip4WQ7Zf1UJaiZczaYH3pA42hUTYxs0MuLigQAVXxss=;
        b=ScrKUuUOvHZrp8N0y8IhAq+Yo1u3ZtAjO3S0huxzga4RjN2O/nwcQYMmKmW/ajN9UYiGxiQK0n8778AuDXJkU5eTCHHXZb5o3V6n9hotEjM8CV7si1BZB9qNMdO34jntk1kI/gISgdbjHHjIBc19BbJFCMA0GK+L6/Wsak4Pvng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNcPuJIFHNyf9Fv1qED8zBC+0YjVWmG7ouTAHdfLHkucQVBZrd4RaQFQT2rABJakjdS2HE3Ik5hbxKZvk43ld0FTLyMwB81RcBhz+80zGwXPuTLO+KuTDLVkV1qCbqghvUKS3RId8FCgev+ZZdehwYQ4J5KdyiyF1caS+FlBQVo=
Received: by 10.100.249.9 with SMTP id w9mr3850147anh.46.1205290328288;
        Tue, 11 Mar 2008 19:52:08 -0700 (PDT)
Received: by 10.100.58.14 with HTTP; Tue, 11 Mar 2008 19:52:05 -0700 (PDT)
In-Reply-To: <200803102253.28469.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76916>

On Tue, Mar 11, 2008 at 3:53 AM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> Den Monday 10 March 2008 08.32.21 skrev Imran M Yousuf:
>
> > I would like to volunteer to work in JGit;
>  > can someone let me know where I can pick some tasks to implement?
>  >
>
>  You can pick about anything you want that noone is working one. Pick something
>  that you feel is withing your grasp, or something simple outside. We need
>  more test cases (doesn't require much programming skills, but thinking). Unit
>  testing of Eclipse stuff falls into the same category. I have litte experience
>  here, but I think there are lots of examples in Eclipse itself if one starts
>  to poke around.
>
>  Diff against workspace/index doesn't work presently. The reworked
>  indexdiffwalker or the iterator could be used for that. Please tell me if you
>  start hacking on this as it's on my listl, just not yet. Should be reasonably
>  hard, involves both jgit and eclipse programming.
>
>  There are some issues with selecting versions in the history view on Windows.
>
>  Copy diff as git patch to the clipboard and vice verse. Send email.
>
>  Harder and might involve more changes all over (that either I or Shawn will
>  object to) is things like rename detection targeted fo r
>
>  Interface to quickdiff machinery for committing specific hunks.
>
>  Blame (even without rename detection) would be useful. Look at the CVS
>  annotate for inspiration.
>
>  Support for git submodules. Will touch the core parts all over the place, but
>  probably not in very intrusive way. Will require lots of test cases.
>
>  Not really git, but highlighting of trailing whitespace is on my wish list. I
>  can't find a plugin that does that.
>
>  Adjust the commit dialog for amend so it shows all to-be commited changed
>  files when amending.
>
>  The number of choices is infinite.
>
>  Ant, Cruisecontrol, Maven, etc-tasks.

Maven: Does this mean mavenizing the project? If so I would start it
this weekend. If you were referring to GIT Maven SCM please also let
me know.
Cruisecontrol: I would instead like to setup Hudson; I find it to be
quite user friendly and flexible at the same time. I would also like
to set up it for JGit. Once we JGit has more features like DIff remote
fetching and stuff we can also build a hudson plugin :).

I am currently looking into .git/config format as Shawn suggested.

- Imran

>
>  Pick a pet.
>
>  -- robin
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
