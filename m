From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix "git checkout -b foo ':/substring'"
Date: Sat, 2 Feb 2008 03:32:32 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802020331210.13593@iabervon.org>
References: <7v1w7w6oq7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 09:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLDoH-0006S8-Hs
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 09:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYBBIcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 03:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYBBIcl
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 03:32:41 -0500
Received: from iabervon.org ([66.92.72.58]:60680 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbYBBIck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 03:32:40 -0500
Received: (qmail 25481 invoked by uid 1000); 2 Feb 2008 08:32:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Feb 2008 08:32:32 -0000
In-Reply-To: <7v1w7w6oq7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72231>

On Fri, 1 Feb 2008, Junio C Hamano wrote:

> Because ':/substring' extended SHA1 expression cannot take
> postfix modifiers such as ^{tree} and ^{commit}, we would need
> to do it in multiple steps.  With the patch, you can start a new
> branch from a randomly-picked commit whose message has the named
> string in it.

Could we have a test for this? I'm not exactly sure how to use it, and I 
want to make sure my C version works.

	-Daniel
*This .sig left intentionally blank*
