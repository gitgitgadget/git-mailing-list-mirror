From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 5 Mar 2008 15:21:05 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803051516300.19665@iabervon.org>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1283575668-1204748465=:19665"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX07X-0008H2-2r
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbYCEUVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 15:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYCEUVH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:21:07 -0500
Received: from iabervon.org ([66.92.72.58]:38605 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688AbYCEUVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 15:21:06 -0500
Received: (qmail 13159 invoked by uid 1000); 5 Mar 2008 20:21:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 20:21:05 -0000
In-Reply-To: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76258>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1283575668-1204748465=:19665
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Mar 2008, Santi Béjar wrote:

> Useful when you want a different email/name for each repository

I still think it would be more intuitive if you made it so that setting 
user.* to nothing was not an error, suppressed picking values up from the 
system, and led (if not overridden again) to the message telling you how 
to set them. Is there some reason you decided not to have that be how the 
user triggers this behavior?

	-Daniel
*This .sig left intentionally blank*
--1547844168-1283575668-1204748465=:19665--
