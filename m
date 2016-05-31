From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t7800 readlink not found
Date: Tue, 31 May 2016 07:06:50 +0200
Message-ID: <574D1BEA.5020409@web.de>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
 <vpqk2ijs8p2.fsf@anie.imag.fr> <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
 <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
 <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
 <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
 <20160527041944.GA17438@gmail.com> <574CDA24.1020906@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 07:08:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7buL-0002OV-72
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 07:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbcEaFH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 01:07:56 -0400
Received: from mout.web.de ([212.227.17.11]:51129 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbcEaFHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 01:07:55 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MbyIM-1apWoc3nuA-00JKJU; Tue, 31 May 2016 07:07:25
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <574CDA24.1020906@googlemail.com>
X-Provags-ID: V03:K0:WcHJXeynGxHCiqzLenT8WV6LtJ4SntD3pEVu9QzsWohNbobryQs
 Y/KTQJgcT/NmcROJuEoG575aW2O0kjtrTfUIOWq/OcTMM7Ny3g81q7hpNZeO+Tf3ab7TSbM
 vEXDVuOMKMVSgsTfMia6phDC/TULvb/TbymXU89oXUteIVq5XTPtDy2EhNbNzKMDQYAbRYC
 yN8WMEAZ5hmNGR+1cxzcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6VLHZYFwr1Q=:Q/MDO+U+xjoz068giSsjRw
 EUnmEr5l3B9/jxSjzOg7GEIfpNTUA1AjOIAL2UuMBYZgavu53AHxPg6CDzvGTBjBFg2ghjqyI
 AvayUpTXWtd9JhLlyA4GV3E4DMUBpmzAyA141CV/DH4YQl55W9SKGkcPgwgGYfEvJjkKWzP5+
 uPZUJNQmQHUJOkfBwUiTjxDg2r/ELyP2I2SCmxxrJ0T1t/eLT871DBx0bEv3c3fG0RD6Ciy/A
 zV6ZDSEtebzYvF9B9FPNG4UmVi1GJdeWh4emY0/DbMvEq3+WYkLgUmO305CxwPidLg5984qMO
 IxHqtIIP3WWe0zCMQgsaGwtD2Y4Yzfxe1EKS5+9LpEv2720kByQHxktX4lqH8cJ56X2o/3UYQ
 Ci1HhDfapSnH++lb11kN+LHp52CWC3UqGmVqjxI9yXIb71tQMY21Jf5g4L1oCLfdD1MeYYuiE
 LvWA1K6YexVHYL3a+ByFQCoD+N3Er67AoVLnJ/aKysWrAPEskTd+YtNlz8Gf0MLTm+Rn0dInD
 QrTtaxbySwzSYNP3duobcNh4l2191Jo7jyMCPgMIGEHw/RRCFnTKyQNi0e1wWW77UWD11rvct
 mym8H1wU1mmCvyPMJRhJrzYDVViN+z34mWAQcEv6je7D4EYIstgWztUtCQM66G/yGFra2HF0/
 20idSmtAUvqKEQSDeQgLRk80irCEME8v2GPeo++5xEQVYvvPF0wOzZbdywaW3SWykLpuohNSG
 4SCe8fy6OLszaVjOsH1PVLEtrEPJIRo1yxK1AkehklGUpDSF7PBHQYqWep1Btcz7kFW36hLD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295950>

On 05/31/2016 02:26 AM, Armin Kunaschik wrote:
> On 05/27/2016 06:19 AM, David Aguilar wrote:
>> On Wed, May 25, 2016 at 11:33:33AM +0200, Armin Kunaschik wrote:
>>
>> Would you mind submitting a patch so that we can support these
>> tests when running on AIX/HP-UX?
> I don't feel comfortable to submit patches for tests I can't verify. I
> don't have valgrind and python/p4 here. Looking to the code I'd say,
> patching the p4 tests with "ls -ld | sed" looks quite save.
> But I'm not sure about the test-lib.sh. When you are really super
> paranoid, as written in the comment, you should probably use perl like
>
> perl -e 'print readlink $ARGV[0]' $name
>
> as a replacement.
>
> So, as suggested by Junio, here the readlink workaround for t7800 only.
> (hopefully whitespace clean this time)
>
> --- 8< --- 8< ---
> From: Armin Kunaschik <megabreit@googlemail.com>
> Subject: t7800: readlink is not portable
>
> The readlink(1) command is not available on all platforms (notably not
> on AIX and HP-UX) and can be replaced in this test with the "workaround"
>
> ls -ld <name> | sed -e 's/.* -> //'
>
> This is no universal readlink replacement but works in the controlled
> test environment good enough.
>
> Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>
> ---
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 7ce4cd7..905035c 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
>   for f in file file2 sub/sub
>   do
>   	echo "$f"
> -	readlink "$2/$f"
> +	ls -ld "$2/$f" | sed -e 's/.* -> //'
>   done >actual
>   EOF
>
I don't know how portable #ls -ld" really is.
If there is one platform, that doesn't support readlink, would it
make sense to implement readlink() in test-lib.sh,
similar to what we have for MINGW, e.g. sort() or find() ?
And keep t7800 as it is ?
