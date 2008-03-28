From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Git vs svn. Is ... possible ?
Date: Fri, 28 Mar 2008 10:31:14 -0400
Message-ID: <20080328143114.GL7202@mit.edu>
References: <20080328132438.GA32646@blackspire> <47ECF459.2040500@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafa? Mu?y?o <galtgendo@o2.pl>, git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFcw-0006gX-DQ
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYC1Obe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbYC1Obe
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:31:34 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:46585 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089AbYC1Obd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 10:31:33 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2SEVGoJ008891;
	Fri, 28 Mar 2008 10:31:16 -0400 (EDT)
Received: from closure.thunk.org (c-67-184-233-39.hsd1.il.comcast.net [67.184.233.39])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2SEVEIu012331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Mar 2008 10:31:15 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JfFbu-0000HN-7u; Fri, 28 Mar 2008 10:31:14 -0400
Content-Disposition: inline
In-Reply-To: <47ECF459.2040500@users.sourceforge.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78414>

On Fri, Mar 28, 2008 at 02:36:25PM +0100, Adam Piatyszek wrote:
>
> The question makes no sense to me. Git by design is a distributed SCM tool, 
> so there is no such thing like "remote revisions". You can have tracking 
> branches (clones) of some remote repositories, but all the commits on such 
> branches are also stored locally. So you have full access to them, even 
> without a permanent connection to such remote repositories.
>

It would certainly be possible to *implement* such a thing, but first
question would be, "why would you want to".  One of the things that
makes git so nice is that repositories don't take that much space, and
if you have a local repository (or no network access at all) it's much
faster to consult the local repository at all.

In fact, with svn, I normally consider it a bug that you *have* to
consult the remote repository to do a diff between two arbitrary
revisions.

						- Ted
