From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 21:25:31 -0700
Message-ID: <425DF0BB.8020802@zytor.com>
References: <425DEF64.60108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 06:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLvr4-0001ua-HM
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 06:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDNEYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 00:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVDNEYn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 00:24:43 -0400
Received: from terminus.zytor.com ([209.128.68.124]:16865 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261429AbVDNEYl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 00:24:41 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E4Od47028360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 21:24:39 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425DEF64.60108@zytor.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> 
> It seems that the flat format, at least on ext3 with dircache, is 
> actually a major performance win, and that the second level loses quite 
> a bit.
> 

s/dircache/dir_index/

	-hpa
