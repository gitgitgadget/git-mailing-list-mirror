From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 9 Dec 2011 17:49:40 +0100
Message-ID: <CAH6sp9OCbR_NG-sPn7Eq2d4LYbJAbaPX6rCdZR6rbet_nyaGCA@mail.gmail.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
	<op.v57na7120aolir@keputer>
	<06819C5A-C6D3-4A14-9930-73F66707CE3E@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 17:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ3dw-0005TR-BB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 17:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1LIQtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 11:49:42 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:64184 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab1LIQtl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 11:49:41 -0500
Received: by qadb15 with SMTP id b15so2925856qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=N2I8kSArwVgR3MaE5noKBP90CZAVwTTVQWnr9Pm8ge8=;
        b=H8y7wpTTNAeLQCAB58oZ0fW+VjD1r2tPdnzaYuYkCULVLhMFIWabrKWok0wyJV18zI
         Je/jQBLzqLIKW4+qY583ZrmkfBC3eW6jgQ/C6GuEmsT4y1AecymnWzAa9gxCe5BKsQyZ
         K2p9Wxbk+BH9qtmhG2FuIbyf+2eqYsPw5ebUc=
Received: by 10.224.192.3 with SMTP id do3mr7897819qab.58.1323449380634; Fri,
 09 Dec 2011 08:49:40 -0800 (PST)
Received: by 10.224.76.82 with HTTP; Fri, 9 Dec 2011 08:49:40 -0800 (PST)
In-Reply-To: <06819C5A-C6D3-4A14-9930-73F66707CE3E@sidneysm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186649>

I'm adding git@vger... again, cause there didn't seem to be a reason no=
t to.

On Fri, Dec 9, 2011 at 3:10 PM, Sidney San Mart=C3=ADn <s@sidneysm.com>=
 wrote:
> On Dec 9, 2011, at 2:05 AM, Frans Klaver wrote:
>
>> On Fri, 09 Dec 2011 02:59:06 +0100, Sidney San Mart=C3=ADn <s@sidney=
sm.com> wrote:
>>
>>> Hey, I want to ask about the practice of wrapping commit messages t=
o 70-something charaters.
>>>
>>> The webpage most cited about it, which I otherwise really like, is
>>>
>>> =C2=A0 =C2=A0 =C2=A0http://tbaggery.com/2008/04/19/a-note-about-git=
-commit-messages.html
>>>
>>> *Nothing else* in my everyday life works this way anymore. Line wra=
pping gets done on the display end in my email client, my web browser, =
my ebook reader entirely automatically, and it adapts to the size of th=
e window.
>>
>> Actually, opera-mail autowraps at 72 characters but sets the text fo=
rmat to flowed. It also wraps the quoted text when you reply. But there=
's a reasonable chance that you don't use opera in your daily life. On =
the other hand I would not be surprised if most decent e-mail clients w=
orked that way.
>>
>
> Interesting=E2=80=A6 either way, the end result is that the receiving=
 mail client can wrap the lines to whatever length it (or you, as its o=
perator) desires, which I think we can agree is a good thing, right?
>

Yes.

>> Hm. Saying "that's how the tool works" is not a good reason in my op=
inion. There might be tons of other reasons for wrapping at 80 characte=
rs. Readability is one that comes to mind for me.
>>
>
> That's my basic point. I hope it didn't seem like I was arguing again=
st reading commit messages wrapped to 80 columns, by default. I only wa=
nted to discuss whether it makes more sense to handle it on the display=
 end instead of asking committers to do it in advance.
>

It somewhat looked like that. I think it might make sense for clients
to ignore the line wrapping when they can only show less than 80
characters on a line, but that would probably break the code part of a
patch mail.


> - My phone shows text most comfortably at about 40 characters per lin=
e. I do look at terminals at 80 columns most of the time, but not alway=
s, and I sometimes browse projects in GUI tools that use a proportional=
 font in a window may be narrower or wider than that.
>
> - Right now, when I *am* in an 80-col terminal I have to trust everyo=
ne else to wrap their commit messages. Not everyone does. I feel like i=
t would be more effective to give git the ability to wrap them automati=
cally when I read them.
>

It could be a useful option to wrap when the lines extend the window
width, but I'd actually think it's better to leave that up to the
pager than to git.

>>>
>>> Second:
>>>
>>>> git format-patch --stdout converts a series of commits to a series=
 of emails, using the messages for the message body. Good email netique=
tte dictates we wrap our plain text emails such that there=E2=80=99s ro=
om for a few levels of nested reply indicators without overflow in an 8=
0 column terminal. (The current rails.git workflow doesn=E2=80=99t incl=
ude email, but who knows what the future will bring.)
>>>
>>> There's been a standard for flowed plain text emails (which don't h=
ave to wrap at 80 columns) for well over ten years, RFC-2646 and is wid=
ely supported. Besides, code in diffs is often longer than 7x character=
s, and wrapping, like `git log`, could be done inside git. FWIW, there =
are a bunch of merge commits with lines longer than 80 characters in th=
e git repo itself.
>>
>> Yes, that standard allows e-mail clients to display the text more fl=
uidly, even if the source text is word-wrapped. While git uses e-mail f=
ormat, it isn't an e-mail client. I always interpreted this whole thing=
 as git basically creating plain-text e-mails. You're actually writing =
