From: Bill Lear <rael@zopyra.com>
Subject: Re: Problem with git push over <hostname>:/path protocol (ssh)
Date: Wed, 24 Jan 2007 14:35:31 -0600
Message-ID: <17847.49939.964820.170771@lisa.zopyra.com>
References: <17847.47131.694158.247941@lisa.zopyra.com>
	<Pine.LNX.4.64.0701241453410.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9oqJ-0003fq-Sg
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbXAXUfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXAXUfg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:35:36 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61490 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXAXUfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:35:36 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0OKZYX23913;
	Wed, 24 Jan 2007 14:35:34 -0600
In-Reply-To: <Pine.LNX.4.64.0701241453410.20138@iabervon.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37673>

On Wednesday, January 24, 2007 at 15:04:54 (-0500) Daniel Barkalow writes:
>...
>Git gets unhappy if you push into a branch that's checked out. It doesn't 
>update the index or working directory, so the state after the push looks 
>like the user reverted the patch in the working directory and updated the 
>index.
>
>It should probably give an error message and stop the push; dealing with a 
>checked out version conceptually requires a merge, which push doesn't do. 
>Most likely, you want a clone of the upstream repository, and a 
>post-update hook in the upstream repository that goes into the clone and 
>pulls the changes. (And possibly does more stuff after that)

Wow, this is a pain.

We actually would prefer that our public (collaborative) repositories
be bare, but we could not find a way to pull into them without
getting all the files checked out into the working tree.

Is there a way to do a pull and leave a repo bare, perchance?


Bill
