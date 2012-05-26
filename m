From: Timothy Normand Miller <theosib@att.net>
Subject: =?windows-1252?Q?Re=3A_Git_hangs_at_=93Writing_objects=3A_11=25?=
 =?windows-1252?Q?=94?=
Date: Sat, 26 May 2012 18:54:57 -0400
Message-ID: <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net> <033AF49C-4CB3-4412-8845-0246D356358C@att.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 27 01:02:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYQ0B-0002LU-JI
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 01:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab2EZXBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 19:01:46 -0400
Received: from nm6-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.114]:34165
	"HELO nm6-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751617Ab2EZXBp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 19:01:45 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 May 2012 19:01:45 EDT
Received: from [98.139.44.97] by nm6.access.bullet.mail.sp2.yahoo.com with NNFMP; 26 May 2012 22:55:00 -0000
Received: from [98.139.44.72] by tm2.access.bullet.mail.sp2.yahoo.com with NNFMP; 26 May 2012 22:55:00 -0000
Received: from [127.0.0.1] by omp1009.access.mail.sp2.yahoo.com with NNFMP; 26 May 2012 22:55:00 -0000
X-Yahoo-Newman-Id: 598076.60287.bm@omp1009.access.mail.sp2.yahoo.com
Received: (qmail 38854 invoked from network); 26 May 2012 22:55:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1338072900; bh=oeyIZ+JLWngrg7Y08LITFniWugLmVG3GybZ2seqy848=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Subject:Mime-Version:Content-Type:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=qqVh9gv09PC2BUVAtF/ig4w7Ly/0O4xdbVySyyVaGad282mT6qyXvKMcLD3oLnPYUmqFHZKYv0eIXRohwo63i15WGVyRQJjM67wa6guyPgB0qvCHY8BbvP0Iw0+A82LBENHO7xndirtcARA0nYpzyewou9HIBoUJJc42bpGC4uo=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: XTV1oRQVM1nH865C0HRcNK2MgHcdc3VFMA2DNnB3mle6SZA
 aEvVt0VWVKwNF6DDseCxZMx3dlD7GokknzKmx1VoN7ZD3NMVYOCHuzZd1BDT
 5jxGvndplr59f0prSdfMzRGKhCz2Qm5Z7I8.A604MsLbg2jIUn6TNJ.o8tLS
 wO5nzMlnXPB5ti.jomQa1PChSMdqQ7mJAZ_e8KoDs.q1kDDW6tGv8yLgiTkW
 zznYYqxIiXsZv4OmzcRGIy3t22Hr_OaGdy8EB0RY.a1mvAQwBBd6bVYowKyo
 qSKbQsMkknIrNNhqTh3OOgfTiqYdXhiJC3XrzukFSt6aitRORtBkPM_UTduC
 KcAu_x82lpxCBDLe0T2qtBBY0ILFmUTh60ofJwymCbekHLvRmIOfCoGiLZa4
 Fm1NyqjHSi7hbyzYXuH5Si_kRN4tEjkun_cqQET2MN.Abjj6CD6kWqut8w2Y
 ZAaI75rKG2uJtpfseGGEaBWA3QPVu2Pb.QBRPdkDEklZ3809Ikli6joAAcBE
 zj811hyPyU1kHY2OTIEMk
X-Yahoo-SMTP: fnCipqKswBBOUfpM7XF4CajMkMYSy.KS.UTLsA--
Received: from [192.168.1.107] (theosib@76.232.38.36 with plain)
        by smtp104.sbc.mail.gq1.yahoo.com with SMTP; 26 May 2012 15:54:59 -0700 PDT
In-Reply-To: <033AF49C-4CB3-4412-8845-0246D356358C@att.net>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198573>

I did some more research and testing.  This is an ssh problem.  If I change the protocol to git://, then I can push remotely all I want.  Same for file://.  But using ssh, it hangs.  Since I want ssh encryption, I still need to figure out why ssh is going wrong.


On May 24, 2012, at 9:41 PM, Timothy Normand Miller wrote:

> 
> On May 24, 2012, at 8:51 PM, Jeff King wrote:
> 
>> On Thu, May 24, 2012 at 05:40:41PM -0400, Timothy Normand Miller wrote:
>> 
>>> I've run into a problem that I cannot debug.  I've talked with people
>>> at length on IRC, I've made ample use of Google.  I'm getting nowhere.
>>> I'm not even getting any attention on stackexchange (where usually,
>>> questions are answered with surprising alacrity).  
>>> 
>>> This is not the common scenario of Windows and git-daemon that I have
>>> seen answered elsewhere. This is Linux to Linux, using ssh. On both
>>> the client and server, git version is 1.7.8.6.
> 
> Thank you for helping!
> 
>> 
>> I'd first start with trying to remove as many variables as possible.
>> Does the problem only happen over ssh, or does it also happen when
>> pushing across a pipe to a repo on the local machine? If so, does it
>> also happen during a fetch of the same data?
> 
> If the local repo I'm pushing to is given by pathname, it's fine.  If I'm pushing to another account via ssh on the localhost, it has the same hangup.
> 
> All fetches work fine.
> 
>> 
>> If you can reproduce it at will (which it sounds like you can), you
>> could also try some older or newer git versions to see if they work any
>> better. If you can find a working version, it might be worth trying to
>> bisect and find the commit that introduces the breakage.
> 
> There's this one CentOS 6 machine where I know for a fact that git hasn't been updated since I was last able to push this particular repo.  That machine has git version 1.7.1.  That's where I first encountered the problem.  So I copied the repo to my Mac (version 1.7.8.6), but it freezes there at 11%.  Then I tried copying it to the same machine that hosts the repo (Gentoo Linux with git version 1.7.8.6), and push from there (still using ssh, but locally), and it also freezes at 11%.
> 
> So there's something wonky about the repo that git doesn't like, although it only has the problem over ssh.  I haven't tried git's native protocol.
> 
>> 
>> If the problem still exists in the latest version, then I'd start by
>> stracing as much as possible. On the client side, you can use "strace
>> -f" to see what all of the processes are doing; you'll probably also
>> want to pass:
>> 
>> --receive-pack='strace -f -o foo.out git-receive-pack'
> 
> First, I ran the push and then killed it, and I got this:	
> http://www.cse.ohio-state.edu/~millerti/foo.out
> 
> But then I realized that you'd want to see where it hung up, so I can it again and then sent the file before killing the push:
> http://www.cse.ohio-state.edu/~millerti/foo2.out
> 
> 
>> 
>> to git-push to ask the remote side to strace. There's a reasonable
>> chance you'll simply see that the client side is waiting on the server
>> side for I/O, so you'll want to know what the server side is doing.
> 
> I really don't know how to interpret the trace.
> 
>> 
>> I see you posted an strace snippet of a process waiting in select() on
>> stack overflow. It's hard to tell what's going on from there, though,
>> because we can't see which processes are which (we see the pids, but we
>> don't know which programs they're running, or where the commands go). A
>> full strace log would help a lot (if it's long and you need a place to
>> post it, try something like https://gist.github.com).
> 
> Try this:
> http://www.cse.ohio-state.edu/~millerti/revue_strace3.txt
> 
> This one was from earlier in the day.  It's from a push from the same machine that hosts the repo.
> 
>> 
>> And finally, if the repo is something you can make public, I can try to
>> reproduce on my machine. That might tell us if the problem is with your
>> repo, or something else about your machines or setup.
> 
> That would make things a lot easier, but I'm not at liberty to share it.
> 
> 
> Thanks again!
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
