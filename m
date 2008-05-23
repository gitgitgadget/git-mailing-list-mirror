From: Logan Kennelly <logank@sent.com>
Subject: Re: perforce import: git-p4 memory usage
Date: Fri, 23 May 2008 15:27:06 -0700
Message-ID: <C3A347D5-E9E2-4AEB-96EC-179972224CB3@sent.com>
References: <H1SlcXmh.1211537268.4996380.lgd@diamand.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat May 24 00:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzfk6-0002yd-8o
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657AbYEWW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758610AbYEWW1J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:27:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41029 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758568AbYEWW1I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 18:27:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1ED9810E8E1;
	Fri, 23 May 2008 18:27:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 May 2008 18:27:08 -0400
X-Sasl-enc: ZkpaSUiYLGPjnp+rxw1fmobqQglA7cRT4V0b0ZPM1ipl 1211581627
Received: from [192.168.1.140] (ip68-104-238-221.ph.ph.cox.net [68.104.238.221])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9CBE1168EC;
	Fri, 23 May 2008 18:27:07 -0400 (EDT)
In-Reply-To: <H1SlcXmh.1211537268.4996380.lgd@diamand.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82764>

On May 23, 2008, at 3:07 AM, Luke Diamand wrote:

> However, git-p4 appears to try to read all the repo into memory (and
> moreover seems to need about twice as much memory as repo).
>
> Once it runs out of swap, it dies (unsurprisingly).
>
> I think it's failing in readP4Files(), where it appears to read the
> entire repository in one go with "p4 -G -x - print".
>
> Can I just rework this function to do stuff one file at a time? Or is
> that dumb?


I don't know if they were ever accepted into the mainline, but see the
series of patches submitted by Tommy Thorn.

http://article.gmane.org/gmane.comp.version-control.git/72342

-- 
                                                         Logan Kennelly
       ,,,
      (. .)
--ooO-(_)-Ooo--
