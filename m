From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the rel=vcs-*
 microformat)
Date: Thu, 08 Jan 2009 16:26:56 -0800
Message-ID: <496699D0.1080006@eaglescrag.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net> <20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org> <20090108195446.GB18025@gnu.kitenet.net> <496691EC.1070805@eaglescrag.net> <alpine.DEB.1.00.0901090118431.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 01:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL5Eq-0000bU-5O
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbZAIA1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZAIA1M
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:27:12 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:39342 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZAIA1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:27:11 -0500
Received: from [172.19.0.11] (c-67-164-30-157.hsd1.ca.comcast.net [67.164.30.157])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n090R4DR028951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 16:27:05 -0800
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0901090118431.30769@pacific.mpi-cbg.de>
X-Virus-Scanned: ClamAV 0.88.7/8845/Thu Jan  8 08:52:13 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Thu, 08 Jan 2009 16:27:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104976>

Johannes Schindelin wrote:
> Hi,
>
> On Thu, 8 Jan 2009, J.H. wrote:
>
>   
>> Look at either Lea's or my caching engines, it will help dramatically on 
>> something of that size.
>>     
>
> Speaking of which, do you have any performance comparisons between the 
> two?
>   
Lea's got some - I can see if I can dig up my copy (or if she's paying 
attention maybe she can publish them), though either one is orders of 
magnitude faster than the normal code.  Beyond that it waffles back and 
forth which one is faster & why mainly because of the approaches we each 
took on the caching.  Generally speaking I would push people more 
towards Lea's than my work, if nothing else hers is more in line with 
current gitweb, though I have had some thoughts about undoing my file 
breakout and getting my code base back up to speed.

- John 'Warthog9' Hawley
