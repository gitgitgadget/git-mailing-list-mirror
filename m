From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 18:50:54 -0700
Message-ID: <42967CFE.7030007@zytor.com>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>	<20050526004411.GA12360@vrfy.org>	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>	<20050526202712.GA6024@vrfy.org>	<7vd5rdbtif.fsf@assigned-by-dhcp.cox.net>	<20050526232953.GA6215@vrfy.org> <7vll618rnw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 03:50:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbTyw-0008Iq-Dh
	for gcvg-git@gmane.org; Fri, 27 May 2005 03:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVE0Bvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 21:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVE0Bvs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 21:51:48 -0400
Received: from terminus.zytor.com ([209.128.68.124]:14058 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261271AbVE0Bvq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 21:51:46 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4R1p5Zv005494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 May 2005 18:51:05 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll618rnw.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> 
> KS> The cgi doesn't need it. Cogito has the spec file and the
> KS> Mekefile with support for it - that was the reason the RPM
> KS> made it on the machines there.
> 
> Ah, just installation convenience.  I see.
> 

Not "just" an installation convenience.  Right now cogito and git-core 
*conflict*.  That's why cogito really needs to be broken out from 
git-core, so git-core can be updated independently.

	-hpa
