From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Fri, 8 May 2015 14:17:00 -0700
Message-ID: <CAGZ79kaL219wN4=c9_SQGDk+Mtie0Xm5PDc0Jy6mTQiQ37wj4A@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
	<554D25B1.8050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqpds-00043z-KV
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbEHVRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 17:17:04 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35532 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbbEHVRB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 17:17:01 -0400
Received: by ieczm2 with SMTP id zm2so73228962iec.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PgBWjk455xhhQBI6q0hGDVFmULwm29kyQRelgMDFrl4=;
        b=QlwfqFxpaDyJ4O6wdVO6fVZFwMvMdFKbdkXIfe1S3sDJfEu3jm/ESm7eKrItTvQQTr
         5celNJTqQoHLy5ZGI2SKLnNaBhlCauRjBK0Nc25NmooYQ4c1HnXLoerNyyzzUuk27z98
         b2mWEwaHWk9BU64zoplBnrqn5jjKV2nEcTlggRJ8Qgm/MasE4aJtTJ7OqN6/S4M9I9oG
         6D+q6bomV60ByjVvb1gx5jhrzcPkiOKhehqplmGirZbm6ptCGAVYzge/cnVR17HALcr3
         RdtIFoD9nqPJgp78k9Yu4F7x7J3EpWvi5QmPxv/3XVY9KOUisv2AKrtuDO0Cpq8K6xx3
         +qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PgBWjk455xhhQBI6q0hGDVFmULwm29kyQRelgMDFrl4=;
        b=gdf+Fw67QQKNhlpXyFqjwp6tXrKAxtbeLjMzvIj/RF8F5qcinv0ggZ3DDPLeS0qQo6
         shJwno4Hlgsmw+WApfXpzjvn+MgJ978J8IqXIV8kr3IqP6Sxo0rCFPV+BFlPr+zkS63o
         XbVwW6ExhMzJdKlHA35OUBtuRF9jTSeRW2WBV4MctYokiZvkXjqbWl2li/5FZYa48Zzo
         WC/BW7gKZK4aimkUsravEtT6+D+TgLAE2Kjqk1VTBmLGv2I8ATGVnAGTU1n2mNg8i7Nj
         MehQQ9eQtxUl+s5ubOmE1N5sBVlHd7FQrpdReb5msxPOK1tkvzI90KkSzXB9DTdQhkVq
         0WWg==
X-Gm-Message-State: ALoCoQlQx2E5DzdX1uSyf1hJsUVrRWGBGj0rJ0PeKtYt3U3WCXfjWR3ZlXctFTyOuvSCfLvi4YHN
X-Received: by 10.42.20.14 with SMTP id e14mr127301icb.76.1431119821143; Fri,
 08 May 2015 14:17:01 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 8 May 2015 14:17:00 -0700 (PDT)
In-Reply-To: <554D25B1.8050605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268671>

On Fri, May 8, 2015 at 2:08 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/06/2015 05:16 AM, Eric Sunshine wrote:
>>
>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>>>
>>> +
>>> +       if (group1 =3D=3D group2)
>>> +               return 0;
>>> +       if (group1 > group2)
>>> +               return 1;
>>> +       else
>>> +               return -1;
>>
>>
>> Do you also want to sort the commands alphabetically within group?
>> That is, something like this?
>>
>>      struct cmdname_help *e1 =3D elem1;
>>      struct cmdname_help *e2 =3D elem2;
>>
>>      if (e1->group < e2->group)
>>          return -1;
>>      if (e1->group > e2->group)
>>          return 1;
>>      return strcmp(e1->name, e2->name);
>>
>>> +}
>
>
> Your version raises:
>
> help.c: In function =E2=80=98cmd_group_cmp=E2=80=99:
> help.c:223:28: warning: initialization discards =E2=80=98const=E2=80=99=
 qualifier from
> pointer target type [enabled by default]
>   struct cmdname_help *e1 =3D elem1;
>                             ^
> help.c:224:28: warning: initialization discards =E2=80=98const=E2=80=99=
 qualifier from
> pointer target type [enabled by default]
>   struct cmdname_help *e2 =3D elem2;
>                             ^
>
> With the cast:
>
> struct cmdname_help *e1 =3D (struct cmdname_help*)elem1;
>
> It compiles without a warning (gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2)
>
>

I'd rather change the type of struct cmdname_help to be const, such
that it reads:

      const struct cmdname_help *e1 =3D elem1;
      const struct cmdname_help *e2 =3D elem2;

      if (e1->group < e2->group)
          return -1;
      if (e1->group > e2->group)
          return 1;
      return strcmp(e1->name, e2->name);

instead of casting if possible.
