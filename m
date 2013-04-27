From: Johannes Schneider <mailings@cedarsoft.com>
Subject: Making a (quick) commit to another branch
Date: Sat, 27 Apr 2013 16:06:37 +0200
Message-ID: <517BDB6D.8040809@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 16:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW5tC-0006av-2M
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 16:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab3D0ONz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 10:13:55 -0400
Received: from hosting.cedarsoft.com ([176.9.39.58]:44000 "EHLO
	mail.cedarsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3D0ONy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 10:13:54 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Apr 2013 10:13:54 EDT
Received: from [192.168.0.81] (HSI-KBW-149-172-123-74.hsi13.kabel-badenwuerttemberg.de [149.172.123.74])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cedarsoft.com (Postfix) with ESMTPSA id D98421E0349
	for <git@vger.kernel.org>; Sat, 27 Apr 2013 16:06:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222651>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi guys,

I love git. And I use it every day. But there is one minor thing, that
bugs me a little bit:
I am implementing something on a feature branch. Now I detect a minor
typo/bug/whatever that just needs a one line commit.

But of course I don't want to add that commit to my feature branch.
Instead I'd like to commit that fix directly to another branch (e.g.
master).

Unfortunately that take a lot of steps to make this happen:
- - comitting
- - stashing other changes
- - changing branch
- - cherry-picking commit
- - switching branches back
- - reverting latest commit
- - unstashing changes

I'd love to solve this by having an option for git commit that gives
me the possibility to commit to another branch:


git commit thefixedfile.txt -m "fixed a typo" -b master



Any ideas/hints?


Thanks,

Johannes

- -- 
Johannes Schneider - blog.cedarsoft.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJRe9ttAAoJEAytD9R7Qv6dPakH/2WshAEXM9JW2+OFW/9ZxEeL
IQuE4U1OiIH9BRT9XixHQ0+d+Nay/510nFJw0kLLtOl3wRx1ybMvaennYp17Aqi6
yVnDuYbhIsjQD5lFAueLsfDgZdawmWMEOMf/Sk5pX5GLjo9k9+mi/J3KDCqH89Dc
FofgMVsZcXtFB7WS9YzzabOhfomIWhY48R8CblSatzB/r5R4xsTk6eryAgBZvaIz
d2Rh9a54OVRBGeGX3mdgIgVWRHbquU+b1h4Lm8QraTfNGy4uN0hRtzFb356j7xq9
UlA3CqW+w6lyBK14fdQ232jgRTkAPfgms0IShtD9UgBV0o+RBTe1Oa9abZ7sskY=
=J4Dg
-----END PGP SIGNATURE-----
