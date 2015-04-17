From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 2/2]  t0027: Support NATIVE_CRLF
Date: Fri, 17 Apr 2015 19:00:44 +0200
Message-ID: <55313C3C.1090504@web.de>
References: <55312A45.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johannes.schindelin@gmx.de
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 19:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj9dN-0004xH-7I
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 19:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbbDQRAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 13:00:48 -0400
Received: from mout.web.de ([212.227.15.3]:59970 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbbDQRAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 13:00:47 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M2unu-1Zbo1D1xiw-00sgsK; Fri, 17 Apr 2015 19:00:45
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55312A45.8060008@web.de>
X-Provags-ID: V03:K0:EwYcqRFogsCLRf9jpr/znuFb1KnJ/5s5cZvGN0TtIikV987Pbph
 VLPDt4ZlWDswLovH+xG5Uol3VXvAAppXnzsxHodzt/BXCpE/ZUhNDPvrJFEdgkmIcs9Li7T
 XChJ0qPyb7B0HC6bLQTrJXKB0HDwpkfY+dHGzc/g1t9AG1edgZlAu3VVEuxkZUS/E4e3jSd
 xNDfFqkBiUoZOIhYreb1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267366>

On 2015-04-17 17.44, Torsten B=C3=B6gershausen wrote:
> Without this patch, t0027 expects the native end-of-lines to be a sin=
gle
> line feed character. On Windows, however, we set it to a carriage ret=
urn
> character followed by a line feed character. Thus, we have to modify
> t0027 to expect different warnings depending on the end-of-line marke=
rs.
>
> Adjust the check of the warnings and use these macros:
>   WILC:  Warn if LF becomes CRLF
>   WICL:  Warn if CRLF becomes LF
>   WAMIX: Mixed line endings: either CRLF->LF or LF->CRLF
>
> Improve the information given by check_warning():
> Use test_cmp to show which warning is missing (or should'n t be there=
)
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Originally I wanted to have Dscho as "Author", is that OK with you ?
(But the "From:" line didn't made it through my email program)
=20
