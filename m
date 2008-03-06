From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Thu, 6 Mar 2008 11:33:26 +0600
Message-ID: <7bfdc29a0803052133p67741421gb6aa1b1f7357dd90@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
	 <20080305053612.GA8410@spearce.org>
	 <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
	 <200803052213.20501.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:34:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8kJ-0007kb-Qu
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbYCFFd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbYCFFd3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:33:29 -0500
Received: from hu-out-0506.google.com ([72.14.214.227]:52773 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbYCFFd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:33:28 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1206742hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 21:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZJTYoVKP9B/6MXIkI7M26mjPqYRLo/VfiFLFsHRo9mA=;
        b=TgofEuXXjiQ66rSbbt/51QwoWm15iUimfbx8EgEAqrY+EeBLty7VTOW75YTDjxJffTmMIp5QPcIDWdd/EAchJ2EWxWjijssdvrLLtaeD5a6ZGtSVdUC/LliEVbrCPV5eju0ivZG/cZ0P/cVb/Rho1Fpq+1ToqxcNZtPqV8SgqXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vWTSPEmOgZygz+AbWGwDrbXZTdqQhFyUttKGM5MqZshWUwJMKWNO0GxIbvAXImw4bApMcHTMGH+uXa6bdTXtvWvV5m9CyDXd+gMyXjaiowPQcWy3esHCO4PmEhUG0Vt92B8ZN6phL3nXPIdvmz30hpJZjLLTBzcyQXl2iUKpLDY=
Received: by 10.78.182.17 with SMTP id e17mr9005458huf.26.1204781606961;
        Wed, 05 Mar 2008 21:33:26 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 21:33:26 -0800 (PST)
In-Reply-To: <200803052213.20501.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76335>

On Thu, Mar 6, 2008 at 3:13 AM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> Den Wednesday 05 March 2008 08.58.15 skrev Imran M Yousuf:
>
> > I would like to suggest 2 projects that I want to work as a developer
>  > (and/or mentor):
>  >
>  > 1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
>  > The aim of the plugin is to integrate GIT with NetBeans using JNI so
>  > that any change in the implementation of GIT does not effect the SCM
>  > plugins way of work.
>  > Language: Java
>  > Goal: Make GIT available from IDE for NetBeans users and use GIT using
>  > Java Native Interfaces
>
>  As the current acting maintainer or egit/jgit I would not mind cooperating
>  with making it available to Netbeans, J2EE and command line interface or
>  whatever.

I am honoured and would be grateful for your support.

>
>  You can make a plugin for Netbeans today that will do the basic like walking
>  the history, finding out what to commit, commit, switch/create/reset
>  branches, decorations based on jgit and you wouldn't need to change a thing
>  in jgit. There might be things you *want* to change, but that's another story
>  and applied to the continued development for the Eclipse plugin too. Even
>  the license might be changed.

I was taking a look at the Mercurial VCS Plugin for NetBeans and I
think GIT's one will be similar. Using jGit would be great; Do you
have any plans to have a Maven version of jGit so that it could be
used from any Maven project? Another question is - Is jGit dependent
on any Eclipse API (dont even bother if the answer is no)? Can we have
a separate repo for jGit so that it is maintained independently on
eGit?

>
>  You will find support in jgit for this today. Cloning over git and ssh real
>  soon. I'm clensing the oopses from the history right now. (bless rebase -i
>  and git-gui).
>
>  There are no dependencies on Eclipse and I do not plan on introducing any.
>  Jgit and Egit live in the same repo at the moment simply because there are
>  no other users of egit so far.
>
>  There might be some operations that might be harder to do well in Java. For
>  those exec'ing might be the solution, I'm thinking repack, but then I haven't
>  tried it yet. In general jgit is almost as fast as git and probably
>  outperforms git on windows as git there doesn't use  memory mapped I/O for
>  packs (something I'd expect someone or even me to fix soon). For JNI'ed
>  operations the complexity is just horrible and even when possible, there is
>  a lot of overhead for JNI itselt, conversion from UTF-16 to somehing
>  eightbitish and back. On windows there's even yet another layer of
>  eight-bitish to UTF-16 and back in the Win32 API. Jgit also uses memory
>  mapped I/O on all platforms that support it for pack reading.
>
>  If someone *did* make a fully reentrant libgit, I'd be inclined to balance my
>  opinions differently.
>
>  -- robin
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
