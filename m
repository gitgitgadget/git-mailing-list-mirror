From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue, 15 Mar 2016 07:19:12 +0000
Message-ID: <CAE5ih79aKHM5yim-U_sauZ7ChgWR82CAre4EC3j5HQ8CCG=w_Q@mail.gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
	<CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
	<CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
	<61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
	<CB4CAAEA-0036-483A-9F2C-89B95E04037E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:19:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afjGA-0003cf-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 08:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934037AbcCOHTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 03:19:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33366 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcCOHTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 03:19:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id c203so499525oia.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jTew+2ktjlvsrl8tTecVxsE39D0qXtGC/eC+nbAEyVI=;
        b=Ibwc+zlBW6l1q1xc6cndPPPvBQpPA3rpmuHQwvUQH0jz24Qc+MCdvCk5hgcLV0ExqE
         lFgJUbw/hkrwlOE125PVFxk+CzBvYlNFxPyojOg78+ZWzD5YBiu2zwt8F+iCKXKgx9yk
         HFEnn53usM0ge+8CcPYJBRhI5aWlpxFNH9Bwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jTew+2ktjlvsrl8tTecVxsE39D0qXtGC/eC+nbAEyVI=;
        b=CTeOQF+nGli5lgVIH679ufceU6eyL4OWvPulZB4D8F3Ae0mbi+0JF2qE03os/22cew
         5++Z5014ybgvF5HZwfYouU0P2XgGF+ZrYrIvqNMseZZKtGYPzpKQudFiF6ynrda3610B
         eWBedg92EPDOgDspZTpg3+1TvNWUxwVjF3+0hYhZFFYu6DcHgYNyPDfshZzswfarAsgi
         YK6WtHM8UnUkmuO2jWfQTFukg3psOHuUdTEUvqbnBzXurzQdlenLW0QUIaEzhcj01zri
         pFCXNAw964uAGvU/agbrA4iuDE9Nz9sM0PNc2eYqvqLyhMoOxDc2fFOFCfUIfBBE3eXM
         v5RA==
X-Gm-Message-State: AD7BkJJMj5eDp9z3Gw2k37NjjHNyE4OuvPFqWHp6Mfww4hFQNA5WPJUlkUW0uJznH+f+R3gi6SvUO06EMiyDMw==
X-Received: by 10.202.180.137 with SMTP id d131mr15654258oif.135.1458026352238;
 Tue, 15 Mar 2016 00:19:12 -0700 (PDT)
Received: by 10.202.172.132 with HTTP; Tue, 15 Mar 2016 00:19:12 -0700 (PDT)
In-Reply-To: <CB4CAAEA-0036-483A-9F2C-89B95E04037E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288839>

On 13 March 2016 at 17:41, Lars Schneider <larsxschneider@gmail.com> wrote:
>
> On 02 Mar 2016, at 10:25, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>>
>>> On 02 Mar 2016, at 06:06, Luke Diamand <luke@diamand.org> wrote:
>>>
>>> On 1 March 2016 at 19:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Tue, Mar 1, 2016 at 5:49 AM,  <larsxschneider@gmail.com> wrote:
>>>>> Map a P4 user to a specific name and email address in Git with the
>>>>> "git-p4.mapUser" config. The config value must be a string adhering
>>>>> to the format "p4user = First Lastname <email@address.com>".
>>>>>
>>>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>>>> ---
>>>>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>>>>> +git-p4.mapUser::
>>>>> +       Map a P4 user to a name and email address in Git. Use a string
>>>>> +       with the following format to create a mapping:
>>>>> ++
>>>>> +-------------
>>>>> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
>>>>> +-------------
>>>>> ++
>>>>> +A mapping will override any user information from P4. Mappings for
>>>>> +multiple P4 user can be defined.
>>>>
>>>> Sorry for not paying closer attention the first time, but this needs
>>>> to be repeated for each P4 user you want to map, right? One can
>>>> imagine this quickly becoming painful if you have a lot of users to
>>>> map. Have you considered modeling this after git-svn where you can set
>>>> an "authors" file (and name the corresponding option --authors-file)?
>>>
>>> For most authors it should just use the existing Perforce user
>>> information. This is (I assume) just for the occasional exception
>>> where Perforce has the wrong email address.
>> I agree this is an occasional exception. I use it for users that have been deleted on the Perforce server.
>>
>> @Eric: If a user wants to they could create a custom gitconfig and then use the config "include" mechanism to achieve a "authors" file kind of approach.
>>
>
> Is the patch uninteresting for git-p4 as it handles only an occasional
> exception or did the patch get lost in the noise? :-)

I thought it was useful; I hadn't realised that it was needed for deleted users.

Luke
