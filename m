From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: corrupt object on git-gc
Date: Fri, 09 Nov 2007 17:03:23 +0100
Message-ID: <473484CB.9060804@viscovery.net>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>	 <473464A2.7080003@op5.se>	 <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>	 <47347E0E.1040205@viscovery.net> <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:03:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWKd-00055J-2c
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbXKIQD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756142AbXKIQD1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:03:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25086 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbXKIQD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:03:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IqWJq-0002Kf-Oa; Fri, 09 Nov 2007 17:02:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 831E76C4; Fri,  9 Nov 2007 17:03:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4fe79b4b0711090753r52abd3e1ree64271c0fa229f6@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64206>

Yossi Leybovich schrieb:
> On Nov 9, 2007 10:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Yossi Leybovich schrieb:
>>> [about corrupt loose object '4b9458b3786228369c63936db65827de3cc06200']
>> You can try to create a clone (after you have fixed up the artificial
>> breakages that you made). If that goes well, then the bad object is
>> referenced only from reflogs.
>>
> 
> 
> git clone ib ib-clone
> Initialized empty Git repository in /home/mellanox/work/symm/ib-clone/.git/
> 0 blocks

Make this:

    git clone file:///home/mellanox/work/symm/ib ib-clone

otherwise you get a hard-linked identical copy, but you want to use the git 
protocol to create the clone.

-- Hannes
