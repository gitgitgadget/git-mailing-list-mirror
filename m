From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 1 Jul 2007 19:30:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011929200.4438@racer.site>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site> <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
 <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
 <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011903200.4438@racer.site> <20070701182637.GL7969MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1253143926-1183314609=:4438"
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 01 20:30:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I54Bg-00078V-Qm
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 20:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXGASaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 14:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbXGASaS
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 14:30:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:44833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754628AbXGASaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 14:30:16 -0400
Received: (qmail invoked by alias); 01 Jul 2007 18:30:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 01 Jul 2007 20:30:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+MpMpjWo+3gi7JTh+BCWfM6azyXiCdpq/O2Wo4Z
	R6WTQz+6NnbNTy
X-X-Sender: gene099@racer.site
In-Reply-To: <20070701182637.GL7969MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51317>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1253143926-1183314609=:4438
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Sun, 1 Jul 2007, Sven Verdoolaege wrote:

> On Sun, Jul 01, 2007 at 07:06:43PM +0100, Johannes Schindelin wrote:
> > And send me the resulting pubring.gpg and secring.gpg?
> 
> Attached.

Thanks.

> > If you have a little more time, you could also put them in t/t7004/, and 
> > check t7004-tag.sh...
> 
> Different...  (assuming I understand your request correctly)
> 
> * expecting success: 
>         git-tag -s -m "A signed tag message" signed-tag &&
>         get_tag_msg signed-tag >actual &&
>         git-diff expect actual
> 
> gpg: Warning: using insecure memory!
> gpg: skipped `C O Mitter <committer@example.com>': secret key not available
> gpg: signing failed: secret key not available

Aargh! I am a complete moron. Attached also the private key now.

Ciao,
Dscho
--8323584-1253143926-1183314609=:4438
Content-Type: TEXT/plain; charset=utf-8; name=seckeys.asc
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0707011930090.4438@racer.site>
Content-Description: 
Content-Disposition: attachment; filename=seckeys.asc

lQG7BEZnyykRBACzCPjIpTYNL7Y2tQ0KpRBk0w5b2XFjS4xeX+2c7sjqjTon
S1IBQ9+qnIdS2S0mZEoXUdxmnvm7KJco8a5RbhT9Hl0TzLaittGi8O1mbzxa
RFdU4TJ3vj0SY2K74IVsNy9FVSACGfBl8K1QblPfbhIxxCNKI2JaDrxXNo1T
4EmqAb8AoOPE436Jdn6EqCWu11LvcgC/LM4PA/0VLE8zRfiPYUkR5ezGDQoU
xigoRj0EOCuAC6Onthjyp0ayJRvQaDLOnaRGNkW3iWly8qEZ8efkYSOa2T59
FsPmo98yooVb5PQ099iViYsknh+zipnwvHvHqIbpfnW75g3CxC4gaMwILcJ4
2LcXuivrnWSQ1gBJtpDU1E6QIg0253ID/Rpqy+hlSg0kBzZw/kh+zpaFcxYt
8xHanZdt8rAo1id55zrS6ydIKiZwqqGwlWTQbK2+vcU5hWFGRecoBvH7Rba6
sU/w4VUFMQ0KO6Ts2VygWGgneQYoHnqzwlUEyjOjlr+lyf7u2s/KAxpKA6jn
ttEdRZAmzWkhuox1wwAUkr27/QAAn3TEzKR1pxxR+R3dHuFpnnfatMIDC5O0
IkMgTyBNaXR0ZXIgPGNvbW1pdHRlckBleGFtcGxlLmNvbT6IXgQTEQIAHgUC
RmfLKQIbAwYLCQgHAwIDFQIDAxYCAQIeAQIXgAANCgkQE7b1Hs3eQw10HQCg
vdn/sDq05G5jxH/rvqgPxr+gcUMAn0NdvCVwotzKTAfLSNipqNebWIJ5nQI9
BEZny04QCADOuXk/U+voINHyZ/kMYbNxRQz48SugDgUt0onllplzurLWWaZb
2+69vrF2KfBzB57Zzl900T6JSMdXbHZL91t8PMlM3/S5qNlzD7Gd/4rFnRGz
iANKztwdccG0Du7xKFh3ge7smCBemLCB9KTKsZCJnIsAdbZyTwfTsajx5Q/x
8sh69r6I+p5hBmj0Fo/P3ZH8np15ul5jWVGS/7JZOrUYTcL+HFt0EC4d/Z24
s/a6r2TChV1/MJGOBXUJCYwhsKsxvu8iXMh73ptvf4qv/40S2YHYjfAcFdzA
kycg6fP1m/3fco2XFJtUXbcEYsH4X0Ps5qcrKZuzsSDXx+ua3+3/AAQNCAC0
YjEbP3jg+fY62F5j0mUFG4gC5WySbbj9nPTd1meToK4Q4gFvkgyDfoYA8pyf
W+wtnRN8TWrneM2lwABeOCeCdGwNCjZm1mglqPD4ZfBpl+Hhnuc80fARxsUP
j+5c8KP2M+Rws4moaZRjVpd3KCi3ceflT/OjwnE9DzdhslCGTMA5n8cajAs2
oqAaQssefVf2prLQLGV9NB4Q3lFnKXdvipHMaAYAsW+iF7JkhTDVNuNGlufe
SqUmigRBjTZXBcVd8sj8vDOCWKUfqxJyS+zRYcotn7QvpvcNCgJHN2RsZ7Qx
wCBi1aemsvr65FeEXp/AYxaG5duUbsugG8PgoJ06bsEAAVQNQO3cXWpuiJ/n
NLLnWuPunBKJUlurkBdf2GD+m+muF0VpwDchhqqbTO4eFqOISQQYEQIACQUC
RmfLTgIbDAANCgkQE7b1Hs3eQw3B7ACg0HKALQ1iRbqVUapXgQns8eENpIQA
nA0Kz78u0Twtv2EL7Zy+ve4fmnzYAg==

--8323584-1253143926-1183314609=:4438--
