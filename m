From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 02:44:51 -0400
Message-ID: <20070425064451.GF5942@spearce.org>
References: <1177482982542-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 08:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgbFL-0001xg-B5
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 08:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161620AbXDYGo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 02:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161622AbXDYGo4
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 02:44:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56162 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161620AbXDYGoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 02:44:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgbFE-0002tH-LG; Wed, 25 Apr 2007 02:44:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6447320FBAE; Wed, 25 Apr 2007 02:44:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1177482982542-git-send-email-junkio@cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45501>

Junio C Hamano <junkio@cox.net> wrote:
> This adds --local-zone option to log family of commands, to
> display timestamps in user's local timezone.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * I got tired of looking at +0000 timestamps on commits
>    imported from CVS at day-job.  Does not seem to break
>    existing tests, but I am not sure if this is useful.

Not only is it useful, I'd like to see a way to make it my default!
(By my default here I mean a .gitconfig thing that I can set,
but not making it the git out-of-the-box default.)

I don't like looking at timestamps in other people's timezones.
If git-log is going to go through the motions of performing unicode
translations for my tty, and indent messages, and convert the epoch
seconds to a human readable date, it most certainly can be nice and
put the times into my default frame of reference.  Which is whatever
my congresscritters have decided the time is this month...  ;-)

-- 
Shawn.
