From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 15:39:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251530480.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
 <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>
 <Pine.LNX.4.58.0504251505260.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:34:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQC98-0002sS-ET
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDYWiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDYWiN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:38:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:36805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbVDYWhn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:37:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PMbVs4007541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 15:37:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PMbTcd011459;
	Mon, 25 Apr 2005 15:37:30 -0700
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504251505260.18901@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Linus Torvalds wrote:
> 
> So I'll probably just push out my tags with my archives, and then people
> can verify them if they want to.

Ok, for the intrepid users, you can now test to see if you can pick them 
out. fsck should make them totally obvious, and here's my public key in 
case you also want to verify the things.

Of course, since I normally don't use pgp signing etc, it's entirely 
possible that I've done something stupid, and I'm now sending you my 
secret key and my full porn-collection.

		Linus

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.4 (GNU/Linux)

mQGiBEJqZ4sRBADKttqQOCAxRzz5qGmo5QnSR5GTkSlPTm4lCuaVUon0qQPNrasr
cSBAOJ1MlXjhbRPrN3pAhI+taLgrWQ231zUNHxCTmWJZV3Yzxr8xJQGlfHlVOxXB
LI42tAfCjHOF7z8pPj6AGhtE2+fzq1U3mOlA/fUG4uYDOwIoPK+qgbM6SwCgulqs
DGlQKFFtFgW8HVnDftFmyZMD+wc0E9jRa9HJ3b1U3vY1jrxpoVw5QeeIZdSRnRFy
sknOHca5mlJvTidu1cs7xCuvpufw1VIVvgf4tPwXcTDEKthYEhoty+DFOqZ9R7pg
EMhjYbq+Q8yLT3OWQtUKV4B10FRYIWidnJ8y2CjLduTmB+cyj976oxEY/llLBbQM
yuDrBADDLw/3KZL5D75icA0l/uebQ6/73j8jcRoVu0gTqAdQBYL6Zv7Y0G7xHUCo
Eqgo+p2LXAeU9IoeA5/h8SNVDw4fYoqo6VQTkr+ydegHkjwlbrhOL/gxzlY1Pde1
TBi6+QCUssk0FCPMALt7M+OgFpSKx7pP2xSsDsMvvNNAmLl0JrQ0TGludXMgVG9y
dmFsZHMgKHRhZyBzaWduaW5nIGtleSkgPHRvcnZhbGRzQG9zZGwub3JnPoheBBMR
AgAeBQJCameLAhsDBgsJCAcDAgMVAgMDFgIBAh4BAheAAAoJEBd2LEZ24hy7I84A
nROHRYes4RU8btdleR0TgwJG7jMvAKCF2CingjxaC4sTL7BkFfNacTkBYLkBDQRC
ameMEAQAlJiw0IBltu5ihEXE4mFYiWHuVAoeufVJ9fONv67y6fu3efJ10PJ7AQdG
Ufez+8yxkrahyIVC77NuQLDrRfvgmrJ8sbP8xb6QEbY1bnwLeuciTolGjL+kYi17
J74iG2cQDyimnLWJm5lNqeUOz3nTW429SyLCRhXpR1lUjijiVi8AAwcD/1f4VEql
u9HHTA4S+1aoOQV5guZCr6JbYdWkAZeeFRpFSXfCae6uO8DhpD7o/8kiK3O8qP1O
yjQF0bG26iLCm8MdJCO0WQ2xsVlwrrvnNPpgRgbirOgoxHM4ESq/YV+MqXo41Hm0
ilHRM7OIbmm7uvFSlUJmUasuJRsrhibilbvNiEkEGBECAAkFAkJqZ4wCGwwACgkQ
F3YsRnbiHLsolQCfRVImDkgijhPGmwyI7T19bWltXwsAniMi9gakkN+9DT8E5kli
e8uTEk8f
=PRrZ
-----END PGP PUBLIC KEY BLOCK-----

