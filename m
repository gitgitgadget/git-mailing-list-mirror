From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v11 5/5] help: respect new common command grouping
Date: Mon, 25 May 2015 19:25:37 +0200
Message-ID: <55635B11.8000906@gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>	<1432229962-21405-6-git-send-email-sebastien.guimmara@gmail.com> <CAPig+cQ0ExDCoSU_P02on0U+8WXbyGbZecK-4vrUVFp1Mo11hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 25 19:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yww8H-0005EF-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 19:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbbEYRZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2015 13:25:41 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35311 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEYRZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 13:25:40 -0400
Received: by wicmx19 with SMTP id mx19so53746144wic.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1lfVpJ8ROiXyweLFlkykmB7h7taffoVI9H05pOP9MV8=;
        b=cG3LFHrLmmbyHEDRfYYAYEjVt8MIb/C0Alg0buS1AsCEEhXYFEikld4rSUYwXBXTtm
         RQRlSzdlSy0tMFhtzmQpP9tcN7FRd7PAoIJBgfUMpboIbknE8iymE2LaWQ+Z8WhRIPJZ
         fFoxS7b/ffjj5QMfvA0v8oJUADrxO/zNP9OljiDXeYNnNq2FelfwDYckIn1vYLJZ4uZd
         Nf+LT/dCWORVuY/eUjUfSS6d7yboQTx93drGVMpFMOan/N6UF0HsG5Sfc0KjZ+8qJVLT
         u2j4Ml7/h978E1qQU2yLGntHhtsQo7PTRYM8otk/6iOmbNLkFA9Dfj88W0Wl1r33y3kG
         KotQ==
X-Received: by 10.194.192.72 with SMTP id he8mr42026944wjc.11.1432574739248;
        Mon, 25 May 2015 10:25:39 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id 12sm17726137wjw.17.2015.05.25.10.25.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 10:25:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cQ0ExDCoSU_P02on0U+8WXbyGbZecK-4vrUVFp1Mo11hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269847>



On 05/21/2015 08:04 PM, Eric Sunshine wrote:
> On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> 'git help' shows common commands in alphabetical order:
>>
>> The most commonly used git commands are:
>>     add        Add file contents to the index
>>     bisect     Find by binary search the change that introduced a bu=
g
>>     branch     List, create, or delete branches
>>     checkout   Checkout a branch or paths to the working tree
>>     clone      Clone a repository into a new directory
>>     commit     Record changes to the repository
>>     [...]
>>
>> without any indication of how commands relate to high-level
>> concepts or each other. Revise the output to explain their relations=
hip
>> with the typical Git workflow:
>>
>> The most commonly used git commands are:
>
> The above line in the commit message does not match the actual output=
:
>
>      "These are common Git commands used in various situations:"
>

Thanks. Will correct this.

>> start a working area (see also: git help tutorial)
>>     clone      Clone a repository into a new directory
>>     init       Create an empty Git repository or reinitialize [...]
>>
>> work on the current change (see also: git help everyday)
>>     add        Add file contents to the index
>>     reset      Reset current HEAD to the specified state
>>
>> examine the history and state (see also: git help revisions)
>>     log        Show commit logs
>>     status     Show the working tree status
>>
>>     [...]
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> diff --git a/help.c b/help.c
>> index 2072a87..8f72051 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
>>          }
>>   }
>>
>> +static int cmd_group_cmp(const void *elem1, const void *elem2)
>> +{
>> +       const struct cmdname_help *e1 =3D elem1;
>> +       const struct cmdname_help *e2 =3D elem2;
>> +
>> +       if (e1->group < e2->group)
>> +               return -1;
>> +       if (e1->group > e2->group)
>> +               return 1;
>> +       return strcmp(e1->name, e2->name);
>> +}
>> +
>>   void list_common_cmds_help(void)
>>   {
>>          int i, longest =3D 0;
>> +       int current_grp =3D -1;
>>
>>          for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>>                  if (longest < strlen(common_cmds[i].name))
>>                          longest =3D strlen(common_cmds[i].name);
>>          }
>>
>> -       puts(_("The most commonly used git commands are:"));
>> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
>> +               sizeof(common_cmds[0]), cmd_group_cmp);
>> +
>> +       puts(_("These are common Git commands used in various situat=
ions:"));
>> +
>>          for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>> +               if (common_cmds[i].group !=3D current_grp) {
>> +                       printf("\n%s\n", _(common_cmd_groups[common_=
cmds[i].group]));
>> +                       current_grp =3D common_cmds[i].group;
>> +               }
>> +
>>                  printf("   %s   ", common_cmds[i].name);
>>                  mput_char(' ', longest - strlen(common_cmds[i].name=
));
>>                  puts(_(common_cmds[i].help));
>> --
>> 2.4.0.GIT
