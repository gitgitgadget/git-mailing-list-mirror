From: Mike Hommey <mh@glandium.org>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 20:25:10 +0200
Organization: glandium.org
Message-ID: <20080702182510.GC29559@glandium.org>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE726-0001gc-FE
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYGBSZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYGBSZX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:25:23 -0400
Received: from vuizook.err.no ([194.24.252.247]:60779 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbYGBSZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:25:22 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KE70v-0001IJ-HT; Wed, 02 Jul 2008 20:25:15 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KE70w-000804-D8; Wed, 02 Jul 2008 20:25:10 +0200
Content-Disposition: inline
In-Reply-To: <20080702174255.GB16235@cuci.nl>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87172>

On Wed, Jul 02, 2008 at 07:42:55PM +0200, Stephen R. van den Berg wrote:
> Michael J Gruber wrote:
> >Maybe the upcoming git-sequencer could be the appropriate place? It 
> >tries to achieve just that: edit history by specifying a list of 
> >commands. The currently planned set of commands would need to be 
> 
> That's the problem.  Like git filter-branch, git sequencer needs you to
> parameterise the changes, which, in my case, is hardly possible, since
> the changes are randomlike.
> Also, having to run the sequencer to dig 20000 commits into the past,
> then change something, then come back up and rewrite all following
> history and relations (parents/tags/merges) will take a sizeable amount
> of time.  I need something that can be changed at will, then viewed with
> gitk a second later.
> 
> These edits are numerous and spread over many months, so the typical 
> history fixup-sessions involve periods where you make 30 random
> historicaledits per hour (which need to be viewed and checked every time
> immediately after making the change).  And say once every 4 months, you
> run it through git filter-branch to cast everything into stone.  A
> typical git filter-branch run takes 15 minutes on a repository this
> size.

I think the point was more about making a tool to do exactly what you
want, based on the new git sequencer. Note that git filter-branch could
also be rewritten to use the sequencer.

Mike
