From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Clean up sha1 file writing
Date: Fri, 02 Jun 2006 11:44:32 -0700
Message-ID: <44808710.1080000@zytor.com>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org> <E1Fixs4-0005pD-10@moooo.ath.cx> <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 02 20:45:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmEdd-0001hh-C0
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 20:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFBSoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 14:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWFBSoq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 14:44:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26829 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932160AbWFBSop
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 14:44:45 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k52IiWXT023652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Jun 2006 11:44:33 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605241145490.5623@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21173>

Linus Torvalds wrote:
> 
> On Wed, 24 May 2006, Matthias Lederhofer wrote:
> 
>>> checking for partial writes
>> Just out of interest: is this to be safe on any OS or should this
>> be checked always?
> 
> Any POSIX-conformant OS/filesystem should always do a full write for a 
> regular file, unless a serious error happens.
> 

Actually, at least Linux won't, if the object is larger than 2 GB on a 64-bit system :)

	-hpa
