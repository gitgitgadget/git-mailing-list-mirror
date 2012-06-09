From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Sat, 09 Jun 2012 08:14:13 +0200
Message-ID: <4FD2E9B5.1010709@web.de>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD24AE9.8020101@web.de> <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr> <4FD258AD.6070601@web.de> <20120608220751.Horde.HHn7fXwdC4BP0luXQhxWxBA@webmail.minatec.grenoble-inp.fr> <4FD265C7.6050807@web.de> <20120608230327.Horde.IXfFTHwdC4BP0mifi63m9KA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sat Jun 09 08:15:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdEwu-0002bS-U9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 08:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab2FIGOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jun 2012 02:14:20 -0400
Received: from mout.web.de ([212.227.17.11]:57422 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab2FIGOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 02:14:19 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MV4fx-1STWZM31ZN-00YM5h; Sat, 09 Jun 2012 08:14:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120608230327.Horde.IXfFTHwdC4BP0mifi63m9KA@webmail.minatec.grenoble-inp.fr>
X-Provags-ID: V02:K0:DzkgDfcH7TIaVNn4SxoU/1MrVBLOTV6l/epjVHooLdp
 kF8ljhR3dBD96b4y6L/xLO47F+dM7VXoO5njTOLSrzNoCsiXPy
 l7YNVNLK2EI/MFotfqMcDkTGzTd/kqXVgdHBzLGnLkNzhnIpqS
 jTYvh3YQxccr2mEr4qF9WVJdbjM0HG178ans++ln1ShU/ptXsX
 O/ZF2mIQ+sEa3qUMDcODA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199544>

On 08.06.12 23:03, konglu@minatec.inpg.fr wrote:
>=20
> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>=20
>> On 08.06.12 22:07, konglu@minatec.inpg.fr wrote:
>>>
>>> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>>>
>>>> On 08.06.12 21:15, konglu@minatec.inpg.fr wrote:
>>>>>
>>>>> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>>>>
>>>>> Which part does not apply ? If you skip the part that's implement=
ing the
>>>>> exec option, of course Git will not recognize it.
>>>>
>>>>
>>>> Hej,
>>>> 2 questions:
>>>> a) Where should it apply ?
>>>> I tried to apply it on commit f623ca1cae600e97cb0b38131fdd33e4fb66=
9cf8
>>>
>>> I just tried to apply it on that commit and it works for me. What's=
 the
>>> error message ?
>>>
>>>> b) Does the line from my log
>>>> "error: unknown option `exec'"
>>>> tell us anything?
>>>
>>> Yes, that the patch was not applied ^^'.
>> ------------------------------------------------
>> That's the outcome, if I try to re-apply it:
>> Applying: Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
>> error: patch failed: Documentation/git-rebase.txt:210
>> error: Documentation/git-rebase.txt: patch does not apply
>> Patch failed at 0001 Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CM=
D>...
>> When you have resolved this problem run "git am --resolved".
>> If you would prefer to skip this patch, instead run "git am --skip".
>> To restore the original branch and stop patching run "git am --abort=
".
>=20
> Did you first apply the first part [PATCHv3 1/2] of the patch ?
>=20
> Lucien Kong.
Hej,
I have 2 patches with the headline "[PATCHv3 1/2" in my in box.
None of them is dealing in any kind with upgrading a command to underst=
and "exec".

To be able to test under Mac OS it could be helpful if you just re-send
one patch to my email.
Then I can try to re-do the patch based on f623ca1cae600e97cb0b38 and
test it under Mac OS.

Does that makes sense?

/Torsten
