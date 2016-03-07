From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Mon, 07 Mar 2016 09:54:45 +0100
Message-ID: <56DD41D5.60100@web.de>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com> <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com> <56D9D8C6.2060104@ramsayjones.plus.com> <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Alexander Rinass <alex@fournova.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 09:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acqzu-00017A-MC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 09:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcCGIy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2016 03:54:59 -0500
Received: from mout.web.de ([212.227.15.4]:56436 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbcCGIyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 03:54:54 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LtX9Q-1ZtrX945KO-010xV6; Mon, 07 Mar 2016 09:54:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com>
X-Provags-ID: V03:K0:6uuEqdwk3xsOOePpOJPoOnZBuwTZosGdrBV8WpxP3d9VoZTiyQj
 Gt1q9cIcpeNDzTG5uJ/mdv9Lgdlx1UKNQ7AYTV+OgmdzltVZPi4Wpw3SjXN2k2W4a2S0dmi
 P3da93RoSBbG1BkDPpj4T5Ezcb/nMTxggMOeGx/bVSh56yvdy+52W+LbLctpMDhQ0NBQ0Yy
 zHAtwKCYB73Ivml3Ed4fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uM8TCiKFl+U=:7Sb48ugqkBcXzoBeASQ/oN
 YAU9osWpOI+TbKBlxfOFOpwR7cbw/PVQaeKJyTVs3Bik8QO3GmMhQhskuHqK7LK4musB3c0pH
 yUW5Rif9PuzuevQPosRQWm4d0rHeGVTaBwvfKo/VnfmSVnM55wUWAJeBMMdqB1QrV/IBODxrx
 YvdmJARhWcB1ltBYeDCUODTqoSSg4qO84nyeKcVK9eV5+L/ld6DxKEB794HdntSOVnnlfNrkV
 AcxAsS8gRCa+VAYJbvHyDO4cQUldpjmwbpnPmES8gg3enW6YUzSjZcx0/k3MrIc/425EUtUWh
 dS0kcSsZ1JwxIECxcjOr15Em7MijqIVv3bzeOMf72UofcdRxbcclxBy0QMYtjb4S91iZiOMee
 ce0g5IXTAnkfwy8Z29aI7+/7Pu9jBafHv47CHNe85FCTCdWQ0Ku1/wM25fLaKu+WSnnKE49o4
 RFsTimZdfKRrK1v70RejHoE76HsmS9y7XkiK6Sq7BtKu77w7jssZT9zfbxdeiQ89Lp77umPuh
 /jFSW/Emic6ZlLWIcp1QPuAsUV2yAyD/69S0xU4rW8GU4JP+8pPrC6Y+ojEBc1takc2vBY3Cz
 O8c6itBViU/QoGEfBqGZWZh55+BI0CpnMDPlpIYKV35JpJGykmRcUpSdpoY/qrnziSe2t+aPZ
 w1dthODZ5ZZ/wEn/pg7ZyUuZ+G1SkuYv9BfQR0cNTAonOd6meB0qPjiT6MyLwtiYdWvz5p1/S
 3onTzV/pvbmONalGsS97ChLOVFYxgsihRSr9acfBUZ7F55tQlT+vP5RgMiIh1U89G1DdTbES 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288385>

On 03/07/2016 08:47 AM, Alexander Rinass wrote:
>> On 04 Mar 2016, at 19:49, Ramsay Jones <ramsay@ramsayjones.plus.com>=
 wrote:
>>
>>
>>
>> On 04/03/16 14:37, Alexander Rinass wrote:
>>>> On 04 Mar 2016, at 13:16, Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>>>>
>>>> On 03/04/2016 10:07 AM, Alexander Rinass wrote:
>> [snip]
>>
>>> Sticking a precompose_argv(argc, argv) into diff.c=E2=80=99s cmd_di=
ff function fixes the issue.
>>>
>>> But I had to disable the check (precomposed_unicode !=3D 1) in prec=
ompose_argv to make it work. That=E2=80=99s probably because precompose=
_argv is usually called from parse_options and is missing some other ca=
ll before it?
>>>
>> Yes, you need to place it after the configuration is read, but befor=
e
>> calls to diff_no_index() or setup_revisions(). Directly after the ca=
ll
>> to git_config() should be fine. [But this begs the question about ot=
her
>> commands, including plumbing, which don't call parse_options().]
>>
>> Maybe this will work for you (I can't test it, since I don't have an=
y
>> access to a Mac):
>>
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index 343c6b8..b7a9405 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -320,6 +320,7 @@ int cmd_diff(int argc, const char **argv, const =
char *prefix)
>> 		gitmodules_config();
>> 	init_diff_ui_defaults();
>> 	git_config(git_diff_ui_config, NULL);
>> +	precompose_argv(argc, argv);
>>
>> 	init_revisions(&rev, prefix);
> Your patch fixes it for the diff command without further modification=
s.
>
> I have also modified diff-tree, diff-index and diff-files by adding t=
he precompose_argv call and successfully verified it.
>
> I have attached the full patch. If there is anything else I can test,=
 let me know.
Thanks for reporting, fixing, testing -
Do you think you can send an official patch to the list ?
If not, push your patches to some public repo ?
And if not, I can put it on my TODO-stack.
