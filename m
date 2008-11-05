From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Repo corrupted somehow?
Date: Wed, 5 Nov 2008 00:56:06 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811050043030.19665@iabervon.org>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>  <alpine.LNX.1.00.0811042241450.19665@iabervon.org> <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 06:57:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxbOR-0007eS-By
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 06:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYKEF4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 00:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYKEF4J
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 00:56:09 -0500
Received: from iabervon.org ([66.92.72.58]:41465 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbYKEF4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 00:56:08 -0500
Received: (qmail 28201 invoked by uid 1000); 5 Nov 2008 05:56:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2008 05:56:06 -0000
In-Reply-To: <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100145>

On Tue, 4 Nov 2008, Andrew Arnott wrote:

> It was the CRLF conversion.  When I played around with
> git config --global core.autocrlf true/false
> I got the problem to eventually go away.
> 
> Thanks for all your responses.

It's still worth debugging further, because git should know that it wrote 
the files differently and not see that as changes. It's not too helpful to 
have autocrlf if it causes this problem.

Are you using something (like .gitattributes) to mark files as text or as 
non-text? Is this under Cygwin? It might be fixed in a newer version, 
also.

	-Daniel
*This .sig left intentionally blank*
