From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] Add Travis CI support
Date: Mon, 05 Oct 2015 11:43:42 +0200
Organization: gmx
Message-ID: <a10d494741e1252eb0d55d9120d00a07@dscho.org>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
 <1443981977-64604-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 05 11:43:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj2JE-0006z4-2C
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbbJEJns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:43:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:60776 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbbJEJnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 05:43:46 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mecqq-1ZyOMp2tpo-00OHr8; Mon, 05 Oct 2015 11:43:43
 +0200
In-Reply-To: <1443981977-64604-2-git-send-email-larsxschneider@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Ionv9VS9fwjXxTv9Xk9jN7CELBwKfBLBuNoSxic8q8jkPnB/HpX
 b+dGN6Xrw73XHwrCtciokMmpIm8IobmZmNsbhloVL3zfRtBc2zCX8uvbVf16iLoEldisqFA
 HnF5ZN5YDlZ+DXmt6sY+iJgPfVKGEb+DuiipG3YgHD+xAwyXzm1LQRgSJo/0YFqZlSdTYPJ
 Pw6+Fi5J6WwwucX8H0SlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:799PXih2wvE=:tkl0IcAZ8v/d2wKsZe9PHi
 /AVr+Ox2EkMNca29Rsq9pOGZmbpQlcdVvnsnwzusjoJ5L49MKV//hAO1hLvksAvE0TQzEqLyl
 RV01Ez1PncyIJ29a86OZjqqwp8lR7RZJDMAsBZRiU6KnFi2cLJwRw5QrEl+ajYJikEReV5tQJ
 O9dbtd5WbkDnxxiYuAuF7MinpXn1V91+np42JT7mI7jcPstog0isTPMGEhNlSNHU77cALv5lb
 PuSLAtdd53OHDL1UAMsIlBiYYnOwk7TuDQrYIXp/0dwvSrvfaGwlPcira8pm4ytT97b7kyeXM
 IX6rnMeDA3EKXgwxrnsKN1sl8hAyz27frpKFyvhowAl+7M3iclOMD9gNHCKqGfSUc7EuCDec8
 nlNBR9S+2b/G4VVc1OMeAG2qX0VRInT2RkjLPlaoyfapu+RGgdE5bSvq/GxEiREm0RrB/qL/p
 D9rmZKLbab+EpF82aBsY4JSfm/cgl6+sw6k+6zRLGUzy6InxBDpT8MbCIM71igDT6ZQpTxO6D
 mdz7GI2XgjIGFm5G/ozgSpTt92tsXCjRw6KRj/LhLKmXd76iDbrjETSEHLPEa4B+O7wNgdXJw
 2s3S8i5u2iIppQt4WoZkEGEIuZW1994ajfUEZFSiL9VsGsNSfQatKTDflVTixWAbaP9P9dFG8
 7N1sGySsXSOURXql5citzg8cEA5invS6pZU+cAg6ppnbbMWqKDtHQ/kabO6Z5w3sjUTRwaELA
 xaEaA+WqPYbDD9TbHAj03lfD2ZCcOjhhqhF+nOFdBMNDT/IA56wwBtXihR5NTzLDF12p+ZTx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279054>

Hi Lars,

On 2015-10-04 20:06, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The tests are executed on "Ubuntu 12.04 LTS Server Edition 64 bit" and
> on "OS X Mavericks" using gcc and clang.

I think that the word "currently" is missing from this description, as it is not something this patch controls (but Travis CI's infrastructure).

> Perforce and Git-LFS are installed and therefore available for the
> respective tests.

This is *the* bonus of using Travis CI over BuildHive (which is enabled in Git for Windows' fork of git/git): you can install additional dependencies for more extensive testing. Oh, and it tests with clang and on MacOSX, too, which would reduce the number of fixer-upper patches when git/git introduced yet Another Change That Works Only On Linux.

> +before_script:
> +  - >
> +    if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then

Maybe for readability use

    case "${TRAVIS_OS_NAME:-linux}" in
    linux)
        ...

?

Thanks,
Dscho
