From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:56:09 +0200
Message-ID: <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
	 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
	 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org>
	 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com>
	 <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:56:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWni-0006u6-EC
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWEaT4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWEaT4P
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:56:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:16461 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751793AbWEaT4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:56:15 -0400
Received: by wr-out-0506.google.com with SMTP id i5so102711wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:56:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0KhW3coL6WFwO8oLPzYzs1AouaHLVl4808zrJDvJuvNAvr6aV4KR8Pcrf6llCrK/e6du+ISL/tlojYJUQHl5Uwi73CgFAx3nIcgF6dzKTnxmQYuK0UXLTLtVR9n5qw+GuQ5NH33Q8eUXtMaIuIAUD+XaOL/DlB9Ah8G85sfDLs=
Received: by 10.64.213.6 with SMTP id l6mr720573qbg;
        Wed, 31 May 2006 12:56:14 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:56:09 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21088>

On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
[...]
> And even more intersting:
> make clean && make && sudo make install
> git --version
> git version 1.3.GIT
>
> make install
> [...]
> mv git-cherry-pick+ git-cherry-pick
> mv: sovrascrivo `git-cherry-pick' ignorando il modo 0755?
> that in english is something like:
> mv: overwrite `git-cherry-pick' ignoring mod 0755?
>
> Wow...of course, make clean && make install fix everything
>

Thanks to loops on #git for asking me to do the following test:

<PaoloC> paolo@Italia:~/git$ sudo ./GIT-VERSION-GEN
<PaoloC> GIT_VERSION = 1.3.GIT
<PaoloC> paolo@Italia:~/git$ ./GIT-VERSION-GEN
<PaoloC> GIT_VERSION = 1.3.3.g2186

I don't know why it's happening...
-- 
Paolo
http://paolociarrocchi.googlepages.com
