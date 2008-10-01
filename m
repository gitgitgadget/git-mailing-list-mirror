From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 08:03:08 -0700
Message-ID: <20081001150308.GZ21310@spearce.org>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20081001061249.GC22363@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raphael Zimmerer <killekulla@rdrz.de>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:04:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3FY-0000jw-Mr
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYJAPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYJAPDJ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:03:09 -0400
Received: from george.spearce.org ([209.20.77.23]:43732 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbYJAPDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:03:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1237438360; Wed,  1 Oct 2008 15:03:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081001061249.GC22363@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97230>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Sep 30, 2008 at 11:13:10PM +0000, Raphael Zimmerer wrote:
> > +	printf("%s%c", name, opt->null_following_name ? 0 : '\n');
> 
> I know I'm nitpicking and I don't know what the git custom on this
> really is, but I tend to prefer '\0' when in the context of a char.
> There is no confusion here of course, but I believe it to be a sane
> habit. (In the same vein that it's ugly to use 0 for NULL ;p).

Its a valid nitpick.  NUL is '\0' when dealing with chars in Git,
NULL is NULL, and 0 is the integer 0.  That line should read '\0'
to conform with the other code already in git.git.

-- 
Shawn.
