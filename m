From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:13:33 -0700
Message-ID: <615C1C6F-4FE0-4A83-8DE6-837386D88A15@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <CAK3OfOipw+Tg4PF5HAr8tb204vt17EVn46Lm9VMuHW1299yP8A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:14:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDL5K-0003A8-Hr
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbaHAWNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 18:13:48 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:53090 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756456AbaHAWNr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:13:47 -0400
Received: from omta12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Za5h1o0070x6nqcA1aDnoL; Fri, 01 Aug 2014 22:13:47 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta12.emeryville.ca.mail.comcast.net with comcast
	id ZaDm1o00G2ztT3H8YaDmsb; Fri, 01 Aug 2014 22:13:46 +0000
In-Reply-To: <CAK3OfOipw+Tg4PF5HAr8tb204vt17EVn46Lm9VMuHW1299yP8A@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406931227;
	bh=msn53lUkNyVJsUPl3SUj6vsGuW6K1MxkfsJz2VGy/Ls=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=ZCwgvnLy+rvaBcEgSpfvOyeRBAhN8XjThKLucmI1mfIE/gIkqaKDCNiwqtkIxXBIK
	 7rzY1KY/uS6S17YH/8FpbJRt1OcZ7O8qf8G/5JprLPz1+qieZREbQfbmlJZeeLSrIj
	 PC65ldnLKBp7B6yoJh+shsR8rk83oSe+Gjz4rBRDSBBGdDk/FXJqIPe1vkr/zF1Cma
	 HdhYfC473OZkW17GgH1ENWY0lUiYa5mTH/bfsIj486XI9avyMWhYj9NB+92wHIAiQn
	 TH+rCm1AUbgut7exZ9x5KjUCJHwu1e+T91gHLx74z9yEr/kjT8vrJ4kJV7sf2lVoeP
	 Dsfc7wAuChLmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254671>

On Aug 1, 2014, at 12:22 PM, Nico Williams <nico@cryptonector.com> wrot=
e:
> If you always rebase

I can=92t use rebase unless you make rebase work with multiple users an=
d pushing pulling.