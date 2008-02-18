From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] Export some email and pretty-printing functions
Date: Mon, 18 Feb 2008 12:00:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181156540.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335460.5816@iabervon.org> <7vablzudvg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR9Mi-0007Kd-1h
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYBRRA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYBRRA0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:00:26 -0500
Received: from iabervon.org ([66.92.72.58]:47897 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbYBRRAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:00:25 -0500
Received: (qmail 21652 invoked by uid 1000); 18 Feb 2008 17:00:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 17:00:16 -0000
In-Reply-To: <7vablzudvg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74314>

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > +void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
> > +		   const char *line, enum date_mode dmode,
> > +		   const char *encoding);
> 
> Exactly the same comment about "the function name being too
> generic" from the last round still applies.

pp_user_info() maybe? That also matches the other similar functions.

	-Daniel
*This .sig left intentionally blank*
