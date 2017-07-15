Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43E32082F
	for <e@80x24.org>; Sat, 15 Jul 2017 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdGOSP6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 14:15:58 -0400
Received: from mout.web.de ([212.227.17.12]:50899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdGOSP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 14:15:58 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUFGo-1d5SXC235m-00R15A; Sat, 15
 Jul 2017 20:15:28 +0200
Subject: Re: [PATCH 04/33] notes: make get_note return pointer to struct
 object_id
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-5-bmwill@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4c10c481-45c9-1b36-d83f-f70adca60bdb@web.de>
Date:   Sat, 15 Jul 2017 20:15:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170530173109.54904-5-bmwill@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ouPXMLx9k7LnCKSp6p87yLKXT1CJBjyNkZpMi+eNPczKu9q54WS
 hUsPcieq9notHzmGKCsGeGFyqPsQWb/M3PPverK3tuEQrNiTGUQMTo/+6I6uvQF6yXBERQs
 svWOebCcbqnVqufTnqWv3SnyG132O/Zps9rFno76SKHjv5FuggLzxXba74WfDfrjaNtbNnI
 V4wofKSwr9bQj7kYqX4Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z+Utj5aczQo=:5Ow7SxoQAsJHqbpCAZqP+g
 AU1aDX7xGgG2jGRbmUoSDgIlfh+tlE9cSp7w2fF9avbkhL+k5MnPiEg7PqrHT8O8VlmboeWvN
 MldedEJuUMafdvTIIuCWsbFMQ38CgaQvx1IkTDJuH+CJfPFdOJzGU07tNoslzABT63S3+itVL
 3U8MOYpXkglnLZeOkK+F9EugqNWKXjKEThXY7+mhRaoRFV6B8iUQvEgQWl8t9GE9Y7wtXhOFs
 wxaV6UlxLbn3OfkA2vVOIc0YHa7VjLGblFXYLhYJit5i67PHk+25G/pMoPUUxFtJXiGWcV71l
 STZVnwBpttFx1sxGfb52p2Pd+oos0nFfrkJs8zzzJK5Bfc3ULqyZ7M08op3YaVAqfRQa3DQUU
 LqNotNCTmQ0QMtMHxrYmy2i5mVXbVY0hQwly7qxzWijMku+7Sl1cj3FU0gLsrTjoKVdnhDBlB
 MTSW5Vop2oAjF50qjLkn+f0U53pWaEIL4JIKuktUKq/Vb9Son+ef6BhK16VjHqP123KoYSngG
 i7BvxKdsMViyuA/nHFt5/m85l3Xmjw9hGFO1TwuYQuGnJbrgac9atR97zrt0AV5G30FSr6Z6E
 wJtMLo+1ZTtwM8tXMhonpY2fbJ5HmnXZozBphkS/xkh6hJvbsG3SJXlj0bnQcbjB91pg3ycdK
 jyaIxI+cVv6/ARmRie50wDuMoHouFgTrka1WWLvV8moyblPHWrKoodrs2Iolcza3fL2k2Pv5O
 vc7i5MYXi5XMgnSyIMpRU2eIwdjdgr47FqBvBJHjU65rIkX91nCt/Rxhu3inBIoqOu3zUQMRC
 epgqtMXx8NgNsJAu0Cf1mFrzl+ynYBnb8RZgM65dx3grGvrpGM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.2017 um 19:30 schrieb Brandon Williams:
> @@ -392,7 +392,7 @@ static int add(int argc, const char **argv, const char *prefix)
>   	const char *object_ref;
>   	struct notes_tree *t;
>   	unsigned char object[20], new_note[20];
> -	const unsigned char *note;
> +	const struct object_id *note;
>   	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
>   	struct option options[] = {
>   		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),

In between here, note can be set to NULL...

> @@ -453,7 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
>   			sha1_to_hex(object));
>   	}
>   
> -	prepare_note_data(object, &d, note);
> +	prepare_note_data(object, &d, note->hash);

... which we then dereference here.

> @@ -598,13 +598,13 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>   	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
>   	note = get_note(t, object);
>   
> -	prepare_note_data(object, &d, edit ? note : NULL);
> +	prepare_note_data(object, &d, edit && note ? note->hash : NULL);

Here a NULL check was added; we need a similar one above as well.

-- >8 --
Subject: [PATCH] notes: don't access hash of NULL object_id pointer

Check if note is NULL, as we already do for different purposes a few
lines above, and pass a NULL pointer to prepare_note_data() in that
case instead of trying to access the hash member.

Found with Clang's UBSan.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The third parameter of prepare_note_data() could easily be turned into
an object_id pointer (and it should), but this patch is meant to be a
minimal fix.

 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 77573cf1ea..4303848e04 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -456,7 +456,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			oid_to_hex(&object));
 	}
 
-	prepare_note_data(&object, &d, note->hash);
+	prepare_note_data(&object, &d, note ? note->hash : NULL);
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note.hash);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
-- 
2.13.3
