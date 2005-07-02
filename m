From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tags
Date: Sat, 02 Jul 2005 10:58:05 -0700
Message-ID: <42C6D5AD.9070304@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>	<42C454B2.6090307@zytor.com>	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>	<42C462CD.9010909@zytor.com>	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>	<42C46B86.8070006@zytor.com>	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>	<42C5714A.1020203@zytor.com>	<m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>	<42C5C75F.4040100@zytor.com>	<m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>	<42C5DA77.4030107@zytor.com>	<m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com>	<42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:59:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DomGp-0003sz-UX
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVGBR6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVGBR6z
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:58:55 -0400
Received: from terminus.zytor.com ([209.128.68.124]:35793 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261248AbVGBR6k
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 13:58:40 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j62Hw6F3019150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2005 10:58:07 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman wrote:
> 
> ?? Isn't that what ssh is?
> 
> To some extent a lot depends on how active you expect people to
> try and forge things.  If there is an expectation of honesty
> you are fine.  
> 

I can't afford to have that.

> If you want to build one mondo repository with thousands of developers
> having write access you need to be more careful.  But as far as I know
> none of that is specific to tags.

Well, you're wrong.  Tags is the only part of git which cannot be 
protected by git's own self-validation system.

	-hpa
