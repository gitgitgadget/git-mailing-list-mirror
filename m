From: Stephen Bash <bash@genarts.com>
Subject: Re: Git SVN non-standard branch/tag/trunk layout
Date: Mon, 13 Dec 2010 16:23:02 -0500 (EST)
Message-ID: <19945570.186298.1292275382811.JavaMail.root@mail.hq.genarts.com>
References: <002301cb9b09$e4eb2de0$aec189a0$@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Albert Krawczyk <pro-logic@optusnet.com.au>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSFrq-0003Zw-I4
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab0LMVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 16:23:12 -0500
Received: from hq.genarts.com ([173.9.65.1]:37566 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757026Ab0LMVXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 16:23:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id F132D1E2631D;
	Mon, 13 Dec 2010 16:23:08 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjurVlobNpx3; Mon, 13 Dec 2010 16:23:02 -0500 (EST)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id E2D571E26314;
	Mon, 13 Dec 2010 16:23:02 -0500 (EST)
In-Reply-To: <002301cb9b09$e4eb2de0$aec189a0$@optusnet.com.au>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163595>

----- Original Message -----
> From: "Albert Krawczyk" <pro-logic@optusnet.com.au>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: git@vger.kernel.org
> Sent: Monday, December 13, 2010 4:08:28 PM
> Subject: RE: Git SVN non-standard branch/tag/trunk layout
>
> >Project 2 is an interesting one because it looks like the trunk is at
> >the same level as branches/tags. If that's the case, the 'branches'
> >line above will work (it will treat >the trunk like any other branch
> >-- a very Git-like approach). Also note that those projects that
> >didn't have a 'trunk' directory in SVN I added a 'trunk' on the Git
> >side to keep things consistent -- this is completely optional.
> >
> >Once you get comfortable with the rules governing the config lines,
> >you can pretty much untangle any SVN layout.
> 
> Thanks a lot! I thought this is what I had to do, and had through
> trial and (a lot of) error got to be very close. As far as I can see
> the only 'downside' of this approach is that you can't have the 'root'
> of the SVN repo checked out, you can only have the root of each
> project checked out, as they are all on their own ref.

I hadn't thought about it until now, but you could probably specify fetch=/:refs/remotes/svnroot to have a ref that is the root of the SVN repository...  Might be worth a shot...

Stephen
