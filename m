From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: Re: [PATCH] git-pasky debian dir
Date: Fri, 22 Apr 2005 14:00:11 -0400
Message-ID: <200504221400.11507.jcorbin@wunjo.org>
References: <200504220918.06977.jcorbin@wunjo.org> <20050422161635.GA5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:56:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2Nj-0000iY-6a
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVDVSA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVDVSA1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:00:27 -0400
Received: from smtp1.losch.net ([66.212.32.3]:19168 "HELO smtp1.losch.net")
	by vger.kernel.org with SMTP id S262096AbVDVSAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 14:00:17 -0400
Received: (qmail 19104 invoked by uid 102); 22 Apr 2005 18:00:17 -0000
Received: from 66.212.35.47 by smtp1 (envelope-from <jcorbin@wunjo.org>, uid 71) with qmail-scanner-1.24 
 (clamdscan: 0.80/848.  
 Clear:RC:1(66.212.35.47):. 
 Processed in 0.023391 secs); 22 Apr 2005 18:00:17 -0000
Received: from office.losch.net (66.212.35.47)
  by smtp1.losch.net with SMTP; 22 Apr 2005 18:00:17 -0000
To: Chris Wright <chrisw@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <20050422161635.GA5324@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 22 April 2005 12:16, Chris Wright <chrisw@osdl.org> wrote:
> This whole bit should be formalized.
Agreed, hence why I did it as a package-build-time patch instead of changing 
directly in my repository.

> Ideally, I'd like to do /usr/bin/git frontend, with all scripts
> in /usr/libexec/git/.
How standard is this '/usr/libexec'? I have no such directory on my Debian 
boxes. If /usr/share rubs you the wroung way, what of 
simply /usr/lib/git-pasky?

> However, this requires something more than hardcoding paths.
Definately, and it may not play well with the simpler method of installing to 
$HOME/bin. This was just a quick hack as not to pollute /usr/bin with files 
that aren't directly executed by the user.

> You get the idea ;-)  I certainly see how it makes sense for a first
> run to get it going. But this will need fixing upstream.
This will all be moot when cogito goes the way of cg-* ;-)

Cheers,
Josh

-- 
Regards,
Joshua T. Corbin <jcorbin@wunjo.org>
