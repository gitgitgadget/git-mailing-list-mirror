From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: Mirroring mySQL using Git
Date: Tue, 06 May 2008 15:29:25 +0200
Message-ID: <1210080565.7022.11.camel@futex>
References: <4B58A837F454E14AA0453EDBADE96A62B5F2A2@mildred.leeds-art.ac.uk>
	 <20080506132422.GA13125@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ryan Taylor <ryan.taylor@leeds-art.ac.uk>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Wed May 07 08:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtdV2-0000LI-GW
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 08:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbYEGGuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 02:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbYEGGuc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 02:50:32 -0400
Received: from mail16.bluewin.ch ([195.186.19.63]:48161 "EHLO
	mail16.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbYEGGua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 02:50:30 -0400
X-Greylist: delayed 1053 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2008 02:50:30 EDT
Received: from futex.feinheit.ch (213.3.44.95) by mail16.bluewin.ch (Bluewin 7.3.121)
        id 480C934C003B0125; Wed, 7 May 2008 06:32:51 +0000
Received: (nullmailer pid 4742 invoked by uid 1000);
	Tue, 06 May 2008 13:29:25 -0000
In-Reply-To: <20080506132422.GA13125@bit.office.eurotux.com>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81409>

On Tue, 2008-05-06 at 14:24 +0100, Luciano Rocha wrote:
> On Tue, May 06, 2008 at 02:03:01PM +0100, Ryan Taylor wrote:
> > Hi,
> > 
> > I'm wanting to mirror my mysql databases from my live web box to my dev
> > box. The database are updated by a CMS on the live box and I need to be
> > able to transfer these updates to the dev box.
> > 
> > Is this possible with git?
> 
> You'd be better off with asynchronous replication. See
> <http://dev.mysql.com/doc/refman/5.0/en/replication.html>.
> 
> Note that you go the git route, or other file-based solution, you'll
> have to freeze operations to the filesystem where the DBs reside, or
> you'll corrupt the copy.

Alternatively, you can save a SQL dump without extended inserts and with
all comments stripped (especially the embedded timestamp).

Still, replication is a much better alternative (if possible).

-- 
http://spinlock.ch/blog/
