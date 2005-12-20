From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [PATCH] cg-completion: improve options and command listing
Date: Tue, 20 Dec 2005 11:43:52 +0930
Message-ID: <FB1B98E9-58B8-44BE-AC08-606C30A5F61A@hawaga.org.uk>
References: <20051211190931.GF2960@diku.dk> <EF827EE8-7B7A-4D19-A08D-8C67D6B74195@hawaga.org.uk> <20051218143439.GA7064@diku.dk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 22 01:27:17 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpEIe-0000qR-AE
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 01:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVLVA0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Dec 2005 19:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVLVA0O
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 19:26:14 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:5648 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S965020AbVLVA0N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2005 19:26:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jBM0Olrw012586;
	Thu, 22 Dec 2005 00:25:40 GMT
In-Reply-To: <20051218143439.GA7064@diku.dk>
To: Jonas Fonseca <fonseca@diku.dk>
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13924>


On 19 Dec 2005, at 00:04, Jonas Fonseca wrote:
>>
>> I'm interested by what you mean by 'all sorts of garbage' - it seems
>> ok on my machine.
>
> ~/src/cogito/cogito > __cg_cmdlist | head
>         cg-add             Add files to the GIT repository.
>         cg-clean           Clean unknown files from the working tree.
>         cg-clone           Clone a remote GIT repository.

I definitely don't get that here. Bleugh!

> Else I was thinking of maybe adding --list parameter to cg-help to =20
> have
> it list all known commands.

One thing that seemed kinda neat that I saw somewhere (perhaps in =20
darcs?) is that it will tab complete only commands that would make =20
sense in the present location (so cg <tab> would perhaps only bring =20
up 'init' and 'help' in a non-git directory) - that would be rather =20
more invasive to implement, I expect.

Another thing that has been mooted is autogenerating the completion =20
code based on USAGE info - I've had a hack about in the past with =20
that (its in the autogen branch in the gitcompletion repo on =20
hawaga.org.uk) but then I reached the point where it seemed too icky =20
for my tastes...

--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
