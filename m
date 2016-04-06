From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Wed, 6 Apr 2016 13:00:25 +0300
Message-ID: <CAJPOeMeAQVR9ZvEC+r24P-RZq46iAeVx3CrLNbGXBGE8jw-iUA@mail.gmail.com>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
 <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <CAJPOeMeqMpy8wmZ3jMfw_XLAS2WbPOtJF8_Rd_sPGQNeCNyFnw@mail.gmail.com> <1048705176.2897167.1459806794368.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 06 12:01:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ankGm-0001ge-1o
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 12:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbcDFKA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 06:00:57 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33405 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798AbcDFKA4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2016 06:00:56 -0400
Received: by mail-qg0-f67.google.com with SMTP id 7so1012898qgj.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3X5ArelhoE/S1t6WN40iF6Zbff/yFXHrhYgtEvn+qg=;
        b=kY0GcMf/26rcnqZF+8pWkEj9A9y1rJYMLiCggoE+UHQHmr9t43ST/kxUUOLiU8JNQl
         2+hY5pRBOepcPhW1rabtE/nU02e7i0HOrhHguQ1OVKHq3RiDwnsHoekqfZ7GxNbYvNBI
         ufYhuWqggf+wU9kYVUwEtPSErQdbvcNtd/jisMyUUUwRcCD3/LieldkfVYDwMgSwDMDK
         M5gaE2yyj4ZmMG9rWX6CpLGDg+/AdPfnfaM3SZnowbPDjiSRYKJcB4iQYg6iRr99rBAz
         2CfihRABn+bnM46Ws1T0HSKcM5S8i7SQu3POAXG2Os+St2/GBGZjEujJIVZ46xOXirK5
         hEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3X5ArelhoE/S1t6WN40iF6Zbff/yFXHrhYgtEvn+qg=;
        b=G42mXyTZJinuSde/NNpWlcOdCjy6Z4dVhkpFKIDB7YDP9YlqJnlpmhwdp8l3anKpPH
         TyJiwHW7KHWkWYZHCQR/A7sXnpz4tXhtyrI/tru2WU5F1UdSqsOfhQZ8QqK/H8ohDme9
         qmS0+Q2wjcR9AN9kPR3Q5aC+ogosFe8K49Kitp2OsQKz+plSkeZsdMghP2+yFm0pWdEw
         +rSKgDuMwKbLfadkBCe4SMzH9DqloPb6Srdc5P1Tqinm/JG4U76MliUmpgS73sCCyEdl
         YWUXIe8gsL+5F+lodrgSeVrdsY7JFKX8kzExes0m7sdtDpfA731aC8lufacFZtyTlwK2
         VVEw==
X-Gm-Message-State: AD7BkJJeZ5jhstOO2VME+NKE2jRH/CUiHs9kpVaPJcRiZ9bWdcehPoVPe3Ld/CMQNhH6ibg7XxuTK7R5+c4PRA==
X-Received: by 10.140.194.67 with SMTP id p64mr4374749qha.19.1459936855033;
 Wed, 06 Apr 2016 03:00:55 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Wed, 6 Apr 2016 03:00:25 -0700 (PDT)
In-Reply-To: <1048705176.2897167.1459806794368.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290835>

On Tue, Apr 5, 2016 at 12:53 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> elena petrashen <elena.petrashen@gmail.com> wrote:
>> On Thu, Mar 31, 2016 at 6:31 PM, Remi Galan Alfonso
>> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
>> > Elena Petrashen <elena.petrashen@gmail.com> wrote:
>> >> +void delete_branch_advice(const char *name, const char *ref)
>> >> +{
>> >> +        const char fmt[] =3D
>> >> +        "\nNote: to restore the deleted branch:\n\ngit branch %s=
 %s\n";
>> >
>> > Shouldn't that be marked for translation, like is done with the ot=
her
>> > strings?
>> >
>> > Thanks,
>> > R=C3=A9mi
>>
>> Thank you for letting me know about that! Could you please
>> help me out and explain how do I mark it for translation? I tried
>> to do it the same way as with the other strings but evidently
>> didn't quite succeed.
>
> I am not sure.
> I tried to grep similar cases, it seems that you can do the following=
:
>
>         const char fmt[] =3D N_("\nNote: to restore [...] \ngit branc=
h %s %s\n");
>         fprintf(stderr, _(fmt), name, ref);
>
> Some similar example in builtin/add.c:
>
>         static const char ignore_error[] =3D
>         N_("The following paths are ignored by one of your .gitignore=
 files:\n");
>         [...]
>                         fprintf(stderr, _(ignore_error));
>
> Or you can define fmt as a 'const char *' and in that case do the
> following:
>
>         const char *fmt =3D _("\nNote: to restore [...] \n git branch=
 %s %s\n");
>         fprintf(stderr, fmt, name, ref);
>
>
> In builtin/am.c:
>                 const char *invalid_line =3D _("Malformed input line:=
 '%s'.");
>         [...]
>                                 ret =3D error(invalid_line, sb.buf);
>
> I don't know which one is the best way to go though.
>
> Thanks,
> R=C3=A9mi

Thank you! I'm a bit confused though as the previous implemented advice=
 function
in advice.c (the one I used for reference) doesn't seem to employ this.=
=2E. does
this mean it's also not marked for translation?

void detach_advice(const char *new_name)
{
const char fmt[] =3D
"Note: checking out '%s'.\n\n"
"You are in 'detached HEAD' state. <.........>Example:\n\n"
"  git checkout -b <new-branch-name>\n\n";

fprintf(stderr, fmt, new_name);
}

Cheers,
Elena
