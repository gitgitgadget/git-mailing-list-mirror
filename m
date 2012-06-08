From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 23:03:27 +0200
Message-ID: <20120608230327.Horde.IXfFTHwdC4BP0mifi63m9KA@webmail.minatec.grenoble-inp.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD24AE9.8020101@web.de>
 <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr>
 <4FD258AD.6070601@web.de>
 <20120608220751.Horde.HHn7fXwdC4BP0luXQhxWxBA@webmail.minatec.grenoble-inp.fr>
 <4FD265C7.6050807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:03:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd6La-0002qc-40
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 23:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882Ab2FHVDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 17:03:45 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53807 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964799Ab2FHVDn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 17:03:43 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 2D8CC1A0699;
	Fri,  8 Jun 2012 23:03:28 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 23:03:27 +0200
In-Reply-To: <4FD265C7.6050807@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199532>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> On 08.06.12 22:07, konglu@minatec.inpg.fr wrote:
>>
>> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>>
>>> On 08.06.12 21:15, konglu@minatec.inpg.fr wrote:
>>>>
>>>> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>>>
>>>> Which part does not apply ? If you skip the part that's implementi=
ng the
>>>> exec option, of course Git will not recognize it.
>>>
>>>
>>> Hej,
>>> 2 questions:
>>> a) Where should it apply ?
>>> I tried to apply it on commit f623ca1cae600e97cb0b38131fdd33e4fb669=
cf8
>>
>> I just tried to apply it on that commit and it works for me. What's =
the
>> error message ?
>>
>>> b) Does the line from my log
>>> "error: unknown option `exec'"
>>> tell us anything?
>>
>> Yes, that the patch was not applied ^^'.
> ------------------------------------------------
> That's the outcome, if I try to re-apply it:
> Applying: Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
> error: patch failed: Documentation/git-rebase.txt:210
> error: Documentation/git-rebase.txt: patch does not apply
> Patch failed at 0001 Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD=
>...
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort"=
=2E

Did you first apply the first part [PATCHv3 1/2] of the patch ?

Lucien Kong.
