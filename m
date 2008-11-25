From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 14:08:32 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811251402360.19665@iabervon.org>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com> <alpine.LNX.1.00.0811251327480.19665@iabervon.org> <200811252001.37259.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Nov 25 20:09:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L53ID-0006qY-VU
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 20:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYKYTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYKYTIe
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 14:08:34 -0500
Received: from iabervon.org ([66.92.72.58]:50681 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbYKYTId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 14:08:33 -0500
Received: (qmail 16366 invoked by uid 1000); 25 Nov 2008 19:08:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Nov 2008 19:08:32 -0000
In-Reply-To: <200811252001.37259.thomas@koch.ro>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101676>

On Tue, 25 Nov 2008, Thomas Koch wrote:

> Do you now of a way to show public repos with gitweb to the public and
> private repos to the staff with the same gitweb installation?

I don't really know much about gitweb, but I'd expect that you can have 
the same physical machine, the same gitweb executable, the same 
apache, different virtual hosts, and different configurations for each 
virtual host. Without having different URLs in some way, there's no way 
for the system to cause web browsers of staff members to authenticate 
themselves in order to reveal the private repos.

	-Daniel
*This .sig left intentionally blank*
