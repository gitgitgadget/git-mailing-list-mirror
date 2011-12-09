From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 9 Dec 2011 12:49:54 -0500
Message-ID: <00161EBB-80FC-4593-96FE-D091EDBF0AD5@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <op.v57na7120aolir@keputer> <06819C5A-C6D3-4A14-9930-73F66707CE3E@sidneysm.com> <CAH6sp9OCbR_NG-sPn7Eq2d4LYbJAbaPX6rCdZR6rbet_nyaGCA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 18:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ4a7-0006T8-AX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 18:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1LIRty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 12:49:54 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:47150 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1LIRtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 12:49:53 -0500
Received: by qadb15 with SMTP id b15so3010511qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=WpRhLjHf/QPg2UWPa3+qy424CcR0qwtP1QTnHymTziw=;
        b=brBWYTYgospoHXhYXNOf9khpW7/HUeLvS8qVqwN5cnh4okBsVD1gW7oQBiGJDWg6rC
         tjgVJcVKhG+XpXrX+XHPpfiBhVqYS/2LRXebXl2nwsPuZxJBrIxA+4nJIVhqzTnUSqLw
         aRVnO3TcSAu++7T9bRQYh2v0Ywg30GCssAdb4=
Received: by 10.224.211.194 with SMTP id gp2mr7992385qab.99.1323452992539;
        Fri, 09 Dec 2011 09:49:52 -0800 (PST)
Received: from [172.20.1.57] (rrcs-184-75-21-194.nyc.biz.rr.com. [184.75.21.194])
        by mx.google.com with ESMTPS id i10sm17807615qac.17.2011.12.09.09.49.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 09:49:51 -0800 (PST)
In-Reply-To: <CAH6sp9OCbR_NG-sPn7Eq2d4LYbJAbaPX6rCdZR6rbet_nyaGCA@mail.gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186655>

Ah, thank you!

On Dec 9, 2011, at 11:49 AM, Frans Klaver wrote:

> I'm adding git@vger... again, cause there didn't seem to be a reason =
not to.
>=20
> On Fri, Dec 9, 2011 at 3:10 PM, Sidney San Mart=EDn <s@sidneysm.com> =
wrote:
>> On Dec 9, 2011, at 2:05 AM, Frans Klaver wrote:
>>=20
>>> On Fri, 09 Dec 2011 02:59:06 +0100, Sidney San Mart=EDn <s@sidneysm=
=2Ecom> wrote:
>>>=20
>>>> Hey, I want to ask about the practice of wrapping commit messages =
to 70-something charaters.
>>>>=20
>>>> The webpage most cited about it, which I otherwise really like, is
>>>>=20
>>>>      http://tbaggery.com/2008/04/19/a-note-about-git-commit-messag=
es.html
>>>>=20
>>>> *Nothing else* in my everyday life works this way anymore. Line wr=
apping gets done on the display end in my email client, my web browser,=
 my ebook reader entirely automatically, and it adapts to the size of t=
he window.
>>>=20
>>> Actually, opera-mail autowraps at 72 characters but sets the text f=
ormat to flowed. It also wraps the quoted text when you reply. But ther=
e's a reasonable chance that you don't use opera in your daily life. On=
 the other hand I would not be surprised if most decent e-mail clients =
