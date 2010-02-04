From: Mike Hommey <mh@glandium.org>
Subject: Re: extra headers in commit objects
Date: Thu, 4 Feb 2010 07:24:49 +0100
Message-ID: <20100204062449.GC6097@glandium.org>
References: <20100203174041.GC14799@spearce.org>
 <d411cc4a1002031158k3e50db30l3f7d73d49e3dad23@mail.gmail.com>
 <20100203224835.GK14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 07:25:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncv9f-0007Iy-E9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 07:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0BDGY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 01:24:58 -0500
Received: from vuizook.err.no ([85.19.221.46]:36962 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab0BDGY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 01:24:57 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Ncv90-00023P-My; Thu, 04 Feb 2010 07:24:53 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1Ncv8z-0001hm-Ny; Thu, 04 Feb 2010 07:24:49 +0100
Content-Disposition: inline
In-Reply-To: <20100203224835.GK14799@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138952>

On Wed, Feb 03, 2010 at 02:48:35PM -0800, Shawn O. Pearce wrote:
> > Anyhow, I was saying that _technically_ you can artificially write
> > extra headers into the commit object (though at the time Dulwich
> > didn't support reading them because of how it parsed commit objects -
> > I believe it would actually explode if it saw something it didn't
> > expect).  I said I was still going to keep the metadata in my
> > implementation in the message, but he was very interested in hiding
> > his in the commit headers.
> 
> Yea, everyone wants to hide that extra metadata.  I never get why.
> Even in SVN.  Why wouldn't I want to see the bug(s) fixed by
> a commit?  Difference of opinion.  I also happen to prefer the
> color blue.  Dammit, everyone should prefer blue.

Note, though, that such information may change in the future, in which
case you can't rewrite the commit to fit that.
But for all that, there are git-notes, now, aren't there ?

Mike
