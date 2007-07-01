From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 01 Jul 2007 20:26:38 +0200
Message-ID: <20070701182637.GL7969MdfPADPa@greensroom.kotnet.org>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site>
 <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
 <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
 <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011903200.4438@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_FXliWAXu+7MwLYl2xwEobQ)"
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 20:26:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I548I-0006cp-Ae
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 20:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbXGAS0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbXGAS0k
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 14:26:40 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:54900 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397AbXGAS0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 14:26:39 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKI00DH2J8ENO@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 01 Jul 2007 20:26:38 +0200 (CEST)
Received: (qmail 17642 invoked by uid 500); Sun, 01 Jul 2007 18:26:38 +0000
In-reply-to: <Pine.LNX.4.64.0707011903200.4438@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51316>


--Boundary_(ID_FXliWAXu+7MwLYl2xwEobQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

On Sun, Jul 01, 2007 at 07:06:43PM +0100, Johannes Schindelin wrote:
> And send me the resulting pubring.gpg and secring.gpg?

Attached.

> If you have a little more time, you could also put them in t/t7004/, and 
> check t7004-tag.sh...

Different...  (assuming I understand your request correctly)

* expecting success: 
        git-tag -s -m "A signed tag message" signed-tag &&
        get_tag_msg signed-tag >actual &&
        git-diff expect actual

gpg: Warning: using insecure memory!
gpg: skipped `C O Mitter <committer@example.com>': secret key not available
gpg: signing failed: secret key not available
failed to sign the tag with GPG.
* FAIL 49: creating a signed tag with -m message should succeed

                git-tag -s -m "A signed tag message" signed-tag &&
                get_tag_msg signed-tag >actual &&
                git-diff expect actual

bash-3.00$ git diff
diff --git a/t/t7004/pubring.gpg b/t/t7004/pubring.gpg
index 83855fa..20e89c6 100644
Binary files a/t/t7004/pubring.gpg and b/t/t7004/pubring.gpg differ
diff --git a/t/t7004/secring.gpg b/t/t7004/secring.gpg
index d831cd9..e69de29 100644
Binary files a/t/t7004/secring.gpg and b/t/t7004/secring.gpg differ

skimo

--Boundary_(ID_FXliWAXu+7MwLYl2xwEobQ)
Content-type: application/octet-stream; NAME=pubring.gpg
Content-transfer-encoding: base64
Content-disposition: attachment; filename=pubring.gpg

mQGiBEZnyykRBACzCPjIpTYNL7Y2tQqlEGTTDlvZcWNLjF5f7ZzuyOqNOidLUgFD36qch1LZ
LSZkShdR3Gae+bsolyjxrlFuFP0eXRPMtqK20aLw7WZvPFpEV1ThMne+PRJjYrvghWw3L0VV
IAIZ8GXwrVBuU99uEjHEI0ojYloOvFc2jVPgSaoBvwCg48Tjfol2foSoJa7XUu9yAL8szg8D
/RUsTzNF+I9hSRHl7MYKFMYoKEY9BDgrgAujp7YY8qdGsiUb0Ggyzp2kRjZFt4lpcvKhGfHn
5GEjmtk+fRbD5qPfMqKFW+T0NPfYlYmLJJ4fs4qZ8Lx7x6iG6X51u+YNwsQuIGjMCC3CeNi3
F7or651kkNYASbaQ1NROkCINNudyA/0aasvoZUoNJAc2cP5Ifs6WhXMWLfMR2p2XbfKwKNYn
eec60usnSComcKqhsJVk0Gytvr3FOYVhRkXnKAbx+0W2urFP8OFVBTEKO6Ts2VygWGgneQYo
HnqzwlUEyjOjlr+lyf7u2s/KAxpKA6jnttEdRZAmzWkhuox1wwAUkr27/bQiQyBPIE1pdHRl
ciA8Y29tbWl0dGVyQGV4YW1wbGUuY29tPohmBBMRAgAeBQJGZ8spAhsDBgsJCAcDAgMVAgMD
FgIBAh4BAheAABIJEBO29R7N3kMNB2VHUEcAAQF0HQCfSemJWbmnUehCMpXg+sc9uulvRqEA
oL/clsbCXW+zRZ2eju9j4oEoNpRguQINBEZny04QCADOuXk/U+voINHyZ/kMYbNxRQz48Sug
DgUt0onllplzurLWWaZb2+69vrF2KfBzB57Zzl900T6JSMdXbHZL91t8PMlM3/S5qNlzD7Gd
/4rFnRGziANKztwdccG0Du7xKFh3ge7smCBemLCB9KTKsZCJnIsAdbZyTwfTsajx5Q/x8sh6
9r6I+p5hBmj0Fo/P3ZH8np15ul5jWVGS/7JZOrUYTcL+HFt0EC4d/Z24s/a6r2TChV1/MJGO
BXUJCYwhsKsxvu8iXMh73ptvf4qv/40S2YHYjfAcFdzAkycg6fP1m/3fco2XFJtUXbcEYsH4
X0Ps5qcrKZuzsSDXx+ua3+3/AAQNCAC0YjEbP3jg+fY62F5j0mUFG4gC5WySbbj9nPTd1meT
oK4Q4gFvkgyDfoYA8pyfW+wtnRN8TWrneM2lwABeOCeCdGwKNmbWaCWo8Phl8GmX4eGe5zzR
8BHGxQ+P7lzwo/Yz5HCziahplGNWl3coKLdx5+VP86PCcT0PN2GyUIZMwDmfxxqMCzaioBpC
yx59V/amstAsZX00HhDeUWcpd2+KkcxoBgCxb6IXsmSFMNU240aW595KpSaKBEGNNlcFxV3y
yPy8M4JYpR+rEnJL7NFhyi2ftC+m9woCRzdkbGe0McAgYtWnprL6+uRXhF6fwGMWhuXblG7L
oBvD4KCdOm7BiFEEGBECAAkFAkZny04CGwwAEgkQE7b1Hs3eQw0HZUdQRwABAcHsAKCaGf8i
Vkqwl19PAP6vCkl+GX6AQwCdGMXovwxyvZuZV3NjD5DKCoJaSCs=

--Boundary_(ID_FXliWAXu+7MwLYl2xwEobQ)
Content-type: text/plain; charset=us-ascii; NAME=secring.gpg
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=secring.gpg


--Boundary_(ID_FXliWAXu+7MwLYl2xwEobQ)--
