From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Using email between 2 developers to keep git repositories in
	sync
Date: Tue, 22 Jan 2008 17:59:02 -0500
Message-ID: <20080122225902.GE1659@mit.edu>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com> <alpine.LNX.1.00.0801221713120.13593@iabervon.org> <2D91636D-197A-41C8-8BB3-D5002135BF99@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Annard Brouwer <ab_lists@mac.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHS5y-0001EJ-Jy
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbYAVW7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbYAVW7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:59:24 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53684 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758113AbYAVW7X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 17:59:23 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0MMxHiI002932;
	Tue, 22 Jan 2008 17:59:17 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0MMx7JO027453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 17:59:16 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHS58-0004sL-Da; Tue, 22 Jan 2008 17:59:02 -0500
Content-Disposition: inline
In-Reply-To: <2D91636D-197A-41C8-8BB3-D5002135BF99@mac.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71477>

On Tue, Jan 22, 2008 at 11:52:40PM +0100, Annard Brouwer wrote:
> Thank you all for your suggestions! The problem is that each of us having a 
> local server accessible to the other is not possible. Therefore I will 
> follow the path of sending patches by email and on releases we can 
> synchronise using bundles. I think that's the best fit for our model of 
> developing code semi-independently.

Is your project an open source one, or one where you don't mind the
source code being made public?  If so, another easier solution would
be to use a git hosting service, such as what is available at
http://repo.or.cz.

I'd also suggest synchronizing with bundles much more frequently than
at release points.  The problem with sending patches back and forth is
it's very easy to make a mistake, and also, as far as git is
concerned, each patch is a separate changeset applied in two places.
So it makes merging more challenging for git.  It can probably handle
it, but makes life harder for everyone concerned.  So if you can use a
site like repo.or.cz, I'd highly recommend it.

						- Ted
