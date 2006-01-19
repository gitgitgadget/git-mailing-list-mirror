From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /etc in git?
Date: Wed, 18 Jan 2006 20:59:38 -0800
Message-ID: <43CF1CBA.8030206@zytor.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>	 <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net> <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 06:00:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzRu9-0002xC-9d
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 06:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWASE7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 23:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161321AbWASE7t
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 23:59:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:3514 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161148AbWASE7s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 23:59:48 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0J4xdYd027472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jan 2006 20:59:40 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Adam Hunt <kinema@gmail.com>
In-Reply-To: <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14885>

Adam Hunt wrote:
> Do you have any more details by chance?  Does it work?  Does it work
> well?  How does one do it?

I've put my home directory dot files into git, and I'm assuming it's 
going to be a similar issue for /etc.  I've found git to be unusually 
suitable for this, for the following reasons:

- git can deal with only managing a handful of files from a large 
hierarchy, without an insane performance penalty.
- git only needs one repository directory at the root of the tree, not 
in each subdirectory.

The biggest *problem* with git is that it doesn't handle files which 
need to have their permissions maintained.

	-hpa
