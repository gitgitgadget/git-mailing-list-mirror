From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL
 for a given path
Date: Sun, 24 Jan 2016 11:41:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241140190.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de> <56A319B9.50900@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-587303583-1453632081=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:41:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNI6t-0001XA-JO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbcAXKl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:41:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:59110 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbcAXKl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:41:27 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MA9Yv-1aGvOa36HB-00BH7j; Sun, 24 Jan 2016 11:41:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A319B9.50900@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HM063/Vzzc42eWAvpwi1CgCZQw3ARaSmwk/11wmuht7z+3AyzdA
 UlXllFTryM/KtwYFxG0iWUvVTsqo8tSveZMSWmJq/hUHwk+pjCA4TMaDO75DOFBadHI6BFQ
 65/hsk6K9yv0ruoAfEuNPptBgGbbpiXdrsrkI3GkTYCoVTFW0uwzUZUDypyUG0BPxF7FFdx
 xDHVDS9n0GH7rjx614KdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CoRS40kD4FA=:rGWfaK9aOPqe/yW/ThSdfc
 MQTJLCmGG2Yg3Juu7VFDso9kninvpjhb+FHapmwGFStNi3N7+CF6QEg/VfFfwIFYgJU67UI+d
 +26ZEcmG8R9dzomYORk43GZtcvqZlxLQx+Q3+JC+OFh+v2YJ/d1JSndE5kU6gt973HuWEOC3C
 zZ8VhirFeI6J4oYGD/705HTWLGiu2teZnkOvb4xPXA+jKoTy+FBpAV6A1dazT/CRTEwZNaXim
 1ZKetUeqBI3wZKk57psswZlDdi6BpgR/14qX2KIi0uItOB69zBZQWujku87/fz3RMyNWWEgUJ
 QaDtM86uHI3rU6tDsTH+ghyQ7eu3LMMEJHvHcJ7Zktv6V3bgRrUpnd8+K6qYICIMip6pIBu7t
 dvTz+Q7c1NQtLDFKgdtP1ok8uQvDHBZxBTHuyI8lF/EuvN9znW83im9302ojMQWtkAPuivDfv
 +8lekuyOZQylvvLLrLghxkgpcZoLO/4m6ZR67tdF+2S7kRkxzc6o0w/5D+SQNELN0YIguIxMA
 pHRfg5zfe9ODiWvI/NTHvHW2id5RhxfFqssl7CzFcTJ3UIlOAglqhcoTJxzreOOC57FPcV9wW
 Q2kjHeVHuTLZ4VreqYYkSuk601AZGBttGHTk4hHwWzr5g/41f6Z5UqqMZw0goiW/6cluUbbaZ
 d3W1eGMop4RuJ/8AyDQpWm9S9Nh/UQMXnRiPxli3fohmvSek7oRZgin3k1RKjdvj1UYHVpADU
 OkdpOMrtzYpdO40o4Ro7HfgIb7gTiEkw+P1PtdhF5ELo9UJ/f4Q3wyyGmuQY+sFay+sWj+eD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284640>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-587303583-1453632081=:2964
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Sat, 23 Jan 2016, Torsten B=F6gershausen wrote:

> When path is NULL, can we set it to "*" to catch .gitattributes like
> "* text=3Dauto"
> ?

The point of that part of the patch was to make things *independent* of
the gitattributes because we operate not on working files, but on blob
contents.

In any case, this point will be moot with the upcoming iteration of the
patch.

Ciao,
Dscho
--8323329-587303583-1453632081=:2964--
