From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Internal, corporate, shared hosting solutions
Date: Fri, 26 Sep 2008 08:39:03 -0700
Message-ID: <20080926153903.GC17584@spearce.org>
References: <8B29890D-C03B-4ECE-9BEF-0A8E8EF7233E@netspot.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom Lanyon <tom@netspot.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:40:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFQX-0006H0-6v
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYIZPjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYIZPjG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:39:06 -0400
Received: from george.spearce.org ([209.20.77.23]:54278 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYIZPjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:39:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A6F3B3835F; Fri, 26 Sep 2008 15:39:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8B29890D-C03B-4ECE-9BEF-0A8E8EF7233E@netspot.com.au>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96871>

Tom Lanyon <tom@netspot.com.au> wrote:
> We have some pretty basic requirements:
> 	- authentication and authorisation; some repos are only readable/ 
> writable by specific people
> 	- accessible; many dev servers are on private subnets, ideally we need 
> to be able to proxy git access
> 	- not too much messing with unix user accounts on the central git host 
> (because they're tied to LDAP, for example)

Use git over ssh, but use gitosis on the server side:

  http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

Have each developer supply their own SSH public key, install it
into the gitosis database, and they can only read/write repos
they have access to in the admin database.

Secure, fast, yea, you can actually pick two out of two.  :)

-- 
Shawn.
