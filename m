From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk won't show notes?
Date: Sat, 11 Apr 2015 20:31:56 +1000
Message-ID: <20150411103156.GA5781@iris.ozlabs.ibm.com>
References: <551D99B9.7040200@ubuntu.com>
 <5523DE66.8060904@drmicha.warpmail.net>
 <5523E479.2010701@ubuntu.com>
 <5523E5FF.8060101@drmicha.warpmail.net>
 <55240F0A.80902@ubuntu.com>
 <5525164C.6000309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 12:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ygslu-00043L-K5
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 12:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbbDKKgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 06:36:13 -0400
Received: from ozlabs.org ([103.22.144.67]:56474 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbDKKgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 06:36:12 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E36F81402EC; Sat, 11 Apr 2015 20:36:10 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <5525164C.6000309@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267021>

On Wed, Apr 08, 2015 at 01:51:40PM +0200, Michael J Gruber wrote:
> Phillip Susi venit, vidit, dixit 07.04.2015 19:08:
> > On 4/7/2015 10:13 AM, Michael J Gruber wrote:
> >> Seriously: gitk knows F5 and Shift-F5 for refresh, and I think the 
> >> latter is the thorougher refreshment.
> > 
> > Neither one makes newly added notes show up.  The only way seems to be
> > to close and restart gitk.  Looks like a bug.
> > 
> > 
> 
> Apparently, gitk rereads the refs but not commits it has read already -
> and the commit reading includes the notes lookup.
> 
> Unfortunately, my wish-fu is lacking. But I'll cc the master.
> 
> Paulus: None of updatecommits, reloadcommits and rereadrefs seem to
> reread the notes of a commit that has been displayed already if the
> notes have changed (but the other refs have not).

As far as shift-F5/reloadcommits is concerned, it looks like I should
be unsetting commitinfo in reloadcommits.

However, I agree gitk should refresh the notes in updatecommits as
well, but that will take more work.  Is git notes list the best way to
find out all the current notes?

Paul.
