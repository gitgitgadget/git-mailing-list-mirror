From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Tags
Date: Sat, 02 Jul 2005 19:49:16 -0400
Message-ID: <42C727FC.3030900@gmail.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com> <42C70EEF.6050207@gmail.com> <Pine.LNX.4.58.0507021517220.8247@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 01:49:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dorjt-0004d1-5g
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 01:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGBXt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 19:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVGBXt0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 19:49:26 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:32531 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261323AbVGBXtV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 19:49:21 -0400
Received: by wproxy.gmail.com with SMTP id i11so538069wra
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 16:49:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SVK84kUErxk6kxUZ154gJ713BkTsmSN5XXdrsk/kj0CnxNNCIDxeGbUkonbVLBzDlK7BFGnv0GyFTVFhm9vBTmlWZ5kQoqtZMR7mzuFm6bBGeqn9uF+Jdhc5PJlVWYhLIAgxmixLARCigj+wAoeTPX8dXI/Dn18hMU8sAbxdibE=
Received: by 10.54.53.15 with SMTP id b15mr2579446wra;
        Sat, 02 Jul 2005 16:49:20 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 15sm1838677wrl.2005.07.02.16.49.20;
        Sat, 02 Jul 2005 16:49:20 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021517220.8247@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 2 Jul 2005, A Large Angry SCM wrote:
>>Why have tag objects at all?
> 
> Trust.
> 
> None of git itself normally has any "trust". The SHA1 means that the 
> _integrity_ of the archive is ensured, but for some things (notably 
> releases), you want to have something else. That's the "tag object".
> 

But can't the commit object do this just as well by signing the commit text?

> And I really should probably have called them something else. _I_
> personally tend to want to have a 1:1 relationship between my "tag
> references" (ie the 20-byte SHA1 pointer) and my "tag objects", but that's
> because my releases are things that I envision people may actually want to
> verify are mine.
> 

Your tendency is to use tag objects as a permanent, public label of some 
state. Signing the commit text or the email stating that commit 
${COMMIT_SHA} would work just as well for verification purposes. Or even 
a blob object containing the signed text "${COMMIT_SHA} is vX.X.X.X". 
Either way, you'd still need some kind of external reference to find the 
object.

> In many cases, you'd never use a "tag object", and the "tag reference" 
> would just point directly to a commit, with no extra indirect object.

Tag refs, like head refs and branches, are all just (temporary) 
notational shorthand to make using the tools easier.

The problem with the Borg repository is not the objects but the object 
refs. Isn't that just a namespace problem?