the source of the e-mail in your commit message. If you care about actu=
al use in e-mail (like we do here on the list) you might want to add th=
e relevant header to the mails. That said, Apple Mail (the client you u=
sed to send your mail) doesn't even use the RFC you quote in the sent m=
essage. That mail is going to be a pain in the butt to read in mutt fro=
m work ;).
>>
>
> Sorry, I'm not sure what you mean by, =E2=80=9CIf you care about actu=
al use in e-mail (like we do here on the list) you might want to add th=
e relevant header to the mails=E2=80=9D.

I thought you might want to have wrapped text in the git commit
messages, but actually put a format flowed tag into the mail header.
I'm not sure what that would do to the code though.


> Interesting, I didn't realize that Mail didn't use it. It does, howev=
er, use quoted-printable which, as far as I can tell, has a similar eff=
ect on line wrapping. What happens when you view this email in mutt?
>

I had no idea quoted printable had any effect on line wrapping. As far
as I know it's just a way to encode non-ascii characters in 7bit, no
more no less. Your current e-mail happens to end lines with =3D<nl>,
which probably handles the wrapping. Your original message didn't have
that.


>>> - - -
>>>
>>> From a93b390d1506652d4ad41d1cbd987ba98a8deca0 Mon Sep 17 00:00:00 2=
001
>>> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidney=
sm.com>
>>> Date: Thu, 8 Dec 2011 20:26:23 -0500
>>> Subject: [PATCH] Wrap commit messages on display
>>>
>>> - Wrap to 80 characters minus the indent
>>> - Use a hanging indent for lines which begin with "- "
>>> - Do not wrap lines which begin with whitespace
>>> ---
>>> pretty.c | =C2=A0 10 ++++++++--
>>> 1 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/pretty.c b/pretty.c
>>> index 230fe1c..15804ce 100644
>>> --- a/pretty.c
>>> +++ b/pretty.c
>>> @@ -1243,8 +1243,14 @@ void pp_remainder(const struct pretty_print_=
context *pp,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0memset(sb->buf + sb->len, ' ', indent);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0strbuf_setlen(sb, sb->len + indent);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_add(sb, line, lin=
elen);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addch(sb, '\n');
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (line[0] =3D=3D ' ' |=
| line[0] =3D=3D '\t') {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0strbuf_add(sb, line, linelen);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct strbuf wrapped =3D STRBUF_INIT;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0strbuf_add(&wrapped, line, linelen);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + (line[0] =3D=3D=
 '-' && line[1] =3D=3D ' ' ? 2 : 0), 80 - indent);
>>
>> While on the subject, In my mail view, the new line started with the=
 [1] from line[1], in the quote the line looks entirely different. Now =
this is code we're talking about, so it makes slightly more sense to ha=
ve a proper wrapping hard-coded. Compare the above with the following:
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int hanging_indent =3D ((line[0] =3D=3D '-' && line[1] =3D=3D ' ') =
? 2 : 0);
>> [...]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_add_wrapped_text(sb, wrapped.buf, 0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 indent + hanging_indent,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 80 - indent);
>>
>> Much clearer, no? I personally usually have two or three terminals t=
ucked next to each other, so I can look at two or three things at the s=
ame time. 80 characters limit is a nice feature then.
>
> Good point, that makes it clearer either way. I put an updated patch =
at the bottom of this email (also fixed forgetting the newline after li=
nes with leading whitespace). I hope it's OK to include patches this wa=
y, I understand that they're supposed to represent whole emails but wan=
t to include them with this discussion.
>

You can include them in the discussion. While it is probably OK to put
some code into your mail to propose something (I've seen it happen
more than once), the end result is supposed to be submitted with a
git-format-patch'd commit. You can read more about contributing in
Documentation/SubmittingPatches.


>>
>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0strbuf_addch(sb, '\n');
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0}
>>> }
>>>
>>
>> Cheers,
>> Frans
>
>
> From 53fd7deedaf5ac522c9d752e79cf71561cc57f07 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneysm=
=2Ecom>
> Date: Thu, 8 Dec 2011 20:26:23 -0500
> Subject: [PATCH] Wrap commit messages on display
>
> - Wrap to 80 characters, minus the indent
> - Use a hanging indent for lines which begin with "- "
> - Do not wrap lines which begin with whitespace
> ---
> =C2=A0pretty.c | =C2=A0 =C2=A09 ++++++++-
> =C2=A01 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 230fe1c..841ccd1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1243,7 +1243,14 @@ void pp_remainder(const struct pretty_print_co=
ntext *pp,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0memset(sb->buf + sb->len, ' ', indent);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0strbuf_setlen(sb, sb->len + indent);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_add(sb, lin=
e, linelen);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (line[0] =3D=3D=
 ' ' || line[0] =3D=3D '\t') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add(sb, line, linelen);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct strbuf wrapped =3D STRBUF_INIT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add(&wrapped, line, linelen);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int hanging_indent =3D ((line[0] =3D=3D '-' && line[1] =3D=3D '=
 ') ? 2 : 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + hanging_in=
dent, 80 - indent);

It's common in C (and in certain flavors even required) to have your
variable declaration at the beginning of the scope:

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int hanging_indent;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct strbuf wrapped =3D STRBUF_INIT;
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add(&wrapped, line, linelen);
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hanging_indent =3D ((line[0] =3D=3D '-' && line[1]
=3D=3D ' ') ? 2 : 0);
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add_wrapped_text(sb, wrapped.buf, 0,
indent + hanging_indent, 80 - indent);


Gmail webclient mucks up the whitespace. Don't copy & paste ;)


As I said earlier in the mail, I'm not sure if this is something that
should be done by git. Maybe someone else can shed some light on that.


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addch(s=
b, '\n');
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> --
> 1.7.8
>
>
