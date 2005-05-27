From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 21:01:28 -0700
Message-ID: <42969B98.7070701@zytor.com>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>	<20050526004411.GA12360@vrfy.org>	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>	<20050526202712.GA6024@vrfy.org>	<7vd5rdbtif.fsf@assigned-by-dhcp.cox.net>	<20050526232953.GA6215@vrfy.org>	<7vll618rnw.fsf@assigned-by-dhcp.cox.net> <42967CFE.7030007@zytor.com> <7vk6ll2vde.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 06:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbW1a-0007If-5p
	for gcvg-git@gmane.org; Fri, 27 May 2005 06:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVE0EC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 00:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVE0EC1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 00:02:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:23007 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261427AbVE0ECH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 00:02:07 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4R41Sfl007502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 May 2005 21:01:30 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ll2vde.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> 
> HPA> Not "just" an installation convenience.  Right now cogito and git-core
> HPA> *conflict*.  That's why cogito really needs to be broken out from
> HPA> git-core, so git-core can be updated independently.
> 
> What I learned from this thread are these:
> 
>  (1) CGI does not need Cogito but just needs core GIT.
>  (2) Nobody said he uses Cogito on kernel.org machines.
>  (3) But Cogito is installed nevertheless.
>  (4) Installation of Cogito is done via RPM "with Makefiles and
>      spec files" and both Cogito and core GIT comes bundled in.
>  (5) I gather that there is no core GIT only RPM (nobody said
>      this explicitly in this thread, though, so I may be
>      mistaken about this point).
> 
> And that was where my comment about "just an installation
> convenience" came from.
> 
> If somebody said Cogito _is_ used on kernel.org machines, then I
> would not have said "just" nor "convenience".  That would mean
> there is a real need to have Cogito and having just core GIT
> would not be enough.

I, for one, use Cogito on the kernel.org machines.

	-hpa
