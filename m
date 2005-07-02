From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tags
Date: Sat, 02 Jul 2005 18:02:23 -0400
Message-ID: <42C70EEF.6050207@gmail.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 00:09:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoqAj-0005yR-MN
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 00:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVGBWHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVGBWDf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 18:03:35 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:23342 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261306AbVGBWC0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 18:02:26 -0400
Received: by wproxy.gmail.com with SMTP id i31so514929wra
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 15:02:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E72RB5MUqn2nJ5cAW62nQjAN8A1Y21+/UX58bWxeon05VJ5oPq3dY2MNsJyBF/nxInO99RrrGxcDmFjCF7hx10TTN87j66d2mIsiLVHmLn8PFxUr1hARGLsiBNu+HeGc1E+QlJdqy5OUBI73V7LNRy2DHskb249kzoDzgo17TJI=
Received: by 10.54.26.19 with SMTP id 19mr2617602wrz;
        Sat, 02 Jul 2005 15:02:26 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id d74sm2768623wra.2005.07.02.15.02.25;
        Sat, 02 Jul 2005 15:02:26 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42C70A5B.9070606@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



H. Peter Anvin wrote:
...
> 
> OK, so let me retell what I think I hear you say:
> 
> - Store all the tags in the object store; they may conflict.
> - Let each source user have a set of refs, and provide a method for the 
> end user to select which refs to get.
> 
> In other words, the only way (other than knowing what GPG keys to trust) 
> to distinguish between your "v2.6.12" and J. Random Hacker's "v2.6.12" 
> is that the former is referenced by *your* refs as opposed to JRH's 
> refs.  This also means the refs cannot be uniquely rebuilt from the 
> object storage.

Why have tag objects at all?
