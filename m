From: Mike Hommey <mh@glandium.org>
Subject: Re: Problem with git filter-branch
Date: Sat, 25 Oct 2008 22:40:12 +0200
Organization: glandium.org
Message-ID: <20081025204012.GA26295@glandium.org>
References: <4902E7D8.6050401@obry.net> <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:41:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtpxD-00067c-3j
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYJYUke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYJYUke
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:40:34 -0400
Received: from vuizook.err.no ([194.24.252.247]:39545 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYJYUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:40:33 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Ktpvv-0005uk-2N; Sat, 25 Oct 2008 22:40:29 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Ktpvg-0006se-6d; Sat, 25 Oct 2008 22:40:12 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99127>

On Sat, Oct 25, 2008 at 10:36:26PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 25 Oct 2008, Pascal Obry wrote:
> 
> > Anyway, I used to run the following command:
> > 
> > $ git filter-branch --tag-name-filter cat --parent-filter "sed -e
> > 's/^$/-p c96d4da294667de1800687d25340551683153002/'" svn-release_2_6
> > 
> > without problem, I now get this:
> > 
> > Namespace refs/original/ not empty
> > rm: cannot remove directory
> > `/home/obry/dev/repositories/git/proj/.git-rewrite': Directory not empty
> 
> It is a (maybe ill-conceived) feature.  When branches are rewritten, their 
> original versions are stored in the refs/original/ namespace.  You can 
> force overwriting with "-f".
> 
> I wonder if people would like to have this feature removed; reflogs should 
> be enough.

I have never have had use for the refs/original namespace, and I used
filter-branch more than a couple of times. Though I would certainly
understand that people would not be confident enough not to have a
parachute. Reflog would indeed be enough, as long as it is not
branch@{42000} that needs to be used. Haven't checked, but theorically,
it should be branch@{1} in all cases, so no problem here.

Mike
