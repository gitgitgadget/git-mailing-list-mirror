From: =?iso-8859-1?Q?=22Martin_Kr=FCger=22?= <martin.krueger@gmx.com>
Subject: Re: Merging (only) subdirectories
Date: Wed, 01 Dec 2010 12:47:59 +0100
Message-ID: <20101201114759.136280@gmx.net>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 12:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNlAQ-0006oY-JI
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 12:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab0LALsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 06:48:05 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:60402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751493Ab0LALsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 06:48:04 -0500
Received: (qmail 28922 invoked by uid 0); 1 Dec 2010 11:48:01 -0000
Received: from 213.39.246.106 by www041.gmx.net with HTTP;
 Wed, 01 Dec 2010 12:47:59 +0100 (CET)
In-Reply-To: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
X-Authenticated: #34047341
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX19mHtJx2s1mtov1ySn3fnBG2ZWoVROHZgMH+GQx5b
 +3uXRxNudXtnQDviDbpmkQAWvjCJQhy9hQAQ== 
X-GMX-UID: 3gfQZBWSLi50AkWhbWlp1CNrZml1ZNhM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162500>


> 
> The problem comes when Client A wants to purchase Theme B. We can't
> just merge the theme branch because all the rest of the project
> contains (potentially) a different version of Moodle. So we have to do
> lots of messing around to get the theme branch in and/or loose the
> theme commit history in the process.
> 
I would say you are not working best practice with git. The idea of commit is a atomic  change of the whole project.  It seems like you mixed completely unrelated changes in a commit.

You can try as a resolution:
git rebase master  (on a temporary-branch)
git format-patch master

Strip the patches with filterdiff

Apply the stripped patches to another temporary-brach.
Merge to the target-Branch.

Best regards
     martin
