From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 16/18] blob.c: remove unused function
Date: Tue, 12 Jan 2010 12:37:18 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001121128410.14365@iabervon.org>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com> <1263282781-25596-17-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 18:37:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUkgJ-0005Q1-NK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 18:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab0ALRhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 12:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118Ab0ALRhU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 12:37:20 -0500
Received: from iabervon.org ([66.92.72.58]:34815 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab0ALRhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 12:37:19 -0500
Received: (qmail 25712 invoked by uid 1000); 12 Jan 2010 17:37:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2010 17:37:18 -0000
In-Reply-To: <1263282781-25596-17-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136741>

On Mon, 11 Jan 2010, Junio C Hamano wrote:

> parse_blob() is not used anywhere since a510bfa (Mark blobs as parsed when
> they're actually parsed, 2005-04-28).

Perhaps it should be replaced with a comment that blobs are never parsed, 
because they don't need to be? We don't need the actual function, but I 
think it's worth having a note where the function would be.

	-Daniel
*This .sig left intentionally blank*
