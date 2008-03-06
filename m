From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Thu, 6 Mar 2008 21:48:01 +0100
Message-ID: <200803062148.01596.robin.rosenberg@dewire.com>
References: <20080304051149.GS8410@spearce.org> <200803052213.20501.robin.rosenberg@dewire.com> <20080306050846.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXN1C-0003IP-QT
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759694AbYCFUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759731AbYCFUsG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:48:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11063 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759624AbYCFUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:48:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7CCCB8028B7;
	Thu,  6 Mar 2008 21:48:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5AGXlLte-rWA; Thu,  6 Mar 2008 21:48:02 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id EF2F280266D;
	Thu,  6 Mar 2008 21:48:01 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080306050846.GQ8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76423>

Den Thursday 06 March 2008 06.08.46 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > You will find support in jgit for this today. Cloning over git and ssh
> > real soon. I'm clensing the oopses from the history right now. (bless
> > rebase -i and git-gui).
>
> I'm sort of waiting to see this fetch history soon.  :-)
>
> The reason is I just got index v2 support (runtime read side) completed
> and I want to add index v2 generation to IndexPack.  I also want to start
> building a PackWriter so we can work on native transport push over SSH.
>
> If we get fetch/push running I think we are heading into the area
> where it is of some real use to people.
>
> > There might be some operations that might be harder to do well in Java.
> > For those exec'ing might be the solution, I'm thinking repack, but then I
> > haven't tried it yet.
>
> I'm determined to even get "proper" packfile generation in Java.
> But it may be time consuming to build.  There may be license issues
> around doing a direct cribbed port of the delta generation.  :-\

If you know where to look, you might find a version of it. :) I don't think
I've changed so much as to prevent you from starting to code the push
part.

> > If someone *did* make a fully reentrant libgit, I'd be inclined to
> > balance my opinions differently.
>
> Really?  If jgit is basically as fast as C git, but doesn't have
> the overheads of dropping in and out of JNI or fork/exec then you
> can actually get pretty good performance out of a Java application.
I meant "might be".  :]

-- robin


