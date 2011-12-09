From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 9 Dec 2011 09:10:36 -0500
Message-ID: <06819C5A-C6D3-4A14-9930-73F66707CE3E@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <op.v57na7120aolir@keputer>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Frans Klaver" <fransklaver@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 01:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZB5T-0006ad-7p
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 01:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1LJAqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 19:46:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57137 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1LJAqe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 19:46:34 -0500
Received: by ggnr5 with SMTP id r5so3931979ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 16:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=bypjLNmh7xmWrr05IUKITexrCvHA4Luti6fvsGsjkcw=;
        b=GjCxu/f6N8y97AtAEkh6mCHnPaj1bgcZZ0azv5FyCOZAUq03avnxrs6y6U3O70LtZ9
         OA4pFz8XeQvLUpQLNs+xZMdOc7YPc+dOT/Ivgo9IiecaWwrJrM9v2w7v3F6MXDsNhfZx
         IYGdc9UoDJcMtKPyWlpoH3EQ3EsXoR3rhp8hU=
Received: by 10.101.160.1 with SMTP id m1mr2318830ano.156.1323477993964;
        Fri, 09 Dec 2011 16:46:33 -0800 (PST)
Received: from [127.0.0.1] (mobile-166-137-138-116.mycingular.net. [166.137.138.116])
        by mx.google.com with ESMTPS id v48sm17906426yhk.6.2011.12.09.16.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 16:46:33 -0800 (PST)
In-Reply-To: <op.v57na7120aolir@keputer>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186716>

On Dec 9, 2011, at 2:05 AM, Frans Klaver wrote:

> On Fri, 09 Dec 2011 02:59:06 +0100, Sidney San Mart=EDn <s@sidneysm.c=
om> wrote:
>=20
>> Hey, I want to ask about the practice of wrapping commit messages to=
 70-something charaters.
>>=20
>> The webpage most cited about it, which I otherwise really like, is
>>=20
>> 	http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.htm=
l
>>=20
>> *Nothing else* in my everyday life works this way anymore. Line wrap=
ping gets done on the display end in my email client, my web browser, m=
y ebook reader entirely automatically, and it adapts to the size of the=
 window.
>=20
> Actually, opera-mail autowraps at 72 characters but sets the text for=
mat to flowed. It also wraps the quoted text when you reply. But there'=
s a reasonable chance that you don't use opera in your daily life. On t=
he other hand I would not be surprised if most decent e-mail clients wo=
rked that way.
>=20

Interesting=85 either way, the end result is that the receiving mail cl=
ient can wrap the lines to whatever length it (or you, as its operator)=
 desires, which I think we can agree is a good thing, right?

> Nobody's forcing you to use the same practice in your own projects an=
yway.
>=20
>=20
>>=20
>> That article gives two reasons why commits should be wrapped to 72 c=
olumns. First:
>>=20
>>> git log doesn=92t do any special special wrapping of the commit mes=
sages. With the default pager of less -S, this means your paragraphs fl=
ow far off the edge of the screen, making them difficult to read. On an=
 80 column terminal, if we subtract 4 columns for the indent on the lef=
t and 4 more for symmetry on the right, we=92re left with 72 columns.
>>=20
>> Here, I put a patch at the bottom of this email that wraps commit me=
ssages to, right now, 80 columns when they're displayed. (It=92s a quic=
k one, probably needs configurability. Also, beware, I don=92t program =
in C too much.)
>=20
> Hm. Saying "that's how the tool works" is not a good reason in my opi=
nion. There might be tons of other reasons for wrapping at 80 character=
s. Readability is one that comes to mind for me.
>=20

That's my basic point. I hope it didn't seem like I was arguing against=
 reading commit messages wrapped to 80 columns, by default. I only want=
ed to discuss whether it makes more sense to handle it on the display e=
nd instead of asking committers to do it in advance.

- My phone shows text most comfortably at about 40 characters per line.=
 I do look at terminals at 80 columns most of the time, but not always,=
 and I sometimes browse projects in GUI tools that use a proportional f=
ont in a window may be narrower or wider than that.

- Right now, when I *am* in an 80-col terminal I have to trust everyone=
 else to wrap their commit messages. Not everyone does. I feel like it =
would be more effective to give git the ability to wrap them automatica=
lly when I read them.

>>=20
>> Second:
>>=20
>>> git format-patch --stdout converts a series of commits to a series =
of emails, using the messages for the message body. Good email netiquet=
te dictates we wrap our plain text emails such that there=92s room for =
a few levels of nested reply indicators without overflow in an 80 colum=
n terminal. (The current rails.git workflow doesn=92t include email, bu=
t who knows what the future will bring.)
>>=20
>> There's been a standard for flowed plain text emails (which don't ha=
ve to wrap at 80 columns) for well over ten years, RFC-2646 and is wide=
ly supported. Besides, code in diffs is often longer than 7x characters=
, and wrapping, like `git log`, could be done inside git. FWIW, there a=
re a bunch of merge commits with lines longer than 80 characters in the=
 git repo itself.
