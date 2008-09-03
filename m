From: Mike Hommey <mh@glandium.org>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 19:10:29 +0200
Organization: glandium.org
Message-ID: <20080903171028.GA1657@glandium.org>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org> <48BE56BD.6050805@gmail.com> <200809031316.05336.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ittay Dror <ittay.dror@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavtZ-0004LU-M0
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYICRKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYICRKr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:10:47 -0400
Received: from vuizook.err.no ([194.24.252.247]:46873 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbYICRKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:10:47 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KavsG-0008RQ-9S; Wed, 03 Sep 2008 19:10:39 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KavsD-0000iM-0t; Wed, 03 Sep 2008 19:10:29 +0200
Content-Disposition: inline
In-Reply-To: <200809031316.05336.johan@herland.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.4): No, score=0.4 required=5.0 tests=RDNS_DYNAMIC,WHOIS_DMNBYPROXY autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94818>

On Wed, Sep 03, 2008 at 01:16:05PM +0200, Johan Herland wrote:
> On Wednesday 03 September 2008, Ittay Dror wrote:
> > Note: codeville tried to implement a merge algorithm that considers
> > the history to decide what the user wants to do:
> > http://revctrl.org/PreciseCodevilleMerge. Maybe worth while
> > exploring?
> 
> You haven't been here long, have you? ;)
> 
> There was an infamous mailing list discussion between Bram Cohen (who 
> created PreciseCodevilleMerge), and Linus Torvalds back in 2005, 
> discussing merge strategies. It is well recounted here:
> 
> http://wincent.com/a/about/wincent/weblog/archives/2007/07/a_look_back_bra.php

I quite agree with the footnote statement, except on one thing: it would
make it easier to have additional tools to help with such merge
resolutions automatically.

While resolving a rename/delete merge conflict is not a big deal,
resolving function moves from one file to another (possibly new) file is
another story.

Mike
