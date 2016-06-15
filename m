From: =?utf-8?Q?Wojciech_Rybi=C5=84ski?= <w.rybinski@webankieta.pl>
Subject: Git clone 2.9.0
Date: Wed, 15 Jun 2016 15:08:25 +0200
Message-ID: <0698E1D6-F967-465B-A30E-07889C28D38B@webankieta.pl>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 15:16:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDAgb-0004l4-H3
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 15:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbcFONQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 09:16:45 -0400
Received: from poczta.ankietka.pl ([213.222.209.190]:58730 "EHLO ankietka.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751903AbcFONQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 09:16:45 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jun 2016 09:16:44 EDT
Received: from [10.10.10.104] (unknown [194.181.83.194])
	by ankietka.pl (Postfix) with ESMTPSA id 474C658042C
	for <git@vger.kernel.org>; Wed, 15 Jun 2016 15:08:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 ankietka.pl 474C658042C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtp.webankieta.pl;
	s=default; t=1465996106;
	bh=kzjx0/CFpanOADXgDCdPEHJruXcVcjfVcgz8FAdAcXQ=;
	h=From:Subject:Date:To;
	b=pSw+oSO67GNiydb7qEK9/T65k5hWggdT/FnjCWtume47PlPKuc6YlXz2QzkLk5aHo
	 U2Cdx+cYYRFGRlBkx8ZzrumrbBivhLpMf3BD5IjVhTUfQuSfBKc9Fzjc/MPKzSsHxq
	 hTKnT+UVgBwq/oy2e5H+hRJ9F/0VHIRWo17I0EUw=
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297370>

Hi,

I have installed version 2.9.0 and when I=E2=80=99m trying to clone rep=
o with specific tag I get error: unknown option `single-branch=E2=80=99=
 and next warning: Remote branch a3.0.26 not found in upstream origin, =
using HEAD instead. My command looks like that: git clone --single-bran=
ch -b a3.0.26 git@=E2=80=A6 and it=E2=80=99s working with git version 2=
=2E7.4 on another machine. What should I do to clone repo with this tag=
 using version 2.9.0? I found info that this option is enable in this v=
ersion.

Best,
Wojciech Rybi=C5=84ski