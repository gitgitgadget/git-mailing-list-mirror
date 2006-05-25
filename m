From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: t8001-annotate.sh fails on Mac OS X
Date: Fri, 26 May 2006 01:53:58 +0200
Message-ID: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 01:54:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjPeW-0000Gq-7s
	for gcvg-git@gmane.org; Fri, 26 May 2006 01:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWEYXyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 19:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWEYXyA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 19:54:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:53389 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965204AbWEYXx7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 19:53:59 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1935423wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 16:53:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YqJ3eep0UfB9pAtPhr7Ea1ZHAvie0XvPrC9ZiMp6XkQWtfOfMutRf1TcK7EFXaHqj7fP84RBldgw9x6HS0xVR/0pmBXTJIvzGn//jzDUG+VfjMp6MatsCLFvwwHK3fEn2N1zZiTDiPC2zvoyL8pQpjbWDhVPMl0jmohvWaMypto=
Received: by 10.65.188.10 with SMTP id q10mr204654qbp;
        Thu, 25 May 2006 16:53:58 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Thu, 25 May 2006 16:53:58 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20773>

Hi,

for some reason I could not yet figure out, t8001-annotate.sh fails at test 18.

--- snip ---
*   ok 17: some edit
* expecting success: check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
Author A (expected 1, attributed 1) good
Author B1 (expected 1, attributed 1) good
Author D (expected 1, attributed 2) bad
Author A U Thor (expected 1, attributed 1) good
Author B2 (expected 1, attributed 1) good
Author B (expected 1, attributed 1) good
* FAIL 18: some edit
        check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
* failed 1 among 18 test(s)
--- snap ---

And git-annotate in the trash dir produces the following:

--- snip ---
5c085656        (         A     2006-05-25 23:13:26 +0000       1)lazy dog
3f3e26a3        (        B2     2006-05-25 23:13:29 +0000       2)4A
quick brown lazy dog fox jumps over the
3b509ebb        (         B     2006-05-25 23:13:27 +0000       3)lazy dog
669d4e82        (         D     2006-05-25 23:13:35 +0000       4)99
slow green fox jumps into the
f96b8861        (        B1     2006-05-25 23:13:28 +0000       5)well.
a7bad43f        (  A U Thor     2006-05-25 23:13:31 +0000       6)evil merge.
669d4e82        (         D     2006-05-25 23:13:35 +0000       7)incomplete
--- snap ---

The strange point is, git log is completely ok:

--- snip ---
commit 90ef4f653d6dc33d90ce826303563e5506d5ad31
Author: C <author@example.com>
Date:   Thu May 25 23:13:34 2006 +0000

    Incomplete

--- snap ---

bye

Stefan

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
