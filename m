From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Wed, 9 Nov 2005 20:49:30 +1100
Message-ID: <5C8707EC-3A6F-46B6-8FB1-AAB0842DDDD1@hawaga.org.uk>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <1537CD60-21E4-4F5E-820F-216A4E8C06AC@hawaga.org.uk> <20051109010922.GC5830@reactrix.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 10:51:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZmai-0000LO-AR
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 10:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbVKIJt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Nov 2005 04:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVKIJt6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 04:49:58 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:57865 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751360AbVKIJt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 04:49:58 -0500
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jA99nQE8009132;
	Wed, 9 Nov 2005 09:49:28 GMT
In-Reply-To: <20051109010922.GC5830@reactrix.com>
To: Nick Hengeveld <nickh@reactrix.com>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11391>


On 9 Nov 2005, at 12:09, Nick Hengeveld wrote:
>
> Those curl result codes all look wrong, and sounds like a memory issu=
e
> that Johannes Schindelin recently fixed in commit
> 90279074ca5cc336a8bfffd47d19d089b291b432.  Does your git build have =20
> that
> patch?

I did not - I've pulled and rebuilt from master, and have that commit =20
now.
It works better (not perfectly (there's a tags 403) but I suspect =20
that may be permissions config at my server end or absence of tags in =20
my repo or something mumble). I can do this a bunch of times in a row =20
with the same results and the resulting cloned repository looks sane.

Ben

!535 [0] benc@piva:~/tmp/xa4$ cg clone http://www.hawaga.org.uk/=20
gitcompletion.git
defaulting to local storage area
20:46:16 URL:http://www.hawaga.org.uk/gitcompletion.git/HEAD [41/41] -=20
 > "refs/heads/.origin-fetching" [1]
progress: 28 objects, 7901 bytes
http://www.hawaga.org.uk/gitcompletion.git/refs/tags/:
20:46:36 ERROR 403: Forbidden.

=46INISHED --20:46:36--
Downloaded: 0 bytes in 0 files
New branch: a108bdc110dad770ec5c092759a8bc511790d21f
Cloned to gitcompletion/ (origin http://www.hawaga.org.uk/=20
gitcompletion.git available as branch "origin")


--=20
Ben =E3=83=99=E3=83=B3 =D0=91=D1=8D=D0=BD
http://www.hawaga.org.uk/ben/
