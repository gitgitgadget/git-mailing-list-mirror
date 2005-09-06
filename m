From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Tue, 06 Sep 2005 11:56:00 -0700
Message-ID: <431DE640.8050901@zytor.com>
References: <431DD381.4050709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 20:58:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECicM-0004T3-QH
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 20:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVIFS4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 14:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVIFS4X
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 14:56:23 -0400
Received: from terminus.zytor.com ([209.128.68.124]:33749 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750798AbVIFS4W
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 14:56:22 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j86Iu5Vb016320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 11:56:06 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431DD381.4050709@zytor.com>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8137>

H. Peter Anvin wrote:
> This patch changes git-cvsimport-script so that it creates tag objects 
> instead of refs to commits, and adds an option, -u, to convert 
> underscores in branch and tag names to dots (since CVS doesn't allow 
> dots in branches and tags.)
> 
> Pullable tree at master.kernel.org:/home/hpa/git/cvsimport.git/

I should probably point out that there are still bugs in 
git-cvsimport-script; for one thing, it seems to fail to register a tag 
associated with the head, and I have yet to get the "recognize merge" 
feature to actually work.  It's also possible -- but I haven't verified 
it -- that two tags which are aliases may not be properly registered.

	-hpa
