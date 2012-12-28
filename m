From: John Moon <johnmoon77@hotmail.com>
Subject: RE: git diff --ignore-space-at-eol issue
Date: Fri, 28 Dec 2012 14:59:27 -0500
Message-ID: <BLU163-W51DAB90003C969CDF837A2CF3F0@phx.gbl>
References: <BLU163-W40634B340214076467C88ECF360@phx.gbl>,<CALWbr2y3BdqcD-62jhPSQsK3U=8-Dc=R-jxg8H0yqpgVfdHJXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 20:59:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tog5u-00069o-Px
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 20:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2L1T7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2012 14:59:30 -0500
Received: from blu0-omc3-s10.blu0.hotmail.com ([65.55.116.85]:3305 "EHLO
	blu0-omc3-s10.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754238Ab2L1T72 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 14:59:28 -0500
Received: from BLU163-W51 ([65.55.116.72]) by blu0-omc3-s10.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 28 Dec 2012 11:59:27 -0800
X-EIP: [7lomYP4hvvRYVeBhzVmD55tNfSMHKRre]
X-Originating-Email: [johnmoon77@hotmail.com]
Importance: Normal
In-Reply-To: <CALWbr2y3BdqcD-62jhPSQsK3U=8-Dc=R-jxg8H0yqpgVfdHJXw@mail.gmail.com>
X-OriginalArrivalTime: 28 Dec 2012 19:59:27.0808 (UTC) FILETIME=[D7AD0400:01CDE535]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212254>



> $ git diff --ignore-space-at-eol test.txt
> $ git diff --ignore-space-at-eol --stat test.txt
> test.txt | 0
> 1 file changed, 0 insertions(+), 0 deletions(-)
> $ git diff --ignore-space-at-eol --name-status test.txt
> M test.txt
>
> The idea is that even though diff doesn't show any differences, stat,
> shortstat, numstat and name-status reports the file as being changed.
> This is available since v1.8.1-rc0.

Thanks for the info. =A0Unfortunately it's not what i would expect. =A0
If i told git diff specifically to ignore line endings, why is --name-s=
tatus =A0showing me a file as being modified when the only modification=
 is the very thing i told it to ignore. =A0
The same thing for --stat, why is it showing me a file with zero change=
s? =A0Just my opinion though.

I'll tell you why this is a problem for me, basically what i am doing i=
s running the "git diff --ignore-space-at-eol --name-status " =A0on my =
root directory to give to someone else who is not using git to give the=
m the files that i have modified. =A0I don't want to give them a file w=
here only the line ending has changed.

Cheers. 		 	   		  