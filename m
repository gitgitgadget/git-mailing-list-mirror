From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Date-based limits
Date: Mon, 31 Oct 2005 19:43:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311940120.25300@iabervon.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org> <Pine.LNX.4.64.0510311820060.25300@iabervon.org>
 <7v1x21b3v6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 01:44:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWkGB-0000d6-Cg
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKAAoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKAAoR
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:44:17 -0500
Received: from iabervon.org ([66.92.72.58]:46865 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932340AbVKAAoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 19:44:16 -0500
Received: (qmail 23936 invoked by uid 1000); 31 Oct 2005 19:43:55 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 19:43:55 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x21b3v6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10912>

On Mon, 31 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > At some point, we might want to have a series of refs tracking changes to 
> > the user's heads over time.
> 
> Hmph.  If you really want something like that, I think you could
> add a hook support for git-fetch to implement this as
> automatically created lightweight tags...

Probably; I think this should also trigger on commits and such, and it 
would need a way for rev-list (or rev-parse?) to find the last one before 
a user-specified date, so that you don't have to figure out when the last 
change was that contributed to you seeing a particular tree on a given 
date.

	-Daniel
*This .sig left intentionally blank*
