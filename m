From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 08:55:57 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121129135557.GB26607@thyrsus.com>
References: <20121129055946.2D7B84065F@snark.thyrsus.com>
 <20121129075829.GE3424@lp-shahaf.local>
 <20121129114637.GB9264@thyrsus.com>
 <20121129134203.GJ3424@lp-shahaf.local>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, git@vger.kernel.org
To: Daniel Shahaf <danielsh@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 14:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te4b9-0001kf-AR
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 14:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab2K2Nz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 08:55:59 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:53218
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab2K2Nz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 08:55:59 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 578ED4065F; Thu, 29 Nov 2012 08:55:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121129134203.GJ3424@lp-shahaf.local>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210833>

Daniel Shahaf <danielsh@elego.de>:
> I don't see the kludge here --- git has a "author" != "committer"
> distinction, svn doesn't, so if you want to grow that distinction the
> most natural way is a new property.  Storing additional information in
> svn:author is a separate issue.

See my advocacy to Branko of going to Internet-scoped IDs. The kludge
would be maintaining the local and Internet-scoped identifications 
as different properties and having to decide which one to key on
ad-hoc.  Nothing to do with the author/committer distinction. 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
