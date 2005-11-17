From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-commit: Having $GIT_COMMITTER_NAME implies -s
Date: Wed, 16 Nov 2005 21:27:54 -0800
Message-ID: <437C14DA.8000905@zytor.com>
References: <20051116233829.0B3C55BA81@nox.op5.se> <7vbr0j3nku.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <exon@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 06:29:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EccK9-0001OZ-BG
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 06:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVKQF2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 00:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbVKQF2J
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 00:28:09 -0500
Received: from terminus.zytor.com ([192.83.249.54]:11178 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161138AbVKQF2G
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 00:28:06 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAH5RssL020420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 21:27:55 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0j3nku.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12086>

Junio C Hamano wrote:
> I am not so sure about this.  A Signed-off-by line used in the
> kernel and git projects has a specific meaning; you've read
> SubmittingPatches in either projects, have'nt you?
> 
> I do work on a machine from which I make commits to both git
> project and my day-job work project.  I do not necessarily want
> to add Signed-off-by line in commits I make for the latter.
> 

More importantly, it's vital that a Signed-off-by: line is always added 
with explicit awareness of the signer.

	-hpa
