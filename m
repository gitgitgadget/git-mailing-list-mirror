From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Allow "-u" flag to tag signing
Date: Thu, 06 Oct 2005 10:15:40 -0700
Message-ID: <43455BBC.6020908@zytor.com>
References: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENZLj-0001FI-EP
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 19:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVJFRQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVJFRQE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 13:16:04 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44250 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751156AbVJFRQC
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 13:16:02 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j96HFeIn004900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Oct 2005 10:15:42 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510060952410.31407@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9776>

Linus Torvalds wrote:
> The current "git tag -s" thing always uses the tagger name as the signing 
> user key, which is very irritating, since my key is under my email 
> address, but the tagger key obviously contains the actual machine name 
> too.
> 
> Now, I could just use "GIT_COMMITTER_EMAIL" and force it to be my real 
> email, but I actually think that it's nice to see which machine I use for 
> my work. 
> 
> So rather than force my tagger ID to have to match the gpg key name, just 
> support the "-u" flag to "git tag" instead. It implicitly enables signing, 
> since it doesn't make any sense without it. Thus:
> 
> 	git tag -u <gpg-key-name> <tag-name> [<tagged-object>]
> 
> will use the named gpg key for signing.

This is important for another reason as well: a lot of people have 
multiple keys.

	-hpa
