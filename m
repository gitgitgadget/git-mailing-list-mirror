From: Trekie <trekie@sinister.cz>
Subject: Re: [RFC] adding support for md5
Date: Fri, 18 Aug 2006 13:27:18 +0200
Message-ID: <44E5A416.9040709@sinister.cz>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <44E59BF6.2070909@sinister.cz> <Pine.LNX.4.63.0608181255060.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 13:24:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE2Rs-00058B-Qb
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 13:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWHRLXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 07:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWHRLXd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 07:23:33 -0400
Received: from smtp.ispservices.cz ([193.86.244.30]:48321 "EHLO inetgw.ido.cz")
	by vger.kernel.org with ESMTP id S932387AbWHRLXd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 07:23:33 -0400
Received: from [192.168.171.2] ([192.168.171.2])
	by inetgw.ido.cz (8.13.7/8.13.7) with ESMTP id k7IBNSmL003864;
	Fri, 18 Aug 2006 13:23:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060814 SeaMonkey/1.0.3
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608181255060.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25651>

Johannes Schindelin wrote:
> SHA1 has been broken (collisions have been found):
> 
> http://www.schneier.com/blog/archives/2005/02/sha1_broken.html

I don't think you're right. That blog just says, that Wang can find

"collisions in the the full SHA-1 in 2**69 hash operations, much less
than the brute-force attack of 2**80 operations based on the hash length."

That doesn't mean any collision has been found. In academic
cryptography, any attack that has less computational complexity than the
expected time needed for brute force is considered a break.

In a document (http://www.rsasecurity.com/rsalabs/node.asp?id=2927) that
has been released 6 months after that blog post is said a collision can
be found in 2^63 operations.

Well, if someone use the fastest computer today
(http://www.top500.org/system/7747) to get a collision it would take a
day to found one.

The point is why use MD5 if anyone can compute a collision?

David Brodsky
