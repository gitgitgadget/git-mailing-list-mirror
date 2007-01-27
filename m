From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Sat, 27 Jan 2007 14:07:35 -0800
Message-ID: <45BBCD27.5050408@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net> <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net> <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAvi8-0001P3-ND
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXA0WHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbXA0WHq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:07:46 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33899 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbXA0WHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:07:45 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0RM7ZcN015673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Jan 2007 14:07:36 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2494/Sat Jan 27 11:00:28 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38003>

Johannes Schindelin wrote:
> No. I would never say that you have to run for-each-ref for each ref. 
> That's plain stupid.

I went back and looked at the thread, and I had indeed misread the 
original message, which was from Jakub, not you.  I think I got in the 
"this is surreal" mode as a result of that (invoking for-each-ref 250 
times is bad enough, obviously.)

> BTW I take some satisfaction in that you finally agreed (in another email) 
> that some post-creation caching is necessary.

I don't believe I have ever disputed that (in fact, I have pushed very 
hard for gitweb to do post-creation caching.)

> I would be even more satisfied if you finally agreed that it is a good 
> practice to separate conceptually different things, and not continued ad 
> infinitum (and ad nauseam) arguing that .git/info/refs should serve dumb 
> transports, and gitweb, and eventually bring peace to everybody on this 
> planet.

I've already said I think it's an aesthetic argument, but I don't really 
care either way, as long as there is only one hook that updates all the 
caches.  I don't want the user to have to juggle an arbitrary and 
increasing number of hooks.

Fair?

	-hpa
