Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E3BC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359780AbiATKaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:30:24 -0500
Received: from mout.web.de ([212.227.17.12]:41245 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376279AbiATKaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 05:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642674616;
        bh=pALSBTdAwcEFu1ju+Tq/ZkG9eDe8RYCT1PVd1hGqZ1c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iveoXg0AdDRtlRd/OIs//2EfLFcCcJyr/SM5hWTzy7SGf/Bgkn5jepzEoEcWuPY2k
         n0S8tRaUiS8Qtp31EeVIwO9+EFqVE9V0hKLnT+rgiPnq0VrCAYaSipb657OrXfuUPz
         xLmjGPCr67XUgsR6yeMWCKNq/TquI26wTkt1aWrI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1n00J80yXy-00Bt9x; Thu, 20
 Jan 2022 11:30:16 +0100
Message-ID: <c6ab4408-1091-4d14-849e-afe5f3053e8b@web.de>
Date:   Thu, 20 Jan 2022 11:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <xmqqh7a0r87q.fsf@gitster.g> <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
 <xmqqlezboakd.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqlezboakd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:scPO9cUeX97XXIiTekfcl1Ga7QzmiJYNrzjNNpw/CqtavT+YgKJ
 BtSFhlcHRZhSv4kW32+L6Mw5liqrqbPAgz1HJ20/pROXFez3VgVoPji+ppAM+qsIZhv9+di
 6yI6XCFj7B1fJlJMC3QsYMvsZWzw6vUmMPwonltaJPRbAGFMtyNKe9lt7kn5h7dHd9DtGwQ
 hj68zIZeiyYCGeswRsy7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pb1xKdaGTTk=:LjptOcHkzQ1HIWvD1j9mZw
 HVsQj5BgpBwcMUPnv2i0WCCEb/0QTkfzQva5+/ec9R6t+LnYxhicfZ22vS3j6djKtxZFjIbOK
 sa24f6M5xZbIZ2HgkYxQXh17IDqBMYz30GjWBvbSeF3Zajh34NVp7kxTtcR6U0537Epl16JJl
 9tf7tMS5iufSo615VDKbg6ipNzEIVb1/0DAeEbCetmOnAGwIQvl9/LgtCvrbjLbDkF27rIoSv
 4+QYqVSOdKos8AHBy9mTZ97pk+Qqf2QvaU0Lg4T0dsb4elT5R/mT4EVgdSMm13q2zZWUrJFuN
 DU0J315Ur1nc4bDVptcJg2iK9XMWGKXA2HQJAMBBq22g2kftdQPqiio3M4Z/w/SsyJkTQhTLG
 NKdn096pGjlHKKpQgWIHayOLwTDPglGnxljshQpLZ1TNeLRfJBCbhVrz+a/HrNjyxr9l0olAB
 bRkhIREf8+eMrTIU1Xml+8seX+CACX9+CemT2t16g/k0NRThpF3U4D331XdbDr9qsw9ORiCZB
 BUg/0IGfULOzL5wA+lkBw0YSaEKLUr3nmkvaZQYWBE/VNQG8Cdz2fD7O7jUD/mv0fR/5GDgaK
 kTjogf2hlO58kS5zMStRgxVIuwvRqMm53LjRObkqUlQoBo5IvQpymKGO4tGKOfupLJHeWWZRU
 cKvthhZ0tbjWeu5hEx3IiZXTbx0uKq0jEK2YhWM5dJG6314+K/UmpbXaI9yS5K3r7/LxozYxd
 BYCEQHTIvotkoCKC1xJmNRxMrEOyIWvadtxjLUl8f1FjW51NEu2NsgHD4+afEhuIiWHp26kU0
 h5jqQK5t5H9DYKylV6hqlZ/iKMW2Ei2wQgDcoij0E6XTPE6r8DFiZbTIbh+ddZMVc3WiE2LYU
 0DIIw5B1wI2hQ2a0BoQ1uAGzM5SS//x6HViGKQTogFYu94iONfBh4TIOl/3Sz2wu6j2aCFoYh
 5jviv91qSkRJA9Qn4ses9ZZKKZtr2VUWkGpmSoLTfzSFss53f6bNwIQX39Q9On90DuH3bk8wd
 LlOnlRHYhpYHwUsDSBpaxjZf22Y3vTS45TCcEhdrfpSVaCqdC9RUb+VEonh0rcOhygZJxO5dt
 OuWAcvC80DiH/g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.22 um 19:16 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The help strings for arguments are enclosed in angle brackets
>> automatically.  E.g. if argh is specified as "name", "--option <name>"
>> is printed, to indicate that users need to supply an actual name.  The
>> flag PARSE_OPT_LITERAL_ARGHELP turns this off, so that "--option name"
>> is printed instead, to indicate that the literal string needs to be
>> supplied -- a rare case.
>>
>> This flag is enabled automatically if argh contains special characters
>> like brackets.  The developer is supposed to provide any required angle
>> brackets for more complicated cases.  E.g. if argh is "<start>,<end>"
>> then "--option <start>,<end>" is printed.
>
> The above does explain why we want to have this change very well,
> but at least some of it would help those who are reading the comment
> we touch.
>
>> Add a comment to mention this PARSE_OPT_LITERAL_ARGHELP behavior.
>
> But instead, the addition is only about when the flag bit is turned
> on automatically.  Without understanding your
>
>     E.g. if argh is specified as "name", "--option <name>" is
>     printed, to indicate that users need to supply an actual name.
>
> readers would not quite get from the current description "says that
> argh shouldn't be enclosed in brackets" when/why it is a good idea
> to add the option, I am afraid.
>
>> Also remove the flag from option definitions for which it's inferred
>> automatically.
>
> I am not sure if this is a good move.
>
> Because these places explicitly gave PARSE_OPT_LITERAL_ARGHELP, it
> was easy to grep for them when I was trying to find an existing
> practice.
>
> Imagine, after we remove these redundant flags, we see a patch that
> wants to change the set of characters that automatically flips the
> flag bit on.  It is clear from the patch text why it helps one
> particular OPT_STRING() or whatever the same patch adds, but how
> would you make sure it will not regress _existing_ OPT_WHATEVER()
> that do not use PARSE_OPT_LITERAL_ARGHELP because their argh happens
> to use the character that wasn't special before?

Building a multi-line regex or going through the output of --help-all of
all commands or adding a throwaway internal option to just print argh
would certainly be much harder.

Reducing the set of special characters would be part of a change to the
notation for describing options.  Perhaps we'd want to no longer use
grouping and thus get rid of parentheses.  That would require updating
all affected manpages and usage strings as well -- quite a big effort,
regardless of PARSE_OPT_LITERAL_ARGHELP's grepability.

Extending the set, e.g. to give special meaning to curly brackets, can't
rely on the explicit flag; all argh strings need to be examined to check
whether they become special.

>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Somehow I feel this is not enough, but I can't pin down what's
>> missing.
>
> Let me try.
>
>>   *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed i=
n brackets
>>   *				(i.e. '<argh>') in the help message.
>>   *				Useful for options with multiple parameters.
>> + *				Automatically enabled if argh contains any
>> + *				of the following characters: ()<>[]|
>>   *   PARSE_OPT_NOCOMPLETE: by default all visible options are completa=
ble
>>   *			   by git-completion.bash. This option suppresses that.
>>   *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
>
> PARSE_OPT_LITERAL_ARGHELP: in short-help given by "git cmd -h", the
> 			   "argh" member of the struct option is
> 			   shown in a pair of angle brackets (e.g.
> 			   "--option=3D<argh>"); this flag tells the
> 			   machinery not to add these brackets, to
> 			   give more control to the developer.  E.g.
> 			   "<start>,<end>" given to argh is shown as
> 			   "--option=3D<start>,<end>".
>
> That may be a bit too much, but on the other hand, among PARSE_OPT_X
> descriptions, this is the only one that needs to talk about help
> text on the argument to the option.
>
> Or we can flip it the other way, perhaps?
>
> 	Tell the machinery to give "argh" member literally in the
> 	short-help in "git cmd -h" output for the option.  E.g. {
> 	.argh =3D "(diff|raw)", .long_name =3D "show" } would give
> 	"--show=3D(diff|raw)".  Without the flag, "argh" is enclosed
> 	in a pair of angle brackets.
>
> I dunno.

Now that I read the whole comment, I think the right place to introduce
the automatic brackets is the description of argh some lines up.

=2D-- >8 ---
Subject: [PATCH 5/5] parse-options: document bracketing of argh

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parse-options.h b/parse-options.h
index e22846d3b7..88d589d159 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -85,6 +85,11 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct pa=
rse_opt_ctx_t *ctx,
  *   token to explain the kind of argument this option wants. Does not
  *   begin in capital letter, and does not end with a full stop.
  *   Should be wrapped by N_() for translation.
+ *   Is automatically enclosed in brackets when printed, unless it
+ *   contains any of the following characters: ()<>[]|
+ *   E.g. "name" is shown as "<name>" to indicate that a name value
+ *   needs to be supplied, not the literal string "name", but
+ *   "<start>,<end>" and "(this|that)" are printed verbatim.
  *
  * `help`::
  *   the short help associated to what the option does.
=2D-
2.34.1
