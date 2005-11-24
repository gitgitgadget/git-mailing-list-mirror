From: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Fri, 25 Nov 2005 08:33:56 +1000
Message-ID: <41D1FCC0-E031-48FB-82A2-6CFDA2E03AC0@hawaga.org.uk>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 01:54:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfRqB-0000BU-Nk
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 01:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVKYAxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Nov 2005 19:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVKYAxM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 19:53:12 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:48913 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S932677AbVKYAxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 19:53:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAP0kTtZ024737;
	Fri, 25 Nov 2005 00:51:45 GMT
In-Reply-To: <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12722>


On 22 Nov 2005, at 05:29, Junio C Hamano wrote:

>
> Personally I do not mind moving remotes/branches information
> there, except that I suspect the git-config-set interface makes
> it cumbersome to (1) find out what remotes I defined (i.e. an
> equivalent of "ls .git/remotes")

(1) is useful to be able to do in a very lightweight way when doing =20
tab completion on remotes. Having heads, tags, remotes in nicely =20
named separate files makes that pretty straightforward; I don't know =20
if using a git-config- accessor would make this noticeably worse, =20
though, as I haven't tried anything out there yet.

--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
