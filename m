From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Sat, 24 Jan 2009 19:18:05 -0500
Message-ID: <81bfc67a0901241618kfaa79bcy8fdb16ecedf5f8b5@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <20090121170434.GA21727@hashpling.org>
	 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
	 <20090122142258.GA2316@hashpling.org>
	 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
	 <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0901241036v6ca30c24q54487e118fd67c1c@mail.gmail.com>
	 <20090125064539.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 01:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsj2-00069M-IT
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 01:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZAYASM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 19:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbZAYASJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 19:18:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:34417 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZAYASI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 19:18:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3038295fgg.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zwEgM+384KRgPj/nPvndmYi39H+Fwof021rtwEDPyu0=;
        b=okMfkWn79bk4CqxnrNDgtx9Y6+CCJBk0D948V4D0uGVmw9YjJ0W3Z0N7QaMiswXC9h
         Xs+lq+eH/sXW9KG7kSTGxtMACaNYWTgNi8uhJXxjRTxmf0ezP+BfU1V70mRvAXOxPEpn
         ewjMOYvqQGuYFgolh/YmEB0Ih+VXArB1exAOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b8t759JOa8iiX+uvh8pA7gnADmK1CyT3i+GPDXPWXehIrbd9K45nRGjbhM54XN8HQy
         GhddXPJRFdpZO2IAGZXarTsiqlR/z/DinF/mX1XnUSeSDDeDDbOSMgIE2Q+iOzr5ixXi
         Viizvu1YFdoh9ngh0Q/Isd8rAU3OBT9uxJXIc=
Received: by 10.223.126.145 with SMTP id c17mr41686fas.102.1232842685164; Sat, 
	24 Jan 2009 16:18:05 -0800 (PST)
In-Reply-To: <20090125064539.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107027>

>   1. You copy-and-pasted output from format-patch, and have the header
>     part in the message body. Charles and Johannes have moved them to the
>     Email header.
>
>     Their messages are in the form the tool used for patch acceptance
>     expects. Yours isn't, and forces Junio to manually edit your message
>     before handling it.

I'll get to the rest later...

but I tried sending the patch via email as you said followed this...
verbatim except replacing user@ and p4ssw0rd with my credentials, and
I got an auth error back. currently I've no idea how I would send
stuff from gmail. and I reject inline patches in funtoo because I use
webmail and they are impossible for me to handle easily.

Submitting properly formatted patches via Gmail is simple now that
IMAP support is available. First, edit your ~/.gitconfig to specify your
account settings:

[imap]
    folder = "[Gmail]/Drafts"
    host = imaps://imap.gmail.com
    user = user@gmail.com
    pass = p4ssw0rd
    port = 993
    sslverify = false

Next, ensure that your Gmail settings are correct. In "Settings" the
"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.

Once your commits are ready to send to the mailing list, run the following
command to send the patch emails to your Gmail Drafts folder.

    $ git format-patch -M --stdout origin/master | git imap-send



-- 
Caleb Cushing

http://xenoterracide.blogspot.com
