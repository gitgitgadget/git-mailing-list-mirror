From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Problem merging
Date: Tue, 22 Nov 2005 19:41:40 -0800 (PST)
Message-ID: <20051123034140.29993.qmail@web31801.mail.mud.yahoo.com>
References: <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Nov 23 04:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EelVx-0001H7-Vy
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 04:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVKWDlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 22:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVKWDlm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 22:41:42 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:44132 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932498AbVKWDlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 22:41:42 -0500
Received: (qmail 29995 invoked by uid 60001); 23 Nov 2005 03:41:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Qntdo7cddlLoVYl/Imuv+/5F4r7cl7rU5BSyRidxn4Zk1SGyBaIG1wFRRXbkxxlQ56H9P0oeozOonn5iHWv1014HNocdy4lUHfAf7+asvba5FvqumMPa7agHgYKUju3fm84WkxxRHxhWIUg/k7hP7FAq8yISDxEMs+ke47oaSxA=  ;
Received: from [70.144.190.34] by web31801.mail.mud.yahoo.com via HTTP; Tue, 22 Nov 2005 19:41:40 PST
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12600>

--- Junio C Hamano <junkio@cox.net> wrote:

> What does "git diff" and "git diff HEAD" tell you after the
> merge procedure leaves conflict in the working tree (branchB
> directory, I mean)?

Apparently include/asm-um/ldt.h has been renamed
and this was giving problems.

I had to manually git-update-index --force-remove that
file and then git resolve worked ok.

   Luben
