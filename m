From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 11:48:27 +0530
Message-ID: <CAFZEwPOa3i9XTF-5ZWZXvXfAzpyFojz57JBy4_WahF0Y4Q9DWQ@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 07:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajhYQ-0003S5-PN
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 07:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbcCZGS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2016 02:18:28 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33106 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcCZGS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 02:18:28 -0400
Received: by mail-qk0-f180.google.com with SMTP id s5so50753706qkd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=85soL5BOVpxWcyN2OLbYBGsAmq45bu5WHU++PdjZQVo=;
        b=aIfGolK4dxuKVV1C/hjNrz08lIZrp9yKTOapj0lrJW0xNsTzPQ5t51dlJcz0eL7eT7
         S9Lo9RXPej5GxGxrvnCdWMMmOSnpo4hm4r1glUj6gGFj/V27b9YTJyHDl9s38hex1TVD
         8XA8Po8ldfhY8dX3fOJv0I6YCRd28mUDK2XzN2F1A0l87Nip4vqxBS4XASk8vBwIgvwG
         RDJ+LIeFCPuorvV6sD0mr3GKRFbmobtLws49qUMKxYNXRjwueRjc7VD8Or4FheLHvxp7
         BiBn2OVuCs3lBfoTjUBZ9T2qo43jGg9ELaBrBa2yXwuHugtDDivElkYYkSDoSLMEme2g
         j6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=85soL5BOVpxWcyN2OLbYBGsAmq45bu5WHU++PdjZQVo=;
        b=hNR1bvTrBb1q77Vz1zDHEbwOiUfIh7MGXq/YhX2M3vhD/t19L8x0J13lerQdEjUPex
         o+hXMhpm5tuF0YAs58zSRVwMXF4YQKH/zA7C2C+90DKycv2jDFjljvfFWAw8U8UiV3NR
         2sXB2DmLGaEZxSkrVR+ThjVZiUwhUuHG+u1Z1OBxdv+y4P/b3xmpkwYV733ByjDaHpmQ
         5C/x9fYD3Re0daZPi5kel+3q10N/Uubl901MCV55gk4ST8uX1WhuN3Iit5JHpJUOYoQz
         BVI+QXnvxlLAba2cLVYOBJA5mMY+XWJgblUGPWpmReEeeeI9C9kMRVFyVRBfi/jSJj1d
         TxMg==
X-Gm-Message-State: AD7BkJKz87qO8fo6jQm7DrdlEQqUVSTICH6UC+Xi6CB1aOMSub67itlV9EGndg/jUVBAMrK0XZumI6baFlBsHQ==
X-Received: by 10.129.9.214 with SMTP id 205mr8778114ywj.53.1458973107244;
 Fri, 25 Mar 2016 23:18:27 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 23:18:27 -0700 (PDT)
In-Reply-To: <CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289976>

On Sat, Mar 26, 2016 at 7:43 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@=
gmail.com> wrote:
> 2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>>
>>> # Purpose
>>> The current implementation of send-email is based on perl and has o=
nly
>>> a tui, it has two problems:
>>> - user must install a ton of dependencies before submit a single pa=
tch.
>>> - tui and parameter are both not quite friendly to new users.
>>
>> Is "a ton of dependencies" true?  "apt-cache show git-email"
>> suggests otherwise.  Is "a ton of dependencies" truly a problem?
>> "apt-get install" would resolve the dependencies for you.
>
> There are three perl packages needed to send patch through gmail:
> - perl-mime-tools
> - perl-net-smtp-ssl
> - perl-authen-sasl
>
> Yes, not too many, but is it better none of them?

Are you sure using a GUI does not have any dependencies?

> What's more, when I try to send mails, I was first disrupted by
> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-sas=
l".
> Then I think, why not just a mailto link?
>
>>> # Plan
>>> So I propose to implement following:
>>> - Allow user to send mail via a [`mailto`
>>> link](https://en.wikipedia.org/wiki/Mailto). so that users could
>>> complete the mail in their favorite email clients such as gmail, mu=
tt,
>>> alpine and even gmail for android through
>>
>> IIRC, GMail on Android is incapable of sending a "text/plain", so
>> that part may not fly well.
>
> Really? As much as I known, GMail on Android is capable of sending
> a "text/plain" while Inbox is not.

How do you plan in integrating GMail on Android so that it can send
patches which exists on your computer?

>>> - Build a simple email client (maybe a web components based web app=
 or
>>> wxwidgets based GUI client, they are both cross-platform) which is
>>> easy to use for sending patch without disrupting the mailbox format=
=2E

I think introducing a GUI may lead to much more dependencies. Many git
developers already have perl packages in their system but they don't
have wxwidgets.

>> I suspect it would yield a better result if the plan were to update
>> a popular email client and make it possible to tell it to read an
>> existing text file (i.e. mbox) without corrupting its contents.
>> People do not have to learn a new mail client if done that way.
>
> Maybe a plugin? I'm not sure.

You could make a plugin. That would simply things.

> If above `mail-to` is implemented, user could just using any mail
> client, but a mail client adaptive for patch would be better:
> - Do not allow user to edit the diff part
> - always 'plan/text'
> - visual
