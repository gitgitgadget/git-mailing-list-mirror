From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-pack-objects.txt: Make wording slightly less ambiguous
Date: Sun, 6 Apr 2008 00:35:13 -0400
Message-ID: <20080406043513.GZ10274@spearce.org>
References: <20080405194649.GA248@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Apr 06 06:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiMbv-00074n-9U
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 06:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYDFEfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 00:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYDFEfT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 00:35:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33033 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbYDFEfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 00:35:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JiMb5-0002qo-Nw; Sun, 06 Apr 2008 00:35:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B960120FBAE; Sun,  6 Apr 2008 00:35:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080405194649.GA248@bohr.gbar.dtu.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78884>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> It is a bit confusing on first read, that
> 
>         "The packed archive format (.pack) is designed
>         to be unpackable..."
> 
> Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>

Yea, this is a good improvement in readability.  I can't even
make sense out of the old language, and I know how this works.

:-)

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index eed0a94..3a1be08 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -22,8 +22,9 @@ archive with specified base-name, or to the standard output.
>  A packed archive is an efficient way to transfer set of objects
>  between two repositories, and also is an archival format which
>  is efficient to access.  The packed archive format (.pack) is
> -designed to be unpackable without having anything else, but for
> -random access, accompanied with the pack index file (.idx).
> +designed to be self contained so that it can be unpacked without
> +any further information, but for fast, random access to the objects
> +in the pack, a pack index file (.idx) will be generated.
>  
>  Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
>  any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)

-- 
Shawn.
