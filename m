From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git base64 repo conversion tool
Date: Wed, 13 Apr 2005 15:48:48 -0700
Message-ID: <425DA1D0.5080104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 14 00:46:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLqcA-00005j-QS
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDMWs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 18:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDMWs6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:48:58 -0400
Received: from terminus.zytor.com ([209.128.68.124]:58583 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261214AbVDMWs5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 18:48:57 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3DMms1O024577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 15:48:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I realized writing a git repository conversion tool is actually quite 
trivial in Perl, so I wrote one up and tried it on the git repo included 
in the git-0.04 tarball.  It fsck-cache's cleanly on both the nonflat 
and flat base64 patches, at least after I had fixed a minor bug in 
fsck-cache in the nonflat patch (now uploaded.)

It takes an source and a target object directory as arguments.  By 
default it is set up for non-flat representation; change $flat = 0; to 
$flat = 1; near the top to use flat representation.

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/gitcvt

Comments appreciated, of course.

	-hpa

