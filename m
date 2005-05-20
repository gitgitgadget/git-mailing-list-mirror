From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 15:13:55 -0700
Message-ID: <428E6123.8050907@zytor.com>
References: <20050511012626.GL26384@pasky.ji.cz>	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>	 <1116611932.12975.22.camel@dhcp-188>	 <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>	 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>	 <1116615600.12975.33.camel@dhcp-188>	 <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>	 <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>	 <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 00:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZFlQ-0006CX-IT
	for gcvg-git@gmane.org; Sat, 21 May 2005 00:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVETWPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 18:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVETWOb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 18:14:31 -0400
Received: from terminus.zytor.com ([209.128.68.124]:51631 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261441AbVETWOR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 18:14:17 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4KME0vE016759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 May 2005 15:14:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1116626652.12975.118.camel@dhcp-188>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers wrote:
> 
> And the klibc-repo was created with a patched git-commit to fake the
> commit date with the author date. :)
> 

In fact, I kind of wish we'd also made committer == author.

Since this whole thing is an import from another revision control 
system, one really wants that.  It's one of those very rare situations 
in which fudging the commit date is not only fully legitimate, but darn 
near required.

	-hpa

