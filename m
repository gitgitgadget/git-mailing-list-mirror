From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 03 Jun 2005 07:34:13 +0200
Message-ID: <429FEBD5.5040306@lsrfire.ath.cx>
References: <20050602185046.GA3717@lsrfire.ath.cx> <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 07:31:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De4mG-0000ZM-5W
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 07:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFCFeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 01:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFCFeX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 01:34:23 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:30089 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261285AbVFCFeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 01:34:18 -0400
Received: from [10.0.1.3] (p508E573B.dip.t-dialin.net [80.142.87.59])
	by neapel230.server4you.de (Postfix) with ESMTP id A38A4138;
	Fri,  3 Jun 2005 07:34:16 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 
> On Thu, 2 Jun 2005, Rene Scharfe wrote:
> 
>>git-tar-tree: add a simple test case.
> 
> 
> I get:
> 
> 	* FAIL 6: extract tar archive (cd b && tar xf -) <b.tar
> 	* FAIL 7: validate filenames (cd b/a && find .) | sort >b.lst &&
> 	* FAIL 8: validate file contents diff -r a b/a
> 	* FAIL 11: validate filenames with prefix (cd c/prefix/a && find .) | sort >c.lst &&
> 	* FAIL 12: validate file contents with prefix diff -r a c/prefix/a

What version of tar do you use?  Also, can you please send me the output
the following?

   cd t; sh t5000-tar-tree.sh; cd trash; tar tvf b.tar

Thanks,
Rene
