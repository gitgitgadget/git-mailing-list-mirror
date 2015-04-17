From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2]  t0027: Support =?UTF-8?Q?NATIVE=5FCRLF?=
Date: Fri, 17 Apr 2015 21:55:24 +0200
Organization: gmx
Message-ID: <1db9b0b7322c3b8b8e7a76b29b020ad8@www.dscho.org>
References: <55312A45.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjCMO-0005ZO-7h
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbDQTz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 15:55:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:54948 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbbDQTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 15:55:26 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MNuwp-1YhIgR2tcR-007QVP; Fri, 17 Apr 2015 21:55:24
 +0200
In-Reply-To: <55312A45.8060008@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:iZxyNEw91+EgyJNXYOCdbfyT7fjnCYWIegotq54B3cMvslXpU2h
 at+nEWJ5f1xeyqBGzXecctdfNEifqiqxPaQQe2XtXxDaW1TPmu5NulhCAk5vR3itldVvs2g
 nveu2bVQud7iAmORPFVOcJGMsktvJJYptkhSpkaCta80DwoD2d5KalVLZDlRtGmAf1jqeTV
 H5M0afyVzvZj893b/oSwg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267383>

Hi Torsten,

On 2015-04-17 17:44, Torsten B=C3=B6gershausen wrote:
> Without this patch, t0027 expects the native end-of-lines to be a sin=
gle
> line feed character. On Windows, however, we set it to a carriage ret=
urn
> character followed by a line feed character. Thus, we have to modify
> t0027 to expect different warnings depending on the end-of-line marke=
rs.
>=20
> Adjust the check of the warnings and use these macros:
>   WILC:  Warn if LF becomes CRLF
>   WICL:  Warn if CRLF becomes LF
>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>=20
> Improve the information given by check_warning():
> Use test_cmp to show which warning is missing (or should'n t be there=
)
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Thank you so much!
Dscho
