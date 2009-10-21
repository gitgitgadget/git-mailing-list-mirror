From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 08:30:08 +0200
Message-ID: <20091021063008.GA3349@glandium.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 08:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0UhO-0000Ua-2T
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 08:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZJUG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 02:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbZJUG3U
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 02:29:20 -0400
Received: from vuizook.err.no ([85.19.221.46]:55342 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbZJUG3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 02:29:20 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N0UhB-00078o-T4; Wed, 21 Oct 2009 08:29:20 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N0Ui0-0000v6-T4; Wed, 21 Oct 2009 08:30:08 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130888>

On Tue, Oct 20, 2009 at 07:56:01PM -0400, Daniel Barkalow wrote:
> On Tue, 20 Oct 2009, Thomas Rast wrote:
> 
> > Hi all,
> > 
> > While everyone is busy in two other UI threads, I figured I might as
> > well toss up another (probably) controversial topic.
> > 
> > Especially on IRC, we see many people who are some combination of
> > misunderstanding, misusing or overusing git-pull.  I figure this is
> > the result of several factors, notably
> > 
> > a) pull/push are not symmetric,
> 
> In a certain sense they are; they both update the branches local to one 
> repository with the data from the other repository. In this sense, fetch 
> is the oddity in that it doesn't update any repository's own branches, but 
> just the local information about other repositories' branches.

BTW, shouldn't fetch be deprecated in favour of git remote update ?
(this may require adding some features to git remote update, but you get
the idea)

Mike
