From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/9] Gitweb caching v5
Date: Thu, 14 Jan 2010 17:40:08 -0800 (PST)
Message-ID: <m37hrkdu4k.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:40:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVbAo-0002z1-HY
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 02:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0AOBkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 20:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937Ab0AOBkO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 20:40:14 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:58566 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab0AOBkM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 20:40:12 -0500
Received: by fxm25 with SMTP id 25so151182fxm.21
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 17:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zg3zID1fs232BYx9ybHnWNr2+QuhUi6M62QnbDK8E1U=;
        b=pKmtJ3Cidbo1Xr5pcV8m83P5vm5Qi6PR68tEx6Ld8TzPFby1lKgsgfyIu3Zpc/PIxq
         kinz+k2cVQNbvetIF+EBxPQ5iejD1lG22GBhtwdRbIO4iFbIGKA8j45Hsl2ekZay0igl
         yWwt72bRY/sb2YsxD2w/HRXTNK/n2Nz9nLDqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TK/tzSBZ8QpMIZWepao0syWxUygfkiICVSQGklk/RDI48kV1+trx+pF4JknaD73qYy
         FB/j90/eQJWINnldQfs/Dk4COSQiwk2yexBDx4g+vFPWAx8/oIVMsJ9HWWL5+asVg+ZC
         A17dIrknVBnJDACnnanbMcjC53JNdTVD9lIto=
Received: by 10.102.16.13 with SMTP id 13mr732958mup.62.1263519610073;
        Thu, 14 Jan 2010 17:40:10 -0800 (PST)
Received: from localhost.localdomain (abvp131.neoplus.adsl.tpnet.pl [83.8.213.131])
        by mx.google.com with ESMTPS id 12sm4223011muq.48.2010.01.14.17.40.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 17:40:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0F1dU6a011648;
	Fri, 15 Jan 2010 02:39:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0F1d8uO011632;
	Fri, 15 Jan 2010 02:39:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137047>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> Afternoon everyone,
>  
> This is the latest incarnation of gitweb w/ caching.  This is
> finally at the point where it should probably start either being
> considered for inclusion or mainline, or I need to accept that this
> will never get in and more perminantely fork (as is the case with
> Fedora where this is going in as gitweb-caching as a parrallel rpm
> package).
> 
> That said this brings the base up to mainline (again),

Could you tell us which commit is the base of this series (like in
git-request-pull output), i.e. which commit this series is rebased
against?

> it updates a
> number of elements in the caching engine, and this is a much cleaner
> break-out of the tree vs. what I am currently developing against.

Is caching engine part changed since v2?

> v5:
> 	- Missed a couple of things that were in my local tree, and
> 	  added them back in.

That doesn't tell us much.

> 	- Split up the die_error and the version matching patch
> 	- Set version matching to be on by default - otherwise this
> 	  really is code that will never get checked, or at best
> 	  enabled by default by distributions
> 	- Added a minor code cleanup with respect to $site_header
> 	  that was already in my tree
> 	- Applied against a more recent git tree vs. 1.6.6-rc2
> 	- Removed breakout patch for now (did that in v4 actually)
> 	  and will deal with that separately 
> 
> 	http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v5
 
----
Short comments about patches in this series; I will be sending
detailed comments for each patch individually.

> John 'Warthog9' Hawley (9):
>   gitweb: Load checking
Looks good.

>   gitweb: change die_error to take "extra" argument for extended die
>     information
Commit message could be better (summary should really be shorter), and
I think there is some indent typo, but otherwise looks good.

>   gitweb: Add option to force version match
For me it needs to be disabled in gitweb test suite (t/gitweb-lib.sh),
if it is enabled by default.  I really like that I can test current
gitweb without need to recompile git.

Also it should have tests that it works as intended (both for matching
and non-matching versions) in t/t9501-gitweb-standalone-http-status.sh

>   gitweb: Makefile improvements
Does it differ from my proposal (i.e. gitweb/Makefile doing the work),
based on your idea ("make gitweb" for Makefile and gitweb/Makefile)?

>   gitweb: add a get function to compliment print_local_time
>   gitweb: add a get function to compliment print_sort_th
Those two looks O.K. from what I seen.

>   gitweb: cleanup error message produced by undefined $site_header
Shouldn't there be such protection for other such variables, like
$site_footer and $home_text (and a bit diferent protection against
undefined $projects_list)?  By the way, how did you arrived at
undefined $site_header: deafult build configuration leaves it empty,
but defined. 

>   gitweb: Convert output to using indirect file handle
I have alternate solution, using shorter filehandle name (just $out)
in

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel
  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel

I would have to think a bit about separate handle for binary files;
I am not sure if it is really required.

>   gitweb: File based caching layer (from git.kernel.org)
I am working (time permitting) in spliting this large code drop into
smaller commits, namely:

 - href(..., -path_info => 0)          (for cache key)
 - simple file based caching + tests
 - global expire time + tests
 - output caching in gitweb            (WIP)
 - adaptive expiration time            (planned)
 - tee output / cache write            (planned)
 - expire time variation from CHI      (planned)
 - locking for single writer           (planned)
 - server-side generating info         (planned)
 - AJAX-y generating info              (wishlist)

while ensuring that it pass all existing gitweb tests, and adding new
tests for new features.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
