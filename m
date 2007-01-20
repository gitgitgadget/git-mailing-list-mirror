From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] [EGit] Indroduce GitAction class
Date: Fri, 19 Jan 2007 22:18:08 -0500
Message-ID: <20070120031808.GA11200@spearce.org>
References: <8b65902a0701191332n5055a28bi59600e35140582de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 04:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H86kC-0003gG-Rt
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 04:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXATDSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 22:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbXATDSN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 22:18:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44132 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbXATDSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 22:18:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H86jv-00070y-GA; Fri, 19 Jan 2007 22:17:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8573920FBAE; Fri, 19 Jan 2007 22:18:09 -0500 (EST)
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Content-Disposition: inline
In-Reply-To: <8b65902a0701191332n5055a28bi59600e35140582de@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37254>

Guilhem Bonnefille <guilhem.bonnefille@gmail.com> wrote:
> I introduce GitAction as base class for all actions. It allows to
> disable the action menu item if the selection does not live in a Git
> controlled repository.
> 
> The current code is quite "gruik". It is mainly based on copy/paste
> from other plugins.
> 
> A better solution could be to avoid inserting EGit actions in menus if
> the selection does not live in a Git repo. (some plugin.xml hack)

Thanks for the patch!  I've applied it, and done some cleanup
behind.  I really appreciate that someone else is trying to help
egit move along.

A few thoughts:

 * Please format your code using the Eclipse formatter prior to
 a patch.  The project settings are configured to be the builtin
 Java Conventions that ship with Eclipse.  I rely *very* heavily on
 the Eclipse formatter being able to format my source code for me,
 so that I don't need to worry about whitespace, brace placement,
 line breaks, etc.  It saves me tons of time.

 * I noticed the copyright you sent in on one of your files was dated
 2006.  I applied it as is.  Are you sure you did not mean 2007?  ;-)

 * You did not send the patch inline or as an mbox.  This makes
 it much more difficult for me to apply the patch with `git am`.
 In the future can you please either submit the patch inline, or
 format using `git format-patch` and attach the *entire* output so
 that I have a proper Date/From/Subject/commit-message immediately
 available?

By the way, I have just added a SUBMITTING_PATCHES file at the top
level directory of the egit.git repository which covers some of
these topics.  I apologize for not shipping one earlier with the
project, as doing so may have eliminated some confusion.

-- 
Shawn.