worked that way.
>>>=20
>>=20
>> Interesting=85 either way, the end result is that the receiving mail=
 client can wrap the lines to whatever length it (or you, as its operat=
or) desires, which I think we can agree is a good thing, right?
>>=20
>=20
> Yes.
>=20
>>> Hm. Saying "that's how the tool works" is not a good reason in my o=
pinion. There might be tons of other reasons for wrapping at 80 charact=
ers. Readability is one that comes to mind for me.
>>>=20
>>=20
>> That's my basic point. I hope it didn't seem like I was arguing agai=
nst reading commit messages wrapped to 80 columns, by default. I only w=
anted to discuss whether it makes more sense to handle it on the displa=
y end instead of asking committers to do it in advance.
>>=20
>=20
> It somewhat looked like that. I think it might make sense for clients
> to ignore the line wrapping when they can only show less than 80
> characters on a line, but that would probably break the code part of =
a
> patch mail.
>=20
>=20
>> - My phone shows text most comfortably at about 40 characters per li=
ne. I do look at terminals at 80 columns most of the time, but not alwa=
ys, and I sometimes browse projects in GUI tools that use a proportiona=
l font in a window may be narrower or wider than that.
>>=20
>> - Right now, when I *am* in an 80-col terminal I have to trust every=
one else to wrap their commit messages. Not everyone does. I feel like =
it would be more effective to give git the ability to wrap them automat=
ically when I read them.
>>=20
>=20
> It could be a useful option to wrap when the lines extend the window
> width, but I'd actually think it's better to leave that up to the
> pager than to git.
>=20
>>>>=20
>>>> Second:
>>>>=20
>>>>> git format-patch --stdout converts a series of commits to a serie=
s of emails, using the messages for the message body. Good email netiqu=
ette dictates we wrap our plain text emails such that there=92s room fo=
r a few levels of nested reply indicators without overflow in an 80 col=
umn terminal. (The current rails.git workflow doesn=92t include email, =
but who knows what the future will bring.)
>>>>=20
>>>> There's been a standard for flowed plain text emails (which don't =
have to wrap at 80 columns) for well over ten years, RFC-2646 and is wi=
dely supported. Besides, code in diffs is often longer than 7x characte=
rs, and wrapping, like `git log`, could be done inside git. FWIW, there=
 are a bunch of merge commits with lines longer than 80 characters in t=
he git repo itself.
>>>=20
>>> Yes, that standard allows e-mail clients to display the text more f=
luidly, even if the source text is word-wrapped. While git uses e-mail =
format, it isn't an e-mail client. I always interpreted this whole thin=
g as git basically creating plain-text e-mails. You're actually writing=
 the source of the e-mail in your commit message. If you care about act=
