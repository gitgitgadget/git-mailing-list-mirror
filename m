From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Thu, 14 Aug 2008 04:57:54 +0200
Message-ID: <200808140457.56464.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 04:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTT3d-0004a8-Ck
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 04:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYHNC6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 22:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYHNC6I
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 22:58:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:25431 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYHNC6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 22:58:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so230416fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UdcU8BvkyRMwP3VJXVKDJ/4XFSOxp7kpZqFhu/ZYbsk=;
        b=sdCxWMixTLfy5o0z5leQbSpalbeDig3ndVOm8V7zIx7qdTpKjHrNecPQS9hIp745p1
         foFrwXeLpqz04q06nzIBGH7NrH7jqhgrxY/3A4GPqQgwDCiBBO7NZeoMdZnqyIduv9sg
         IUWzZ5Odza08eOkBKnHtm9ruiAPMZ2cW6SU50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HxMTFSLShauG/Z1yaMPjSULNdyQ+SJszmyOQ4SfoV7EJFVYeSmP7d1qjDyML4Bpp3R
         Fxgb8bADVwdet8iKOeDNhT31HQiWQUZgCGZNJXi+3EWqRbqR3bkWZ/w17DqmQCK+WZ7t
         WO9ItpR/FMy69TuYtlJ3GeDi0a6xN4ManbGXU=
Received: by 10.86.60.15 with SMTP id i15mr1069280fga.43.1218682683508;
        Wed, 13 Aug 2008 19:58:03 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.237.184])
        by mx.google.com with ESMTPS id d6sm2824718fga.2.2008.08.13.19.57.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 19:58:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92309>

Now that according to Google Summer of Code 2008 timeline
  http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
we are in the middle of the suggested 'pencils down' date (August 11 --
-- August 18), I and perhaps other on git mailing list would like
to know what is the current status of all git GSoC 2008 projects.
I think that writing it down would help GSoC manager and co-manager...

Below there are my impressions about state of various Git's Google
Summer of Code 2008 projects, in the sequence the are on Git Wiki
http://git.or.cz/gitwiki/SoC2008Projects (I guess it would be nice
to have final information there after final 'pencils down' date at
18 August 2008).

1. GitTorrent
 
Student: Joshua Roys
Mentor: Sam Vilain

If I remember correctly at midterm it was deemed to be somewhat late;
metainfo was done, tracker was in works, some core infrastructure
and beginnings of peer to peer:
  http://thread.gmane.org/gmane.comp.version-control.git.gittorrent/1

Unfortunately this project, even that is as much tied with git as StGIT,
or egit/jgit, or git-gui or gitk, all of which use git mailing list for 
discussion and patches, choose to have its own separate mailing list; 
moreover I think most of discussion was kept private.

Status: I have no idea how close GitTorrent is to completion (where by 
completion I mean ready, tested and benchmarked code running e.g. on 
kernel.org).  I'm not sure if it is meant to be incorporated in git, 
even in contrib, or remain separate like StGIT, TopGit or jgit.

Student retention: One of reasons in Git application for participating 
in GSoC was having "fresh blood", new long-time contributors.  I have 
vague notion that Joshua is quite active not only with GitTorrent, and 
would stay git contributor...


2. git-statistics

Student: Sverre Rabbelier
Mentor: David Symonds

GitStat development is finished at least with respect to GSoC 2008, see
http://thread.gmane.org/gmane.comp.version-control.git/90691 (for the 
tax reasons), although I guess its development will continue.  

Status: Finished, I think also accepted: what is left is to put it 
eventually in 'contrib/gitstat' or 'contrib/stats'

Student retention: Sverre has said if I remember correctly that he wants 
to work on improving '--follow', which now works only for very simple 
histories, for GitStats to be better among others.


3. Gitweb caching

Student: Lea Wiemann
Mentor: John 'warthog' Hawley

There are new tests for gitweb (to check if caching would not break 
anything new: it did caught a few breakages), new object Perl API to 
git, and gitweb caching implemented using caching data at the level 
slightly above calling git commands.  But full code (tests, Perl API 
and changes to gitweb) are only after first, maybe second round of 
review.  In short, it looks like it is 90% done, as in: "The first 
ninety percent of the task takes ninety percent of the time, and the 
last ten percent takes the other ninety percent."

There is a test site (live demo) up and running on one of the kernel.org 
machines:
  http://odin3.kernel.org/git-lewiemann/

Status: Seems to done, but: not yet merged in, neither used at 
kernel.org or repo.or.cz (i.e. not as fork of gitweb), and no 
benchmarks.

Student retention: unknown.


4. Eclipse plugin push support
 
Student: Marek Zawirski
Mentor: Shawn O. Pearce

JGit can now create (suboptimal) packs: it can reuse delta, but cannot 
currently create one.  This is used to implement push support in 
jgit/egit.

Status: Done, merged in, and used as example to add for example Amazon's 
S3 support and SFTP transport support.

Student retention: I don't know, but I guess it is likely.


5. git-merge builtin (!!!)

Student: Miklos Vajna
Mentor: Johannes Schindelin

In "What's cooking in git.git (topics)" Junio C Hamano wrote:

  It already is beginning to become clear what 1.6.0 will look like.
  [...]
  * git-merge will be rewritten in C.

Status: Done and merged in.
Student retention: Most likely.

 
6. git-sequencer

Student: Stephan Beyer
Mentor: Christian Couder, Daniel Barkalow

There was discussion about TODO file format, there is prototype shell 
script implementation, and reimplementing git-rebase--interactive and 
other using it; there is built-in sequencer done or almost done, but I 
don't remember it being sent to git mailing list for review.  
Benchmarks show performance improvements for built-in sequencer 
versions.

Status: AFAIK close to be done.  I don't know about it being merged-in.
Student retention: Likely.

-- 
Jakub Narebski
Poland
