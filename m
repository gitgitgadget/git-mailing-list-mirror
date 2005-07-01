From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tags
Date: Fri, 01 Jul 2005 14:52:51 -0700
Message-ID: <42C5BB33.5010304@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <20050701180944.GA14375@pasky.ji.cz> <42C58D83.9060107@zytor.com> <20050701214230.GA22003@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 23:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoTKw-0003wD-UX
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 23:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVGAVxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVGAVxr
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 17:53:47 -0400
Received: from terminus.zytor.com ([209.128.68.124]:53926 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261593AbVGAVxk
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 17:53:40 -0400
Received: from [10.4.1.32] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j61LquLw029422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 14:52:59 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050701214230.GA22003@pasky.ji.cz>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> 
> I doubt that's really useful either. Rather artificial mechanisms for
> protection of the namespace would have to be deployed, and again, what
> would it be good for anyway? If you are tagging linux-2.m.n, you are
> probably whoever you should be - David, Alan, Marcelo, Linus, or whoever
> else, while if you are tagging linux-2.m.n-cki, you are likely Con
> Kolivas. I don't believe there is any (or much) potential for "natural"
> conflicts and if you are malicious, you will just fake the namespace;
> but frequently what's interesting about the tags is not the author at
> all - I would consider it confusing to have to suddenly dive to another
> namespace when Linus hands maintenance of linux-2.m to someone else.
> 
> The only significant value I can therefore see in the namespaces is
> prevention of user mistakes, but I think the successful strategy here
> would be just "upstream will notice", and make sure the upstream will be
> noticed properly (perhaps even interactively) about any new tags it
> gets.
> 
> Ok, I admit that it boils down to me being lazy and that "it'd be more
> typing!"... ;-)
> 

You're missing the whole point of the discussion.  Right now the only 
thing that makes a global object store impossible is the potential for a 
tag conflict, either intentional or accidental.

	-hpa
