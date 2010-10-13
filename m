From: Stephen Bash <bash@genarts.com>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 11:32:25 -0400 (EDT)
Message-ID: <3305459.485811.1286983945370.JavaMail.root@mail.hq.genarts.com>
References: <4CB5CEA3.8020702@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 17:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P63Jm-0004rq-SO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 17:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab0JMPcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 11:32:33 -0400
Received: from hq.genarts.com ([173.9.65.1]:5590 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495Ab0JMPcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 11:32:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6414F1E2692F;
	Wed, 13 Oct 2010 11:32:31 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MPIgkGnKrmj3; Wed, 13 Oct 2010 11:32:25 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 772A51E2692D;
	Wed, 13 Oct 2010 11:32:25 -0400 (EDT)
In-Reply-To: <4CB5CEA3.8020702@xiplink.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158939>

> So I'm wondering if it makes sense to properly support hidden
> directories in
> refs/, and what it would take to do so. (I image, for example, that
> things
> would behave quite differently on Windows...)
> 
> Thoughts?

We currently use refs/hidden/heads and refs/hidden/tags for hidden refs.  It does require calling 'gitk --branches --tags' rather than 'gitk --all', but otherwise I like the behavior (git branch only lists refs/heads, git tag only lists ref/tags).  And they never get cloned by default (they can still be fetched when needed).

Stephen
