From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to force explicit user info
Date: Wed, 5 Mar 2008 09:45:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803050943070.19665@iabervon.org>
References: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1655516840-1204728325=:19665"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuse-0003Lp-U1
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYCEOp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYCEOp1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:45:27 -0500
Received: from iabervon.org ([66.92.72.58]:33660 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbYCEOp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:45:26 -0500
Received: (qmail 22314 invoked by uid 1000); 5 Mar 2008 14:45:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 14:45:25 -0000
In-Reply-To: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76222>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1655516840-1204728325=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 5 Mar 2008, Santi Béjar wrote:

> Hi  *,
> 
> 
>   how can I forbid the gecos info and always force git to ask for an
> explicit user.name and user.email?
> 
>   I use a different email for personal projects and for work projects,
> using the same machine. So I set user.email locally in each
> repository. But when I forget setting this I get
> userid@hostname.(none) as the email. Is there a way to just die and
> ask for this info (maybe user.AlwaysExplicit or something like that)?

It doesn't work now, but I think a global:

[user]
	name

Could usefully be made to disable the default.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1655516840-1204728325=:19665--
