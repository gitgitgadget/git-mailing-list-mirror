From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 09/19] Refactor Config hierarchy to make IO more
	explicit
Date: Sat, 25 Jul 2009 16:38:13 -0700
Message-ID: <20090725233813.GI11191@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org> <200907260054.06037.robin.rosenberg.lists@dewire.com> <20090725225504.GG11191@spearce.org> <200907260134.10820.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqon-0006Yx-1j
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbZGYXiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZGYXiN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:38:13 -0400
Received: from george.spearce.org ([209.20.77.23]:49901 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbZGYXiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:38:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A0164381FD; Sat, 25 Jul 2009 23:38:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907260134.10820.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124099>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s?ndag 26 juli 2009 00:55:04 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > 
> > > This one does not apply for the Config class here.
> > 
> > Did you apply with --whitespace=strip or something and fall afoul
> > of a merge conflict due to changed context?
> 
> Config.java looks (partially) like this:
> 
> --------------------------
> import java.util.Map;
> import java.util.Set;
> 
> /**
> 
> ----------------------------
> 
> and the patch looks (partially again) like this:
> 
> @@ -55,19 +49,18 @@
>  import java.util.Map;
>  import java.util.Set;
> 
> +import org.spearce.jgit.errors.ConfigInvalidException;
>  import org.spearce.jgit.util.StringUtils;

You missed the patch where I added StringUtils.  See "[PATCH]
Ensure Config readers handle case insensitive names correctly"
from Friday Jul 24.
 
-- 
Shawn.
