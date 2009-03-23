From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Mon, 23 Mar 2009 12:09:30 +0100
Message-ID: <52360AC9-EAE8-4DC3-9368-7220A034E0B5@wincent.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com> <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com> <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com> <984D312E-12B8-4A8C-B567-EF5AF1DDD3D6@wincent.com> <94a0d4530903230407i2c858a5dk2c2e0703608e42d3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 12:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lli3j-0007Ws-KN
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 12:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZCWLJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZCWLJm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 07:09:42 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:55526 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZCWLJl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 07:09:41 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2NB9U3g003053
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 23 Mar 2009 07:09:36 -0400
In-Reply-To: <94a0d4530903230407i2c858a5dk2c2e0703608e42d3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114291>

El 23/3/2009, a las 12:07, Felipe Contreras escribi=F3:

> On Mon, Mar 23, 2009 at 2:07 AM, Wincent Colaiuta <win@wincent.com> =20
> wrote:
>>
>> El 23/3/2009, a las 0:01, Felipe Contreras escribi=F3:
>>
>>> On Mon, Mar 23, 2009 at 12:42 AM, Wincent Colaiuta <win@wincent.com=
>
>>> wrote:
>>>>
>>>> El 22/3/2009, a las 19:05, Felipe Contreras escribi=F3:
>>>>
>>>>> This is shorter, avoids the burder to think about the format of =20
>>>>> the
>>>>> configuration file, and git config is already used in other =20
>>>>> places in
>>>>> the manual.
>>>>>
>>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>>> ---
>>>>> Documentation/user-manual.txt |    8 +++-----
>>>>> 1 files changed, 3 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/user-manual.txt
>>>>> b/Documentation/user-manual.txt
>>>>> index b7678aa..c6ed940 100644
>>>>> --- a/Documentation/user-manual.txt
>>>>> +++ b/Documentation/user-manual.txt
>>>>> @@ -1015,13 +1015,11 @@ Telling git your name
>>>>> ---------------------
>>>>>
>>>>> Before creating any commits, you should introduce yourself to =20
>>>>> git.  The
>>>>> -easiest way to do so is to make sure the following lines appear =
=20
>>>>> in a
>>>>> -file named `.gitconfig` in your home directory:
>>>>> +easiest way is to use the linkgit:git-config[1] command:
>>>>>
>>>>> ------------------------------------------------
>>>>> -[user]
>>>>> -       name =3D Your Name Comes Here
>>>>> -       email =3D you@yourdomain.example.com
>>>>> +$ git config --global user.name "Your Name Comes Here"
>>>>> +$ git config --global user.email you@yourdomain.example.com
>>>>> ------------------------------------------------
>>>>>
>>>>> (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] =
=20
>>>>> for
>>>>> --
>>>>> 1.6.2.1.352.gae594
>>>>
>>>> See this lengthy thread:
>>>>
>>>> http://article.gmane.org/gmane.comp.version-control.git/106634
>>>
>>> I've obviously seen that thread because I started it.
>>
>> Yeah, I noticed that only after sending my message. I hadn't =20
>> realised at
>> first because the patch really looked like it was written by =20
>> someone who
>> hadn't ever seen the thread, as it doesn't address the points =20
>> raised in the
>> thread at all.
>
> I am addressing the points.

Sorry for not noticing the other patch in the series. I fired off the =20
email because when I read 8/8 I thought, "This looks almost exactly =20
like a patch that was previously rejected".

Cheers,
Wincent
