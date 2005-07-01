From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tags
Date: Fri, 01 Jul 2005 15:44:47 -0700
Message-ID: <42C5C75F.4040100@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>	<42C454B2.6090307@zytor.com>	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>	<42C462CD.9010909@zytor.com>	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>	<42C46B86.8070006@zytor.com>	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>	<42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 00:38:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoU9F-0001LU-S0
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 00:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVGAWpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVGAWpk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 18:45:40 -0400
Received: from terminus.zytor.com ([209.128.68.124]:29073 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261611AbVGAWpf
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 18:45:35 -0400
Received: from [10.4.1.32] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j61MiqCp030472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 15:44:53 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman wrote:
> 
> There is a question of how bad is this.   For releases you certainly
> need some kind of signature that people can verify and we
> already have that but I think we can keep spoofing tags
> down to the same level as spoofing patches.
> 
> Basically all this takes is to make your global namespace
> the committer email address and you have the rule that
> you can only tag your own commits.  Then when you merge
> tags you never automatically add tags to your own tag namespace.
> 

Doesn't work.  You can trivially generate a key with someone else's 
address.  It would require a full PKI.

	-hpa
