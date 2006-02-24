From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Thu, 23 Feb 2006 22:53:22 -0800
Message-ID: <43FEAD62.6050302@zytor.com>
References: <20060224002915.17331.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 07:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCWpk-0001Ch-U7
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 07:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBXGxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 01:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWBXGxk
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 01:53:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6040 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750887AbWBXGxk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 01:53:40 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k1O6rMBV015979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Feb 2006 22:53:24 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20060224002915.17331.qmail@science.horizon.com>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16686>

linux@horizon.com wrote:
> The annoying thing about temporary branch names like "bisect" and "seek"
> is that:
> a) They clutter up the nae space available to the repository user.
>    Users have to know that those are reserved names.
> b) If a repository is cloned while they're in use, they might get
>    into a "remotes" file, with even more confusing results.
> 
> This is somewhat heretical, but how about making a truly unnamed branch by
> having .git/HEAD *not* be a symlink, but rather hold a commit ID directly?
> It's already well established that files in the .git directory directly
> are strictly local to this working directory, so it seems a much better
> home for such temporary state.
> 

It might be easier to just reserve part of the namespace, e.g. ".bisect" 
and ".seek" instead.

	-hpa
