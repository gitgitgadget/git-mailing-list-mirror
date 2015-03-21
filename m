From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t6039: fix broken && chain
Date: Sat, 21 Mar 2015 08:19:20 +0100
Message-ID: <550D1B78.5090703@web.de>
References: <550D1811.3040802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 08:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZDhE-0001Tb-8y
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 08:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbbCUHTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 03:19:24 -0400
Received: from mout.web.de ([212.227.17.11]:56298 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbbCUHTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 03:19:24 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MhDgb-1Yuzf62uAL-00MH4b; Sat, 21 Mar 2015 08:19:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <550D1811.3040802@web.de>
X-Provags-ID: V03:K0:7EsclzOgh+sHjSfE6HG9uB7EV0Wh+lFHqa+exFLaDybG/RtQ7Af
 hRleB4jWzJYhUFQZPLoc9+Zt6xuwThugkFkWMpEu7fTdobJ5dRbuPV0yFqhmCzQylriXol9
 HzKdaEyutBXPXDbHWliQImqwzAarHdjutNp3IDPaGEuGnmSVC0tOI9HIlDsrk6omXHYMGID
 JvlufuSvMA3Q3RWrSfLrg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266013>

On 2015-03-21 08.04, Torsten B=F6gershausen wrote:
> Add missing %%, detected by the --chain-lint option
Oh, early morning typo, should be
Add missing &&, detected by the --chain-lint option

(I'll re-run the testsuite with the  --chain-lint in a minute,
 thanks everybody for this nice feature)
