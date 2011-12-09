From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 09 Dec 2011 08:05:21 +0100
Message-ID: <op.v57na7120aolir@keputer>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	=?utf-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 08:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYuWe-0005GT-ON
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 08:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab1LIHF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 02:05:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37107 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1LIHF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 02:05:27 -0500
Received: by eekc4 with SMTP id c4so227298eek.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 23:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=UhKjDFsSdK2OFDUEt8w9OLYtgASFY7aM9kbma4nfL8w=;
        b=lJOTd1MIZLtcntMavge2s1bKsZOJVOEjX7qihKu6B9pXi4DaFvtL8Dhsr1KAFsin6+
         6DQQJHxVZzOfOLYt7Je+FJis68XyvsTXkh0BUZ/iMR4H+HA77bHi0JovEQRfDaZby74A
         RSCjsiHQzjPL6RtIYVZmZ56uDTIsAlXSL3Dv0=
Received: by 10.14.12.9 with SMTP id 9mr627770eey.174.1323414324557;
        Thu, 08 Dec 2011 23:05:24 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x12sm27525379eef.9.2011.12.08.23.05.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 23:05:23 -0800 (PST)
In-Reply-To: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186612>

On Fri, 09 Dec 2011 02:59:06 +0100, Sidney San Mart=C3=ADn <s@sidneysm.=
com> =20
wrote:

> Hey, I want to ask about the practice of wrapping commit messages to =
=20
> 70-something charaters.
>
> The webpage most cited about it, which I otherwise really like, is
>
> 	http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
>
> *Nothing else* in my everyday life works this way anymore. Line wrapp=
ing =20
> gets done on the display end in my email client, my web browser, my =20
> ebook reader entirely automatically, and it adapts to the size of the=
 =20
> window.

Actually, opera-mail autowraps at 72 characters but sets the text forma=
t =20
to flowed. It also wraps the quoted text when you reply. But there's a =
=20
reasonable chance that you don't use opera in your daily life. On the =20
other hand I would not be surprised if most decent e-mail clients worke=
d =20
that way.

Nobody's forcing you to use the same practice in your own projects anyw=
ay.


>
> That article gives two reasons why commits should be wrapped to 72 =20
> columns. First:
>
>> git log doesn=E2=80=99t do any special special wrapping of the commi=
t messages. =20
>> With the default pager of less -S, this means your paragraphs flow f=
ar =20
>> off the edge of the screen, making them difficult to read. On an 80 =
=20
>> column terminal, if we subtract 4 columns for the indent on the left=
 =20
>> and 4 more for symmetry on the right, we=E2=80=99re left with 72 col=
umns.
>
> Here, I put a patch at the bottom of this email that wraps commit =20
> messages to, right now, 80 columns when they're displayed. (It=E2=80=99=
s a quick =20
> one, probably needs configurability. Also, beware, I don=E2=80=99t pr=
ogram in C =20
> too much.)

Hm. Saying "that's how the tool works" is not a good reason in my opini=
on. =20
There might be tons of other reasons for wrapping at 80 characters. =20
Readability is one that comes to mind for me.

>
> Second:
>
>> git format-patch --stdout converts a series of commits to a series o=
f =20
>> emails, using the messages for the message body. Good email netiquet=
te =20
>> dictates we wrap our plain text emails such that there=E2=80=99s roo=
m for a few =20
>> levels of nested reply indicators without overflow in an 80 column =20
>> terminal. (The current rails.git workflow doesn=E2=80=99t include em=
ail, but =20
>> who knows what the future will bring.)
>
> There's been a standard for flowed plain text emails (which don't hav=
e =20
> to wrap at 80 columns) for well over ten years, RFC-2646 and is widel=
y =20
> supported. Besides, code in diffs is often longer than 7x characters,=
 =20
> and wrapping, like `git log`, could be done inside git. FWIW, there a=
re =20
> a bunch of merge commits with lines longer than 80 characters in the =
git =20
> repo itself.

Yes, that standard allows e-mail clients to display the text more fluid=
ly, =20
even if the source text is word-wrapped. While git uses e-mail format, =
it =20
isn't an e-mail client. I always interpreted this whole thing as git =20
basically creating plain-text e-mails. You're actually writing the sour=
ce =20
of the e-mail in your commit message. If you care about actual use in =20
e-mail (like we do here on the list) you might want to add the relevant=
 =20
header to the mails. That said, Apple Mail (the client you used to send=
 =20
your mail) doesn't even use the RFC you quote in the sent message. That=
 =20
mail is going to be a pain in the butt to read in mutt from work ;).


>
> Finally, people read commits these days in many other places than `gi=
t =20
> log` (and make commits in many other places than a text editor =20
> configured to wrap). Most every GUI and already word wraps commit =20
> messages just fine. As a result, there are commits in popular repos m=
uch =20
> longer than the 72-column standard and no one notices. Instead, =20
> properly-formatted commit messages end up looking cramped when you se=
e =20
> them in anywhere wider than 80 columns.

Cramped? I think it's compact and actually I prefer it over long lines.

> Am I crazy?

Probably not. Don't take my word for it. I'm not a psychiatrist.


> If this makes sense to anyone else, I'd be happy to help massage this=
 =20
> into something git-worthy, with some help (never worked on Git before=
).
>
> - - -
>
> From a93b390d1506652d4ad41d1cbd987ba98a8deca0 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneysm=
=2Ecom>
> Date: Thu, 8 Dec 2011 20:26:23 -0500
> Subject: [PATCH] Wrap commit messages on display
>
> - Wrap to 80 characters minus the indent
> - Use a hanging indent for lines which begin with "- "
> - Do not wrap lines which begin with whitespace
> ---
>  pretty.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 230fe1c..15804ce 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1243,8 +1243,14 @@ void pp_remainder(const struct =20
> pretty_print_context *pp,
>  			memset(sb->buf + sb->len, ' ', indent);
>  			strbuf_setlen(sb, sb->len + indent);
>  		}
> -		strbuf_add(sb, line, linelen);
> -		strbuf_addch(sb, '\n');
> +		if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
> +			strbuf_add(sb, line, linelen);
> +		} else {
> +			struct strbuf wrapped =3D STRBUF_INIT;
> +			strbuf_add(&wrapped, line, linelen);
> +			strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + (line[0] =3D=
=3D '-' =20
> && line[1] =3D=3D ' ' ? 2 : 0), 80 - indent);

While on the subject, In my mail view, the new line started with the [1=
] =20
 from line[1], in the quote the line looks entirely different. Now this=
 is =20
code we're talking about, so it makes slightly more sense to have a pro=
per =20
wrapping hard-coded. Compare the above with the following:

+			int hanging_indent =3D ((line[0] =3D=3D '-' && line[1] =3D=3D ' ') =
? 2 : 0);
[...]
+			strbuf_add_wrapped_text(sb, wrapped.buf, 0,
+									indent + hanging_indent,
+									80 - indent);

Much clearer, no? I personally usually have two or three terminals tuck=
ed =20
next to each other, so I can look at two or three things at the same ti=
me. =20
80 characters limit is a nice feature then.


> +			strbuf_addch(sb, '\n');
> +		}
>  	}
>  }
>

Cheers,
=46rans