>=20
> Yes, that standard allows e-mail clients to display the text more flu=
idly, even if the source text is word-wrapped. While git uses e-mail fo=
rmat, it isn't an e-mail client. I always interpreted this whole thing =
as git basically creating plain-text e-mails. You're actually writing t=
he source of the e-mail in your commit message. If you care about actua=
l use in e-mail (like we do here on the list) you might want to add the=
 relevant header to the mails. That said, Apple Mail (the client you us=
ed to send your mail) doesn't even use the RFC you quote in the sent me=
ssage. That mail is going to be a pain in the butt to read in mutt from=
 work ;).
>=20

Sorry, I'm not sure what you mean by, =93If you care about actual use i=
n e-mail (like we do here on the list) you might want to add the releva=
nt header to the mails=94.

Interesting, I didn't realize that Mail didn't use it. It does, however=
, use quoted-printable which, as far as I can tell, has a similar effec=
t on line wrapping. What happens when you view this email in mutt?

>=20
>>=20
>> Finally, people read commits these days in many other places than `g=
it log` (and make commits in many other places than a text editor confi=
gured to wrap). Most every GUI and already word wraps commit messages j=
ust fine. As a result, there are commits in popular repos much longer t=
han the 72-column standard and no one notices. Instead, properly-format=
ted commit messages end up looking cramped when you see them in anywher=
e wider than 80 columns.
>=20
> Cramped? I think it's compact and actually I prefer it over long line=
s.
>=20
>> Am I crazy?
>=20
> Probably not. Don't take my word for it. I'm not a psychiatrist.
>=20
>=20
>> If this makes sense to anyone else, I'd be happy to help massage thi=
s into something git-worthy, with some help (never worked on Git before=
).
>>=20
>> - - -
>>=20
>> From a93b390d1506652d4ad41d1cbd987ba98a8deca0 Mon Sep 17 00:00:00 20=
01
>> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneys=
m.com>
>> Date: Thu, 8 Dec 2011 20:26:23 -0500
>> Subject: [PATCH] Wrap commit messages on display
>>=20
>> - Wrap to 80 characters minus the indent
>> - Use a hanging indent for lines which begin with "- "
>> - Do not wrap lines which begin with whitespace
>> ---
>> pretty.c |   10 ++++++++--
>> 1 files changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/pretty.c b/pretty.c
>> index 230fe1c..15804ce 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1243,8 +1243,14 @@ void pp_remainder(const struct pretty_print_c=
ontext *pp,
>> 			memset(sb->buf + sb->len, ' ', indent);
>> 			strbuf_setlen(sb, sb->len + indent);
>> 		}
>> -		strbuf_add(sb, line, linelen);
>> -		strbuf_addch(sb, '\n');
>> +		if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
>> +			strbuf_add(sb, line, linelen);
>> +		} else {
>> +			struct strbuf wrapped =3D STRBUF_INIT;
>> +			strbuf_add(&wrapped, line, linelen);
>> +			strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + (line[0] =3D=
=3D '-' && line[1] =3D=3D ' ' ? 2 : 0), 80 - indent);
>=20
> While on the subject, In my mail view, the new line started with the =
[1] from line[1], in the quote the line looks entirely different. Now t=
his is code we're talking about, so it makes slightly more sense to hav=
e a proper wrapping hard-coded. Compare the above with the following:
>=20
> +			int hanging_indent =3D ((line[0] =3D=3D '-' && line[1] =3D=3D ' '=
) ? 2 : 0);
> [...]
> +			strbuf_add_wrapped_text(sb, wrapped.buf, 0,
> +									indent + hanging_indent,
> +									80 - indent);
>=20
> Much clearer, no? I personally usually have two or three terminals tu=
cked next to each other, so I can look at two or three things at the sa=
me time. 80 characters limit is a nice feature then.

Good point, that makes it clearer either way. I put an updated patch at=
 the bottom of this email (also fixed forgetting the newline after line=
s with leading whitespace). I hope it's OK to include patches this way,=
 I understand that they're supposed to represent whole emails but want =
to include them with this discussion.

>=20
>=20
>> +			strbuf_addch(sb, '\n');
>> +		}
>> 	}
>> }
>>=20
>=20
> Cheers,
> Frans


=46rom 53fd7deedaf5ac522c9d752e79cf71561cc57f07 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneysm=
=2Ecom>
Date: Thu, 8 Dec 2011 20:26:23 -0500
Subject: [PATCH] Wrap commit messages on display

- Wrap to 80 characters, minus the indent
- Use a hanging indent for lines which begin with "- "
- Do not wrap lines which begin with whitespace
---
 pretty.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 230fe1c..841ccd1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1243,7 +1243,14 @@ void pp_remainder(const struct pretty_print_cont=
ext *pp,
 			memset(sb->buf + sb->len, ' ', indent);
 			strbuf_setlen(sb, sb->len + indent);
 		}
-		strbuf_add(sb, line, linelen);
+		if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
+			strbuf_add(sb, line, linelen);
+		} else {
+			struct strbuf wrapped =3D STRBUF_INIT;
+			strbuf_add(&wrapped, line, linelen);
+			int hanging_indent =3D ((line[0] =3D=3D '-' && line[1] =3D=3D ' ') =
? 2 : 0);
+			strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + hanging_indent=
, 80 - indent);
+		}
 		strbuf_addch(sb, '\n');
 	}
 }
--=20
1.7.8
