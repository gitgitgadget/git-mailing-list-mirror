From: Stephen Bash <bash@genarts.com>
Subject: Re: Overlong lines with git-merge --log
Date: Fri, 2 Nov 2012 09:49:33 -0400 (EDT)
Message-ID: <982632649.556351.1351864173516.JavaMail.root@genarts.com>
References: <5093C98D.90807@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Tim Janik <timj@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHdB-0003ox-N7
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854Ab2KBNtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:49:41 -0400
Received: from hq.genarts.com ([173.9.65.1]:43420 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757847Ab2KBNtk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:49:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 38897BE1ADD;
	Fri,  2 Nov 2012 09:49:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBgYIjPt7nNY; Fri,  2 Nov 2012 09:49:33 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 81EC2BE1ABC;
	Fri,  2 Nov 2012 09:49:33 -0400 (EDT)
In-Reply-To: <5093C98D.90807@gnu.org>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC22 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208932>

----- Original Message -----
> From: "Tim Janik" <timj@gnu.org>
> Sent: Friday, November 2, 2012 9:24:29 AM
> Subject: Re: Overlong lines with git-merge --log
> 
> On 02.11.2012 11:05, Jeff King wrote:
> 
> > Taking just the first line of those often cuts off the useful part.
> > It was deemed less bad to show the whole message as a subject rather
> > than cut it off arbitrarily.
> 
> Thanks a lot for the explanation, I'm using git directly here, but the
> two cases I had indeed lacked this newline.

FWIW we use merge --log quite extensively here at the office, and I've developed a habit to skim the extremely long lines and attempt to cut them intelligently (something I don't trust the computer to do for me).  Sometimes that means taking the second or third sentence if it's a better summary, sometimes it's just abbreviating the first.  Now that merge automatically spawns an editor, this is quite convenient (though it does take a bit longer).

Thanks,
Stephen
