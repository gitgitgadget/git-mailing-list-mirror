From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 12:56:23 -0600
Message-ID: <427BBDD7.90600@tuxrocks.com>
References: <Pine.LNX.4.21.0505061321590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:51:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU7uP-0001uu-RL
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVEFS5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFS5B
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 14:57:01 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:57611 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261265AbVEFS4m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 14:56:42 -0400
Received: from [128.187.171.102] (obelix.cs.byu.edu [128.187.171.102])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j46IuOeB012349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2005 12:56:25 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505061321590.30848-100000@iabervon.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Barkalow wrote:
> On Fri, 6 May 2005, Frank Sorenson wrote:
> 
> 
>>Note that I could be just thinking about this all wrong, so my
>>terminology could be in left field.  Here, I'm mostly just interested in
>>the case where "Hey, something broke with drivers/char/i8k.c.  When was
>>this changed?  Who changed what?"
> 
> 
> The tricky thing is that you want to *not* see commits where somebody
> adopted somebody else's change to drivers/char/i8k.c; you want to ignore
> those commits in favor of the commits where the original author of the
> changes made the changes. Otherwise, you mostly see merges with people
> submitting lines where they didn't change that file.

True.  At least usually.  Sometimes, though, we'll want to see the
entire history of the file, so we can see when it went (for example)
into Greg K-H's tree, then when Linus pulls into his tree, etc.  I guess
that makes "just when the file itself has actually changed" a special
case of the entire history of a particular file.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe73XaI0dwg4A47wRAvxaAJ9E1mFepuHmTfvVfwr8zMwpqqcSZACgsz0M
NVAd1f2ZGzu+NPqD3zDQ3Yo=
=I3EA
-----END PGP SIGNATURE-----
