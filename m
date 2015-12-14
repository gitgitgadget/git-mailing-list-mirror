From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 3/3] format-patch: check that header line has expected
 format
Date: Mon, 14 Dec 2015 08:16:47 +0100
Message-ID: <566E6CDF.3020004@web.de>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
 <1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 08:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8NOI-0007vq-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 08:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbbLNHRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 02:17:44 -0500
Received: from mout.web.de ([212.227.17.12]:60172 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbbLNHRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 02:17:41 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MBCJd-1ZyiKL3PSH-00ABT8; Mon, 14 Dec 2015 08:16:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1450027638-788102-4-git-send-email-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K0:iIvJo5IlDElXX/pFvRZJpN5k4pIzEHWRMQtTaVfffI45X/A3zi8
 BEP2wU/pvSeuMEWMtyJ8bTri0pyNAGxmxTNuV+0VXN448n9JnPCC1prKbb7vt6lFtEcUwGK
 CNC4g8hLY2M/RfYJMXn9oPjfzz+bBdYhCo9wE4oLIKTUgMveoPzyzIz6Me/YiAo1s9cQscj
 GvCkLvCkpkJ+RtdDp1m4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fY9GeuxUJL8=:V70yqYQe2buPKB//aKaMVX
 m9leL+nyM0uRbbrC+Km5c4zsciVldl2FYjAwK6bjJaQ6vlv1+QST/gu/jzOy+8pKcwZB4Vt3x
 98BQiyKtr8lAYsGDLsj4sdHwZa/wP4i+3V7if+uJ5blWvPPVNn//rzS+46knf8tjCKg6RZa4Q
 vSzRFSt5uoua/MLxfnP2j7DsThThXzN1XjPb5/T7IAholfXHQSbeQzIIK5PrJ+J7RtfryvQmx
 dl8hCssVBM3AI9AgDa2k6NtmfIHw6N35fE245xyOg2VYhyVaCVG17wHGjgVqRWNrC0WsiswJX
 EXlrCGT8i6i1Cg6mLY/cgdhT4HoZE6OQa3BgrQ5W2WJKWAoDgddqITWb79yO2gQE+Zwm7PAbm
 POhyyV4LIsrmxvSLiWUwaWY0BWvknmp2UC+xYlsOLirD5Ej7I6doIxCVIeIXJkSn71zu+sEuo
 EuCclco3+lRjWFM7gqasLjW8dXb3IQrpkYur99oexuLye2AkWqV/G0M7I7E1VDvRsqwHG78+g
 yyLydZuu7ZM0AdK/Fkx/pa6tA2N+ty282qiy/AgQPnc27JgoXhWEVo9pYH9uagO7z/M5kmpbH
 slESrDRzU69fxuEXQvHFZ4RnYhhWCPFqTfSniMP8/OnEWoGpLT1IyLR77OOQes5bEYpNQ/4Yz
 o36xHZsyYPksEPudgPQhE6VhhyqtWEFZAk5Sw6gFugBBtWiLQ5wJ4a7pvOSOgZVfBWH/9uPeH
 x4ht9ruWRuvqGu1hpQQhw+vgkGKlAnimGOt7Qz9xKxocf/rgz0ncH4RtffFrIkkIwvxbva3B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282353>

On 13.12.15 18:27, brian m. carlson wrote:
> The format of the "From " header line is very specific to allow
> utilities to detect Git-style patches.  Add a test that the patches
> created are in the expected format.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t4014-format-patch.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b740e3da..362bc228 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1437,4 +1437,10 @@ test_expect_success 'format-patch --zero-commit' '
>  	test $cnt = 3
>  '
>  
> +test_expect_success 'From line has expected format' '
> +	git format-patch --stdout v2..v1 >patch2 &&
> +	cnt=$(egrep "^From [0-9a-f]{40} Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&
> +	test $cnt = 3

For these kind of things:
test_line_count() is your friend
