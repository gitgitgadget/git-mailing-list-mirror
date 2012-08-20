From: Stephen Bash <bash@genarts.com>
Subject: Re: "Temporary merge branch 2" Conflicts
Date: Mon, 20 Aug 2012 09:21:41 -0400 (EDT)
Message-ID: <1666100271.191032.1345468901838.JavaMail.root@genarts.com>
References: <7vfw7lteaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RvY-0000VJ-8P
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 15:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab2HTNVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 09:21:51 -0400
Received: from hq.genarts.com ([173.9.65.1]:56758 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751845Ab2HTNVu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:21:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 061FBBE109F;
	Mon, 20 Aug 2012 09:21:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7X90AVjd+soO; Mon, 20 Aug 2012 09:21:41 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id E2305BE1118;
	Mon, 20 Aug 2012 09:21:41 -0400 (EDT)
In-Reply-To: <7vfw7lteaw.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203839>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Friday, August 17, 2012 5:10:47 PM
> Subject: Re: "Temporary merge branch 2" Conflicts
> 
> Stephen Bash <bash@genarts.com> writes:
> 
> > What is the recommended method for resolving this sort of merge?
> > kdiff3 obviously doesn't understand the situation.  Do the working
> > tree files contain all the conflicts?  If so, I can just go
> > through by hand and resolve the conflicts the old fashion way.
> 
> Yes.  External tools like kdiff3 may not understand the conflict in
> the working tree, but the files in the working tree should have
> resolved the naturally resolvable bits and only left the conflicted
> bits conflicted.  Just resolve manually if you can, and then look at
> what both branches wanted to do to the file ("git log -p --merge
> $that_path" before you "git add" as the final sanity check would
> work nicely) to make sure your resolution makes sense.

Thanks for the clarification Junio.  I'll take another swipe at it this week now that I know what I'm doing!

Stephen
