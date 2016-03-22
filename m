From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Tue, 22 Mar 2016 19:30:54 +0100
Message-ID: <56F18F5E.9090301@web.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:32:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiR6N-0005v0-Fn
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbcCVScU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:32:20 -0400
Received: from mout.web.de ([212.227.15.14]:49748 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcCVScS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:32:18 -0400
Received: from macce.local ([93.222.10.132]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LwHmQ-1ZiG1k4BWo-01869q; Tue, 22 Mar 2016 19:32:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:NpnSVQiy8ztRH6AITk7XO0PnLmkNq8eVP2nJSym1znL/+fVIVyZ
 mCDp+1KuQ7soIFXhhvRPD2HqEQ9+8rbhQPz9IUXcbsO/UG+Fa+giRlSlSvIIAlnQ4Z+8/7L
 kZz+MZ7KzxIL/d1BnJWZqIkN8d12CAuEhDcwAJvvx6vHZlUsECWFMxxHYmirdtUVs9pT8qb
 04qKPG9wPh7/Ta0rogtqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kn83jyE4rsQ=:xMDn4p9HY78lD5l0XqrYRE
 wR45FgAgWYK5xRninaZebpMolKM2Zes1bunMMla6TSkUvI668OVo1WLA2Rf/41ikLc8RNbTx8
 aqwpziMxRxDTZEq7a3VgZqNfG4mMLqC2ojfrv0kKSC7EWGuOBg9kB2uoeBd37KAE2W6jVFksG
 ZNlWDOjgM3wUVudosJKWu6lTN11GsficbtHoMxsR5aKeKMy5J+mMn6Dt4wtKLR1ixcRcKZpv8
 EN8FqgunDWgrB5VjZX2JUWiYnpt13gkYVBAnn6DsHFDur0/q6jEhbXHfACwc33R24AfpyMFxT
 ssUc1M6LdFi04waC0SH1c4w0Ue0xrifkNySTIJ0gmTHsMALd57VZVYHIpVjOne/beIk5fMa10
 PZTzJRMU1ObfO76Y0m1+5I0fbUB8AbZp6AS+ixgHLO5Yf5vE4IrCxEEBtX5T06vyApUNxw4X+
 HHqC8DsBNi2DICkYYMDm1Vn6oBkHLPqIJmX82xo7MStV/93ZBPpiFLy3DVzeVjBch5Auw7tR6
 eoigAF4m6D8kY1fL6HE8/lRMNlPMLjP9fCOj7aCW3tuf3pQl/TwdA/hhO02wi4CfrlKewGJBk
 aIUihW+udWSrcMmx40+dxlhCuj380Pzn8FQqsXKprXDKw3hwQt0LgoIMElw/uZInLcheFQ1rp
 CST+ruCYe1yE5tiGyFpjjhnLQkaVgX+LHOUPNiFXAiqIcu16WEWu2kPHc9/ChQEPFUVgCQA6v
 9DbHLn6AXU9EkqDFLCqOjhgbrBRl46IbcZyh5P5ylFVSid/Ehm7jmUWZ1c4+YSXXmXGer7vy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289541>

On 2016-03-22 18.43, Johannes Schindelin wrote:
> These two tests wanted to write file names which are incompatible with
> Windows' file naming rules.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Is there a chance to squeeze in a precondition for HFS under Mac OS ?
> -test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
> +test_expect_success UTF8,!MINGW 'svn.pathnameencoding=cp932 new file on dcommit' '
+test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC

>  	LC_ALL=$a_utf8_locale &&
>  	export LC_ALL &&
>  	neq=$(printf "\201\202") &&
> @@ -105,7 +105,7 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
>  '
>  
>  # See the comment on the above test for setting of LC_ALL.
> -test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
> +test_expect_success !MINGW 'svn.pathnameencoding=cp932 rename on dcommit' '
And the same protection for HFS here.

Question: Why do we need a UTF8 protection in #11, but not in #12 ?



I just tested t9115 under german cygwin, passes.

http://article.gmane.org/gmane.comp.version-control.git/288827
