From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 01 Jul 2007 21:10:18 +0200
Message-ID: <20070701191018.GM7969MdfPADPa@greensroom.kotnet.org>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site>
 <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
 <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
 <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011903200.4438@racer.site>
 <20070701182637.GL7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011929200.4438@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Fn/gObBVOljHabkjqUaiNA)"
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 21:10:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I54oT-0004qI-R9
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbXGATKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 15:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbXGATKV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 15:10:21 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:33764 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755447AbXGATKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 15:10:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKI002HPL969T@smtp17.wxs.nl> for git@vger.kernel.org; Sun,
 01 Jul 2007 21:10:18 +0200 (CEST)
Received: (qmail 18779 invoked by uid 500); Sun, 01 Jul 2007 19:10:18 +0000
In-reply-to: <Pine.LNX.4.64.0707011929200.4438@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51319>


--Boundary_(ID_Fn/gObBVOljHabkjqUaiNA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

On Sun, Jul 01, 2007 at 07:30:09PM +0100, Johannes Schindelin wrote:
> Aargh! I am a complete moron. Attached also the private key now.

Ok... some progress...

* expecting success: git-tag -v signed-tag
object 86e17e4ed4cddf9a4f960da789f8378f6ea1ff2b
type commit
tag signed-tag
tagger C O Mitter <committer@example.com> Thu Apr 7 15:13:13 2005 -0700

A signed tag message
gpg: Warning: using insecure memory!
gpg: Signature made Sun Jul  1 19:08:37 2007 UTC using DSA key ID CDDE430D
gpg: Good signature from "C O Mitter <committer@example.com>"
gpg: NOTE: secret key CDDE430D is NOT protected.
gpg: /home/skimo/src/git/t/trash/gpghome/trustdb.gpg: invalid file version 3
gpg: fatal: /home/skimo/src/git/t/trash/gpghome/trustdb.gpg: invalid trustdb
secmem usage: 1408/1408 bytes in 2/2 blocks of pool 1408/16384
* FAIL 50: verifying a signed tag should succeed
        git-tag -v signed-tag

skimo

--Boundary_(ID_Fn/gObBVOljHabkjqUaiNA)
Content-type: application/octet-stream; NAME=secring.gpg
Content-transfer-encoding: base64
Content-disposition: attachment; filename=secring.gpg

lQG7BEZnyykRBACzCPjIpTYNL7Y2tQqlEGTTDlvZcWNLjF5f7ZzuyOqNOidLUgFD36qch1LZ
LSZkShdR3Gae+bsolyjxrlFuFP0eXRPMtqK20aLw7WZvPFpEV1ThMne+PRJjYrvghWw3L0VV
IAIZ8GXwrVBuU99uEjHEI0ojYloOvFc2jVPgSaoBvwCg48Tjfol2foSoJa7XUu9yAL8szg8D
/RUsTzNF+I9hSRHl7MYKFMYoKEY9BDgrgAujp7YY8qdGsiUb0Ggyzp2kRjZFt4lpcvKhGfHn
5GEjmtk+fRbD5qPfMqKFW+T0NPfYlYmLJJ4fs4qZ8Lx7x6iG6X51u+YNwsQuIGjMCC3CeNi3
F7or651kkNYASbaQ1NROkCINNudyA/0aasvoZUoNJAc2cP5Ifs6WhXMWLfMR2p2XbfKwKNYn
eec60usnSComcKqhsJVk0Gytvr3FOYVhRkXnKAbx+0W2urFP8OFVBTEKO6Ts2VygWGgneQYo
HnqzwlUEyjOjlr+lyf7u2s/KAxpKA6jnttEdRZAmzWkhuox1wwAUkr27/QAAn3TEzKR1pxxR
+R3dHuFpnnfatMIDC5O0IkMgTyBNaXR0ZXIgPGNvbW1pdHRlckBleGFtcGxlLmNvbT6IXgQT
EQIAHgUCRmfLKQIbAwYLCQgHAwIDFQIDAxYCAQIeAQIXgAAKCRATtvUezd5DDXQdAKC92f+w
OrTkbmPEf+u+qA/Gv6BxQwCfQ128JXCi3MpMB8tI2Kmo15tYgnmdAj0ERmfLThAIAM65eT9T
6+gg0fJn+Qxhs3FFDPjxK6AOBS3SieWWmXO6stZZplvb7r2+sXYp8HMHntnOX3TRPolIx1ds
dkv3W3w8yUzf9Lmo2XMPsZ3/isWdEbOIA0rO3B1xwbQO7vEoWHeB7uyYIF6YsIH0pMqxkImc
iwB1tnJPB9OxqPHlD/HyyHr2voj6nmEGaPQWj8/dkfyenXm6XmNZUZL/slk6tRhNwv4cW3QQ
Lh39nbiz9rqvZMKFXX8wkY4FdQkJjCGwqzG+7yJcyHvem29/iq//jRLZgdiN8BwV3MCTJyDp
8/Wb/d9yjZcUm1RdtwRiwfhfQ+zmpyspm7OxINfH65rf7f8ABA0IALRiMRs/eOD59jrYXmPS
ZQUbiALlbJJtuP2c9N3WZ5OgrhDiAW+SDIN+hgDynJ9b7C2dE3xNaud4zaXAAF44J4J0bAo2
ZtZoJajw+GXwaZfh4Z7nPNHwEcbFD4/uXPCj9jPkcLOJqGmUY1aXdygot3Hn5U/zo8JxPQ83
YbJQhkzAOZ/HGowLNqKgGkLLHn1X9qay0CxlfTQeEN5RZyl3b4qRzGgGALFvoheyZIUw1Tbj
Rpbn3kqlJooEQY02VwXFXfLI/LwzglilH6sSckvs0WHKLZ+0L6b3CgJHN2RsZ7QxwCBi1aem
svr65FeEXp/AYxaG5duUbsugG8PgoJ06bsEAAVQNQO3cXWpuiJ/nNLLnWuPunBKJUlurkBdf
2GD+m+muF0VpwDchhqqbTO4eFqOISQQYEQIACQUCRmfLTgIbDAAKCRATtvUezd5DDcHsAKDQ
coAtDWJFupVRqleBCezx4Q2khACcCs+/LtE8Lb9hC+2cvr3uH5p82AI=

--Boundary_(ID_Fn/gObBVOljHabkjqUaiNA)--
