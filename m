From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: Special characters in file name
Date: Mon, 05 Sep 2011 15:12:56 +0200
Message-ID: <4E64CAD8.5040908@intland.com>
References: <4E60C6D0.7090609@intland.com> <loom.20110902T143646-347@post.gmane.org> <20110903144617.GA17893@elie> <20110904000933.195d5bf4@zappedws> <4E64BD3D.6060900@intland.com> <20110905170237.3ed59c6a@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?0KjRg9C80LrQuNC9INCQ0LvQtdC60YHQtdC5?= 
	<alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 15:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Yz6-00054K-LP
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 15:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab1IENND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 09:13:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55966 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1IENNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 09:13:01 -0400
Received: from [192.168.1.101] (94-21-178-53.pool.digikabel.hu [94.21.178.53])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M0KWj-1RJKJq2JIr-00uIbd; Mon, 05 Sep 2011 15:13:00 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <20110905170237.3ed59c6a@ashu.dyn.rarus.ru>
X-Provags-ID: V02:K0:mk/n3bfsCsc61uDD7L9d6IcjbUqK+vLftIA+xAePQOu
 JJdn/WcJlBCsQL09U518e4hIdzOw7AfyZnnxL5XhhQS0+U3OSg
 UbB4Rr1EuLOtz+wvF/i6Q98gErEu8w9qZDqpUjqcatoz8gH3iS
 Op0ZGC5R8Gi6nfnBUp2r3xxrwuXRxxcPbpHL74lndqBb1/mfJL
 T+hey2u/2PHmwA/DuMYFpWp8e16L4qNeVT3lxsHHF9+ime+WhZ
 XbmLEgRilW0aUDsiKkwa10Qo3WFuVNbikVV7FMHK1JV7rbSIuL
 dvoHGDPbIz9aej6cCk6W8UMx1AiuyuR4S9CGUl5ErWMb3HI/2f
 +HtUOLcuZMqmnLjoXkxI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180740>

Both the terminal encoding and the filename encoding are UTF-8.

=C3=81kos

2011.09.05. 15:02 keltez=C3=A9ssel, =D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD=
 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =C3=ADrta:
>> Thanks four your answer. However, it didn't help. After setting the
>> core.quotepath option to false I get this:
>>
>> diff --git a/<E1>rv<ED>zt<FB>r<F5>  b/<E1>rv<ED>zt<FB>r<F5>
>>
>> Is there a solution?
> What terminal encoding do you use? and what is its encoding?
> It seems to me terminal encoding is UTF-8 but filename encoding is no=
t
> the same.
> I get the same behaviour on Linux UTF-8 terminal for the project
> created on Windows with filenames in cp1251-encoding.
>
>> Thanks,
>> =C3=81kos Tajti
>>
>> 2011.09.03. 22:09 keltez=C3=A9ssel, Alexey Shumkin =C3=ADrta:
>>>> Hi Alexey,
>>>>
>>>> Alexey Shumkin wrote:
>>>>> Tajti =C3=81kos writes:
>>>>>> I have a file named "=C3=A1rv=C3=ADz.txt" in my repository. When=
 modify
>>>>>> that file and execute git diff, the first line looks like this:
>>>>>> diff --git "a/\303\241rv\303\255z.txt"
>>>>>> "b/\303\241rv\303\255z.txt"
>>>>>>
>>>>>> Is there an option that (if specified) will get git to print
>>>>>> "=C3=A1rv=C3=ADz.txt" instead of this escaped string?
>>>> [...]
>>>>> please, refresh your memory )))
>>>>> http://comments.gmane.org/gmane.comp.version-control.git/177849
>>>>>
>>>>> see my comment
>>>>> http://permalink.gmane.org/gmane.comp.version-control.git/177857
>>>> Cc-ing =C3=81kos so he can actually get your message this time. :)
>>>> (FWIW the convention on this list is always to reply-to-all.)
>>> Yes, I know, but I replied with the gmane.org site form, and it did
>>> not CC-ed
