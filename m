From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 11:11:26 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281111050.19665@iabervon.org>
References: <87wsop188j.fsf@wine.dyndns.org> <alpine.LNX.1.00.0802281058190.19665@iabervon.org> <87hcft12ug.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlMw-0001qx-47
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 17:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbYB1QLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYB1QLe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 11:11:34 -0500
Received: from iabervon.org ([66.92.72.58]:58952 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbYB1QLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 11:11:34 -0500
Received: (qmail 4155 invoked by uid 1000); 28 Feb 2008 16:11:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 16:11:26 -0000
In-Reply-To: <87hcft12ug.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75421>

On Thu, 28 Feb 2008, Alexandre Julliard wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > We need to rewrite the index file when we check out files, even if we
> > haven't modified the blob info by reading from another tree, so that
> > we get the stat cache to include the fact that we just modified the
> > file so it doesn't need to be refreshed.
> 
> That fixes the problem for me. Thanks!

You're welcome, and good catch.

	-Daniel
*This .sig left intentionally blank*
