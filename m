From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Mon, 22 May 2006 16:03:06 -0700
Message-ID: <4472432A.8010002@zytor.com>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE> <44722A8F.9020609@zytor.com> <20060522220206.GA10488@pasky.or.cz> <447239F0.9030705@zytor.com> <20060522225054.GL11941@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJQk-0000eJ-Ku
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWEVXDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWEVXDP
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:03:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49581 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750859AbWEVXDP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 19:03:15 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k4MN38Z2006478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 May 2006 16:03:08 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060522225054.GL11941@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20544>

Petr Baudis wrote:
> 
> Even rsync and HTTP cg-clones? git:// and git+ssh:// fetching follows an
> almost entirely different code patch and it's much more efficient since
> I just accumulate the tag object ids I want to check and then pour them
> to git-fetch-pack - I cannot do that with git-(local|http)-fetch. :-(
> 

No, but git-fetch-pack could operate over a local pipe just fine (after all, all it does 
is ssh an "git-send-pack" command to the other side.)

	-hpa
