From: Stephen Bash <bash@genarts.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on
 Windows
Date: Tue, 23 Nov 2010 15:25:36 -0500 (EST)
Message-ID: <32148197.47150.1290543936407.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:25:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzQz-0005UX-46
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab0KWUZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:25:44 -0500
Received: from hq.genarts.com ([173.9.65.1]:20851 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751972Ab0KWUZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:25:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 733ED1E2633A;
	Tue, 23 Nov 2010 15:25:42 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dSkdDJlww+9; Tue, 23 Nov 2010 15:25:36 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 7BEB71E262EC;
	Tue, 23 Nov 2010 15:25:36 -0500 (EST)
In-Reply-To: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162023>

----- Original Message -----
> From: "Dun Peal" <dunpealer@gmail.com>
> To: "Wilbert van Dolleweerd" <wilbert@arentheym.com>
> Cc: "Git ML" <git@vger.kernel.org>
> Sent: Tuesday, November 23, 2010 2:59:17 PM
> Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
>
> On Tue, Nov 23, 2010 at 7:12 PM, Wilbert van Dolleweerd
> <wilbert@arentheym.com> wrote:
> > How big is your repository? We're using some fairly big repositories
> > over here but I haven't seen this behavior with the latest version
> > of msysgit.
> 
> The working copy totals about 4GB. The .git directory, tightly packed,
> is 1GB.

We're working with about a 1.5GB repository, and while I haven't seen an specific msysgit slow downs, I did run into build issues due to Windows anti-virus programs (on-access scans, new files scans, etc).  I had to add my development directory to the anti-virus exception list to speed things back up.

That being said, I do most of my development on Mac and Linux, and msysgit is noticeably slower across the board for me...

Thanks,
Stephen
