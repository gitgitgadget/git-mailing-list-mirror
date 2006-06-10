From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 11:44:58 -0400
Message-ID: <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	 <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
	 <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
	 <9e4733910606092302h646ff554p107564417183e350@mail.gmail.com>
	 <7vr71xk047.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 17:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp5e4-000281-AX
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 17:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWFJPpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFJPpA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 11:45:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:63276 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751128AbWFJPo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 11:44:59 -0400
Received: by nz-out-0102.google.com with SMTP id v1so822263nzb
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 08:44:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L5TYs5U7lqtumsmWEQAPcB9r78n8wh6n2oASLKAL+HmyqDrj2rOgDWyv++5H54He0viZblGmlxhWVtPYky1pNKi3OnnJADD7WuaqXWGZUYzNyzUbPJ6AhBXRKkBqdbGQd4U8+QkMCyFYXdxdiGg2K3+0WbQ2R6oDxTupQzaoZ7U=
Received: by 10.36.126.17 with SMTP id y17mr5880484nzc;
        Sat, 10 Jun 2006 08:44:58 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Sat, 10 Jun 2006 08:44:58 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr71xk047.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21610>

On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Here's a new transport problem. When using git-clone to fetch Martin's
> > tree it kept failing for me at dreamhost. I had a parallel fetch
> > running on my local machine which has a much slower net connection. It
> > finally finished and I am watching the end phase where it prints all
> > of the 'walk' messages. The git-http-fetch process has jumped up to
> > 800MB in size after being 2MB during the download. dreamhost has a
> > 500MB process size limit so that is why my fetches kept failing there.
>
> The http-fetch process uses by mmaping the downloaded pack, and
> if I recall correctly we are talking about 600MB pack, so 500MB
> limit sounds impossible, perhaps?

The fetch on my local machine failed too. It left nothing behind, now
I have to download the 680MB again.

walk 1f19465388a4ef7aff7527a13f16122a809487d4
walk c3ca840256e3767d08c649f8d2761a1a887351ab
walk 7a74e42699320c02b814b88beadb1ae65009e745
error: Couldn't get
http://mirrors.catalyst.net.nz/pub/mozilla.git//refs/tags/JS%5F1%5F7%5FALPHA%5FBASE
for tags/JS_1_7_ALPHA_BASE
Couldn't resolve host 'mirrors.catalyst.net.nz'
error: Could not interpret tags/JS_1_7_ALPHA_BASE as something to pull
[jonsmirl@jonsmirl mozgit]$ cg update
There is no GIT repository here (.git not found)
[jonsmirl@jonsmirl mozgit]$ ls -a
.  ..
[jonsmirl@jonsmirl mozgit]$




-- 
Jon Smirl
jonsmirl@gmail.com
