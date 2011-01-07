From: Stephen Bash <bash@genarts.com>
Subject: Re: clone breaks replace
Date: Fri, 7 Jan 2011 16:15:05 -0500 (EST)
Message-ID: <1351312.105443.1294434905621.JavaMail.root@mail.hq.genarts.com>
References: <20110107205103.GC4629@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Phillip Susi <psusi@cfl.rr.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJet-0006UI-7a
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab1AGVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:15:20 -0500
Received: from hq.genarts.com ([173.9.65.1]:2191 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753582Ab1AGVPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:15:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id DED7B1E2604D;
	Fri,  7 Jan 2011 16:15:11 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WuRnOsHQuqId; Fri,  7 Jan 2011 16:15:05 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id CBC011E2604C;
	Fri,  7 Jan 2011 16:15:05 -0500 (EST)
In-Reply-To: <20110107205103.GC4629@burratino>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164764>

----- Original Message -----
> From: "Jonathan Nieder" <jrnieder@gmail.com>
> To: "Phillip Susi" <psusi@cfl.rr.com>
> Cc: git@vger.kernel.org, "Christian Couder" <chriscool@tuxfamily.org>
> Sent: Friday, January 7, 2011 3:51:03 PM
> Subject: Re: clone breaks replace
> Phillip Susi wrote:
> 
> > Isn't the whole purpose of using replace to avoid having to use
> > filter-branch, which throws out all of the existing commit records,
> > and creates an entirely new commit chain that is slightly modified?
> 
> No. What documentation suggested that? Maybe it can be fixed.

I'll chime in here as another person who read the ProGit blog entry on git-replace [1] and came to the same conclusion Phillip (and I'm guessing others) did.  OTOH when I attempted to read the actual git-replace manpage, I got completely lost, so I retained my (apparently incorrect) understanding from ProGit.

Thanks,
Stephen

[1] http://progit.org/2010/03/17/replace.html