ual use in e-mail (like we do here on the list) you might want to add t=
he relevant header to the mails. That said, Apple Mail (the client you =
used to send your mail) doesn't even use the RFC you quote in the sent =
message. That mail is going to be a pain in the butt to read in mutt fr=
om work ;).
>>>=20
>>=20
>> Sorry, I'm not sure what you mean by, =93If you care about actual us=
e in e-mail (like we do here on the list) you might want to add the rel=
evant header to the mails=94.
>=20
> I thought you might want to have wrapped text in the git commit
> messages, but actually put a format flowed tag into the mail header.
> I'm not sure what that would do to the code though.
>=20
>=20
>> Interesting, I didn't realize that Mail didn't use it. It does, howe=
ver, use quoted-printable which, as far as I can tell, has a similar ef=
fect on line wrapping. What happens when you view this email in mutt?
>>=20
>=20
> I had no idea quoted printable had any effect on line wrapping. As fa=
r
> as I know it's just a way to encode non-ascii characters in 7bit, no
> more no less. Your current e-mail happens to end lines with =3D<nl>,
> which probably handles the wrapping. Your original message didn't hav=
e
> that.
>=20
>=20
>>>> - - -
>>>>=20
>>>> From a93b390d1506652d4ad41d1cbd987ba98a8deca0 Mon Sep 17 00:00:00 =
2001
>>>> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidne=
ysm.com>
>>>> Date: Thu, 8 Dec 2011 20:26:23 -0500
>>>> Subject: [PATCH] Wrap commit messages on display
>>>>=20
>>>> - Wrap to 80 characters minus the indent
>>>> - Use a hanging indent for lines which begin with "- "
>>>> - Do not wrap lines which begin with whitespace
>>>> ---
>>>> pretty.c |   10 ++++++++--
>>>> 1 files changed, 8 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/pretty.c b/pretty.c
>>>> index 230fe1c..15804ce 100644
>>>> --- a/pretty.c
>>>> +++ b/pretty.c
>>>> @@ -1243,8 +1243,14 @@ void pp_remainder(const struct pretty_print=
_context *pp,
>>>>                      memset(sb->buf + sb->len, ' ', indent);
>>>>                      strbuf_setlen(sb, sb->len + indent);
>>>>              }
>>>> -            strbuf_add(sb, line, linelen);
>>>> -            strbuf_addch(sb, '\n');
>>>> +            if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
>>>> +                    strbuf_add(sb, line, linelen);
>>>> +            } else {
>>>> +                    struct strbuf wrapped =3D STRBUF_INIT;
>>>> +                    strbuf_add(&wrapped, line, linelen);
>>>> +                    strbuf_add_wrapped_text(sb, wrapped.buf, 0, i=
ndent + (line[0] =3D=3D '-' && line[1] =3D=3D ' ' ? 2 : 0), 80 - indent=
);
>>>=20
>>> While on the subject, In my mail view, the new line started with th=
e [1] from line[1], in the quote the line looks entirely different. Now=
 this is code we're talking about, so it makes slightly more sense to h=
ave a proper wrapping hard-coded. Compare the above with the following:
>>>=20
>>> +                     int hanging_indent =3D ((line[0] =3D=3D '-' &=
& line[1] =3D=3D ' ') ? 2 : 0);
>>> [...]
>>> +                     strbuf_add_wrapped_text(sb, wrapped.buf, 0,
>>> +                                                                  =
   indent + hanging_indent,
>>> +                                                                  =
   80 - indent);
>>>=20
>>> Much clearer, no? I personally usually have two or three terminals =
tucked next to each other, so I can look at two or three things at the =
same time. 80 characters limit is a nice feature then.
>>=20
>> Good point, that makes it clearer either way. I put an updated patch=
 at the bottom of this email (also fixed forgetting the newline after l=
ines with leading whitespace). I hope it's OK to include patches this w=
ay, I understand that they're supposed to represent whole emails but wa=
nt to include them with this discussion.
>>=20
>=20
> You can include them in the discussion. While it is probably OK to pu=
t
> some code into your mail to propose something (I've seen it happen
> more than once), the end result is supposed to be submitted with a
> git-format-patch'd commit. You can read more about contributing in
> Documentation/SubmittingPatches.
>=20
>=20
>>>=20
>>>=20
>>>> +                    strbuf_addch(sb, '\n');
>>>> +            }
>>>>      }
>>>> }
>>>>=20
>>>=20
>>> Cheers,
>>> Frans
>>=20
>>=20
>> From 53fd7deedaf5ac522c9d752e79cf71561cc57f07 Mon Sep 17 00:00:00 20=
01
>> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneys=
m.com>
>> Date: Thu, 8 Dec 2011 20:26:23 -0500
>> Subject: [PATCH] Wrap commit messages on display
>>=20
>> - Wrap to 80 characters, minus the indent
>> - Use a hanging indent for lines which begin with "- "
>> - Do not wrap lines which begin with whitespace
>> ---
>>  pretty.c |    9 ++++++++-
>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/pretty.c b/pretty.c
>> index 230fe1c..841ccd1 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1243,7 +1243,14 @@ void pp_remainder(const struct pretty_print_c=
ontext *pp,
>>                        memset(sb->buf + sb->len, ' ', indent);
>>                        strbuf_setlen(sb, sb->len + indent);
>>                }
>> -               strbuf_add(sb, line, linelen);
>> +               if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
>> +                       strbuf_add(sb, line, linelen);
>> +               } else {
>> +                       struct strbuf wrapped =3D STRBUF_INIT;
>> +                       strbuf_add(&wrapped, line, linelen);
>> +                       int hanging_indent =3D ((line[0] =3D=3D '-' =
&& line[1] =3D=3D ' ') ? 2 : 0);
>> +                       strbuf_add_wrapped_text(sb, wrapped.buf, 0, =
indent + hanging_indent, 80 - indent);
>=20
> It's common in C (and in certain flavors even required) to have your
> variable declaration at the beginning of the scope:
>=20
> +               } else {
> +                       int hanging_indent;
> +                       struct strbuf wrapped =3D STRBUF_INIT;
> +                       strbuf_add(&wrapped, line, linelen);
> +                       hanging_indent =3D ((line[0] =3D=3D '-' && li=
ne[1]
> =3D=3D ' ') ? 2 : 0);
> +                       strbuf_add_wrapped_text(sb, wrapped.buf, 0,
> indent + hanging_indent, 80 - indent);
>=20
>=20
> Gmail webclient mucks up the whitespace. Don't copy & paste ;)
>=20
>=20
> As I said earlier in the mail, I'm not sure if this is something that
> should be done by git. Maybe someone else can shed some light on that=
=2E
>=20
>=20
>> +               }
>>                strbuf_addch(sb, '\n');
>>        }
>>  }
>> --
>> 1.7.8
>>=20
>>=20
