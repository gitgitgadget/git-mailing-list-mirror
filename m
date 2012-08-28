From: Matthew Caron <Matt.Caron@redlion.net>
Subject: Re: I think git show is broken
Date: Tue, 28 Aug 2012 13:48:27 -0400
Message-ID: <503D046B.7090606@redlion.net>
References: <503D022B.6070001@redlion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Matthew Caron <Matt.Caron@redlion.net>
X-From: git-owner@vger.kernel.org Tue Aug 28 19:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Ptz-0002j5-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 19:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab2H1Rs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 13:48:29 -0400
Received: from msex2.hq.corp.redlion.net ([205.159.151.218]:24467 "EHLO
	msex2.hq.corp.redlion.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2H1Rs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 13:48:28 -0400
Received: from MSEX1.hq.corp.redlion.net (172.16.2.15) by
 msex2.hq.corp.redlion.net (172.16.2.18) with Microsoft SMTP Server (TLS) id
 14.0.722.0; Tue, 28 Aug 2012 13:48:28 -0400
Received: from BL-MSEX1.hq.corp.redlion.net (10.128.0.5) by
 msex1.hq.corp.redlion.net (172.16.2.15) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 28 Aug 2012 13:48:27 -0400
Received: from [10.128.3.6] (10.128.3.6) by BL-MSEX1.hq.corp.redlion.net
 (10.128.0.5) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Aug 2012
 13:48:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <503D022B.6070001@redlion.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204435>

On 08/28/2012 01:38 PM, Matthew Caron wrote:
> (otherwise, there was a very strange change made to its functionality,
> which the documentation does not reflect)

Never mind.

I was looking in the wrong spot. The issue is not with --pretty=oneline, 
it's with --quiet. In 1.7.0.4, --quiet worked like -s. It no longer does 
in 1.7.9.5. Switching to -s cures the problem.

-- 
Matthew Caron, Software Build Engineer
Sixnet, a Red Lion business | www.sixnet.com
+1 (518) 877-5173 x138 office
