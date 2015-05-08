From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Fri, 08 May 2015 23:20:04 +0200
Message-ID: <554D2884.9040607@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>	<CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>	<554D25B1.8050605@gmail.com> <CAGZ79kaL219wN4=c9_SQGDk+Mtie0Xm5PDc0Jy6mTQiQ37wj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Stefan Beller <sbeller@google.com>, Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 08 23:20:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqpgq-0005GB-WE
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbbEHVUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 17:20:09 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33804 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbEHVUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:20:08 -0400
Received: by wgic8 with SMTP id c8so56715581wgi.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xB0+lu/J1R1ZIio48ChqrHl5sGl1A7CMgGsqvW7Wj8k=;
        b=Yd+VyDIe4fO4UjTiMVhbV6SYAyX1OUdxqAGU6ow+S7chJbpsbf1TebKmDc+Grk63Fu
         oHx+DsRdr1S4PLQvCSPqKZoBdHCo6s/VOlHlhAHAS/tRwUT/jrqrgElw8r0FybUMLBoZ
         wNcvWmpsvbn7oHvbjR1oj3wDcFFNJRFP5u4VxixSJLdzcrP1ibsqEHGP7mEEJU+jVjZe
         1PrQ0PqCrBoDg9gviN3OQXc8+dZX2u0P43OIrgTtVq/pPIhgvWL0fkE+HuCJykOncGGN
         +6R6MtugThmrAQ6PVr0guuPqlSDHNgSP6MlDn+PZs3T0TIodDrJW7emeko4UFItiPEmv
         R5Rw==
X-Received: by 10.180.100.194 with SMTP id fa2mr1409511wib.8.1431120006954;
        Fri, 08 May 2015 14:20:06 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fs9sm10096681wjc.34.2015.05.08.14.20.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 14:20:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAGZ79kaL219wN4=c9_SQGDk+Mtie0Xm5PDc0Jy6mTQiQ37wj4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268673>



On 05/08/2015 11:17 PM, Stefan Beller wrote:
> On Fri, May 8, 2015 at 2:08 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> On 05/06/2015 05:16 AM, Eric Sunshine wrote:
>>>
>>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>>>>
>>>> +
>>>> +       if (group1 =3D=3D group2)
>>>> +               return 0;
>>>> +       if (group1 > group2)
>>>> +               return 1;
>>>> +       else
>>>> +               return -1;
>>>
>>>
>>> Do you also want to sort the commands alphabetically within group?
>>> That is, something like this?
>>>
>>>       struct cmdname_help *e1 =3D elem1;
>>>       struct cmdname_help *e2 =3D elem2;
>>>
>>>       if (e1->group < e2->group)
>>>           return -1;
>>>       if (e1->group > e2->group)
>>>           return 1;
>>>       return strcmp(e1->name, e2->name);
>>>
>>>> +}
>>
>>
>> Your version raises:
>>
>> help.c: In function =E2=80=98cmd_group_cmp=E2=80=99:
>> help.c:223:28: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from
>> pointer target type [enabled by default]
>>    struct cmdname_help *e1 =3D elem1;
>>                              ^
>> help.c:224:28: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from
>> pointer target type [enabled by default]
>>    struct cmdname_help *e2 =3D elem2;
>>                              ^
>>
>> With the cast:
>>
>> struct cmdname_help *e1 =3D (struct cmdname_help*)elem1;
>>
>> It compiles without a warning (gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2)
>>
>>
>
> I'd rather change the type of struct cmdname_help to be const, such
> that it reads:
>
>        const struct cmdname_help *e1 =3D elem1;
>        const struct cmdname_help *e2 =3D elem2;
>
>        if (e1->group < e2->group)
>            return -1;
>        if (e1->group > e2->group)
>            return 1;
>        return strcmp(e1->name, e2->name);
>
> instead of casting if possible.
>

yes, much better, thanks.
