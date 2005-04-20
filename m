From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 17:38:48 +1000
Message-ID: <42660708.60109@zytor.com>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com> <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:36:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9kY-0007AM-CB
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDTHkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDTHkF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:40:05 -0400
Received: from terminus.zytor.com ([209.128.68.124]:46814 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261270AbVDTHkB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 03:40:01 -0400
Received: from [172.24.2.78] ([150.203.247.9])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3K7cp8n031169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Apr 2005 00:38:56 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> So I'll see if I can turn the current fsck into a "convert into
> uncompressed format", and do a nice clean format conversion. 
> 

Just let me know what you want to do, and I can trivially change the 
conversion scripts I've already written to do what you want.

	-hpa
