From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v2] utf8.c: partially update to version 6.3
Date: Thu, 17 Apr 2014 15:14:25 +0300
Message-ID: <534FC5A1.3000205@bracey.fi>
References: <201404171347.47528.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 14:14:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WalDC-0006zG-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 14:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbaDQMOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 08:14:33 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:43474 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161024AbaDQMOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 08:14:32 -0400
Received: from mail605.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 2B0B3100C2AE
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 14:14:28 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 17 Apr 2014 14:19:45 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 17 Apr 2014 14:19:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <201404171347.47528.tboegi@web.de>
X-Ovh-Tracer-Id: 14330172541454356624
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtdefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500002/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtdefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246417>

On 17/04/2014 14:47, Torsten B=C3=B6gershausen wrote:
> ./uniset/uniset +cat=3DMe +cat=3DMn +cat=3DCf -00AD +1160-11FF +200B =
c

200B isn't a special case any more, as its database properties have bee=
n=20
changed, so you can slightly simplify this command (both in the commit=20
message and the comments).

And while you're here I think it's probably worth updating the width=3D=
2=20
test now too, to make this a complete update to Unicode 6.3. I can see=20
it needs a few extensions (eg A960-A97C, FE10-FE19, 1F200-1F251).

Kevin
