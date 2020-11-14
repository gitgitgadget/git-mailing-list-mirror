Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691AC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154BB222EA
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OB7iQROS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKNXlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 18:41:00 -0500
Received: from mout.web.de ([212.227.15.4]:55009 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKNXk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 18:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605397251;
        bh=dZ34y/8JHdF3GOxt+wg+XcTHWNwOW8YMDTVh5Ac+DHQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OB7iQROSyDFQD9G1noM89ngBByPp/crndntZgs+4MA5RXBvwqw9Ezs6dqDJ4smXZE
         HRVjOTriyvH704R/0NIxftxdNwolAsZh2oyT9tJpqQbIDZ9SD8T4KuqAeUvyqjBHrD
         DCnA//LLjFaHsw1BJ11lrFKiMSApWIwqu/jKdOWY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ldmkd-1jx0iW2f0F-00izga; Sun, 15
 Nov 2020 00:40:51 +0100
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?Gr=c3=a9goire_PARIS?= <postmaster@greg0ire.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
 <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
 <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr>
 <CAN0heSr9=_So-sUhQN86vawBEkJhnrHHsd3OcSYZMZ-idZGFAQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5a2d70eb-da75-ff59-8ac1-6ba81e1632da@web.de>
Date:   Sun, 15 Nov 2020 00:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSr9=_So-sUhQN86vawBEkJhnrHHsd3OcSYZMZ-idZGFAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4P86d7/3abyGcNrv2HeqB76pK/T1rbxp3Mu5ZDgpgFAyi8n7g5s
 Si+hvaF+vu6yOGQUqFCYRZxOKftdABJQNun+gt7/3loXzVnkHQhJJMQjXic3zLALyZiTx8R
 C2IX/PKCTW4xW/aFkDDg4Q8MBkzuiLNumRcIAFAilD1G1n9/dip1flyvtFrqI0qni+AoFIl
 HX3f0IHLtb02I7RvWmm2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L4DRsLH19Bo=:YzT09MLFMfdqSFMHDfmRlI
 /tlosZ24/XIpvRhCpXMsgksWbfcVhCqT6fRj9kJxaX/1/Y9fJOZr/066Cqg/7UqDgCQv4NPD+
 88it96LkCoIq0we2KpTiDaEWFVgMgsoGNpus9GPmtmzA55O3rXh2Lgg63aH5Fq42MunnG65dN
 JcWQP+qMv9d/hxbBLhd41htMhw+Y0xB/DHDICc3Ndn5wFc0iA2s8rRGga3gRrQXrH83wSEDOy
 r9Ndix+CidmwE6lGT+RUaboYqApO/6sw7iuo6UKqQkTShxy482yrkK31W/j41DEllwQKDUBAY
 iwt81opf4E6cgqVxKeTdCqKqRmTWgJMluwsWQ5ZQdMKMkuVM42Hczi0LtxuFLQXJluXtflIfH
 VXSDHNicDKZs2c4v6NsVYjcVw9qVY5giDWJKQdpCJ3g1ZMxn8HFDfqR40AYALppyOydIjwDUU
 NBr0WyyoUJ3e7J7frrFzz6q8sQaPdTKcI5XfnuT/bTCED1g8lOYKm0eo7aQtcQenCCRILjaCs
 b5B4B14q70c1N2K/xwmwmDepDn8YN8VyDc3xanV4pnRzKFsw7KbTgdY1pZCWA65xLkUGfSL0M
 tlXZ8EbF/q+01g8wKWamWpb9MdaufeoA6swMe49JZ/Atis/p288oWHpsoDbx/tjpsdB99BF0c
 fIwu6OoWgsn/k2B/p771c+YUFDCdKiIY6erJnxjUP/uuR0PmWZhJmgYU+7CzVpbhfbR0V2Ev4
 owxiq3ceQhjxVVVxq236d6GwrCYJRt0z6O4Ve2Ic07VuzFzNouaN2/naQm2wQ8k+YQMwSmNtt
 +klG6Ga1JyTaWpc8AVl6eN42xltm2soc8HiX8gIUHszlvorkwKFQVzlh5z5IfAzFKkslh8nVj
 V6iqwb5o2KBlLjMJ6fTw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.20 um 18:35 schrieb Martin =C3=85gren:
> Hi,
>
> On Sat, 14 Nov 2020 at 16:55, Gr=C3=A9goire PARIS <postmaster@greg0ire.f=
r> wrote:
>
>>> In the end I think your best option right now is to give explicit line
>>> numbers for <end> and <start>.
>> That is indeed what I currently do, I plugged that to vim's visual
>> selection with
>>
>>    vnoremap <leader>l :<c-u>exe '!git log -L'
>> line("'<").','.line("'>").':'.expand('%')<CR>
>>
>> and it works great!
>
> Great!
>
>> I also suppose the issue is the same for any other language that has
>> documentation above function declarations.
>
> Yeah, you'll see the same thing for C files, e.g., using this in the
> repo of Git itself:
>
>   git log -L :strbuf_swap:strbuf.h
>
> It will follow the lines from the function definition all the way down
> to the next function, but just as you saw in your example, it will not
> match the comment immediately *before* the function. That is, these
> lines will be followed:
>
>   https://github.com/git/git/blob/v2.29.2/strbuf.h#L125-L138

The --function-context options of git diff and git grep try to show
comments by including non-empty lines before function lines.  This
heuristic might work for -L :funcname:file as well (patch below), but
breaks seven tests in each of t8001-annotate.sh, t8002-blame.sh and
t8012-blame-colors.sh.

Ren=C3=A9

=2D--
 line-range.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/line-range.c b/line-range.c
index 9b50583dc0..5d55fa255f 100644
=2D-- a/line-range.c
+++ b/line-range.c
@@ -163,6 +163,13 @@ static const char *find_funcname_matching_regexp(xdem=
itconf_t *xecfg, const char
 	}
 }

+static int is_empty_line(const char *bol, const char *eol)
+{
+	while (bol < eol && isspace(*bol))
+		bol++;
+	return bol =3D=3D eol;
+}
+
 static const char *parse_range_funcname(
 	const char *arg, nth_line_fn_t nth_line_cb,
 	void *cb_data, long lines, long anchor, long *begin, long *end,
@@ -233,6 +240,18 @@ static const char *parse_range_funcname(
 		(*end)++;
 	}

+	/*
+	 * Include non-empty, non-funcname lines before the found
+	 * funcname line, as they probably contain related comments.
+	 */
+	while (*begin > 0) {
+		const char *bol =3D nth_line_cb(cb_data, *begin - 1);
+		const char *eol =3D nth_line_cb(cb_data, *begin);
+		if (is_empty_line(bol, eol) || match_funcname(xecfg, bol, eol))
+			break;
+		(*begin)--;
+	}
+
 	regfree(&regexp);
 	free(xecfg);
 	free(pattern);
=2D-
2.29.2
