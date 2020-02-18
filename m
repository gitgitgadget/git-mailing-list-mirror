Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91AEC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9FD2464E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y0RZqkf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRTYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:24:14 -0500
Received: from mout.web.de ([212.227.17.12]:50967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgBRTYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582053844;
        bh=/8hPCBjcirRLGgPb3S6O7wILYbGdxA7G0NwVdqN1aSM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y0RZqkf715/cS2F2P4bEBENP8jnXiIDrdSFjh1EUTnf6devC16bKV2bged1+5XPbY
         tbwACSRpOoqjQ3oTBNzIdYTrSuhOtFxeO9C3fxQ7Fg49/bEwpN57Boo1ffSR+wBmWT
         dDcVygh0qoGmiouzDSKcAEIcSazJ9Bo9arEQQHEE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGiUP-1jHYby3T3R-00DacV; Tue, 18
 Feb 2020 20:24:03 +0100
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
To:     Manish Devgan <manish.nsit8@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
 <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de>
 <CABVXwf404m9FdsoLxYxZriYT6uif_fsMs8B4dY4RmeQojqK9Wg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de>
Date:   Tue, 18 Feb 2020 20:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CABVXwf404m9FdsoLxYxZriYT6uif_fsMs8B4dY4RmeQojqK9Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pCNOvvT6ggp4Xj/G3pnlLhFIqOGZJrbkLUq1N99WhENBKhdeYBg
 TOm5+j5PH1kdCqnJ8/LuSQyhK3SUkbkdRB5dGF2jw5imrEwe5W/VBnOi6BWFH6dXF6eNlew
 IhLY4PX4V6l+AScpnGpJM7M9hPSaEtyT92m9t5fhHngsLM+d9P/tPPLxZvkdHaKk0p9byoa
 ZJ1RD8tQdw6GlnyFxUNdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TKIZ+QzoxYA=:mqGx9l9KTqslelpQWU/qUq
 1D398cFCbZEhnoRIJ+BidAzypAA/z2LsGZCG4mfMJQptJTu6cme6JeSWkLzQJBQX6oytaFcgY
 upxJagfl2J37LVwI4BGcnozPWqOLnEJeLq+YK0oOM3AX8f4dJOHV1kh3mB9dz2k+c27OqajJI
 anubjb8ckS6pPORunW8hdxgHK5loI5ycniwuEFtuhhlwwcqO+93SU2AuNbjz+5V1QUlEpHBeI
 nAEGhhM6BkFxbRDa/hO3pUPtfZDOw1/K52Gav+geXzjRnXKQ6f2/kLyTIuWAglRKBYJAp68X0
 5mWbrIGCkvlPMq/34uHvxjdvQzQ/QgCCL5ot4EMssg/qdNfB5CmiaTEoez2zCQp5N5NVyt1LO
 c24P9xOvaFFTMv2c9ic1fouNHCKlGYbpzGc5i1pJTiEpGr7VcbvUe7s3bwtdAHeCzG369LLXT
 DJAEECvmokv1P6Q9NX9kmT2+g8g0nxgX3InWrEYUSqHNRe0FkAX1IYbgE5ZsKEcm/GkiHKmpN
 izeZjzPvkMZ1YYmaJ5ZR/L7Pv2EO0jEl9kLmi/yJ6kbUH9GyQngXUsr0oXAPpmci2+dJqsOae
 z4RMr5+vR1JESk5KXeOF33fP/N1vLHb2P/BZ8n6CSzFtrLkNJ0mcmSR4Z/hJJ1cUTsd+91NNq
 fvyX7vIOvPnlnKueZyl+TdsLPmMNjZQBRzhkHDjLnjugMQx9ftDddsSbLcTvkqxAA8rUFemoh
 tmu1EQk4Ef64y7KJEo/XwH8zCK7E9/YnbwwKZaS3tO5Dg741heEJE8iyTPlexraEcWx6PHXIU
 T0843dx1/qhSrxxjG1ubmbPW0oBrU52oW0FhXpDlTjZKgJ0/uaoPxxdTPT4hvnAkDMM9l2gCy
 cgHgZ7abhRwypDzumD0RYcy3UAtqpES+L7sL416/CriRtPzo6+57SVuEhPbuau8BK/JN2IxwU
 onAAaXPqbjJv2om2wdSzg+jsVTIxu2uVSS+7Me5dsL8sa1gtIi+CcXsUHZxgMBiOVygOAq1e2
 p0F4HItf3hSHOI+VvX6V/sRmD0frMOxUWrWwq94lI9s4dC0OyXPyV8WbdzU2xGglV5k/vj9Mc
 S/tDy54ogVzwpzl24ygNSct3PPeldwGuiUto9BFricrOgE5+Wq3jxVAmSkvxA/VPkLGacg3Cb
 JrWbHYiGWkXJ3GrvO+pchxug5TKR7uYCvhftCJjWGm5QANWD0nfKgoKzPvR7X0a+7Mn3cfMkc
 R46zPE/rfR9xnHtC7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.20 um 12:25 schrieb Manish Devgan:
> The -vvv option puts out a great deal of stuff on my terminal which is
> a sort of assurance that the command is working but it seems to print
> huge loads of text which definitely does not make any sense to me at
> least. I'd be more happy to see as you mentioned, a number or perhaps
> a spinning wheel
> which denotes that the command is working.

How about something like this?

=2D- >8 --
Subject: [PATCH] remote-curl: show progress for fetches over dumb HTTP

Fetching over dumb HTTP transport doesn't show any progress, even with
the option --progress.  If the connection is slow or there is a lot of
data to get then this can take a long time while the user is left to
wonder if git got stuck.

We don't know the number of objects to fetch at the outset, but we can
count the ones we got.  Show an open-ended progress indicator based on
that number if the user asked for it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote-curl.c |  1 +
 walker.c      | 13 ++++++++++++-
 walker.h      |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 8eb96152f5..e4cd321844 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -1026,6 +1026,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_=
fetch)

 	walker =3D get_http_walker(url.buf);
 	walker->get_verbosely =3D options.verbosity >=3D 3;
+	walker->get_progress =3D options.progress;
 	walker->get_recover =3D 0;
 	ret =3D walker_fetch(walker, nr_heads, targets, NULL, NULL);
 	walker_free(walker);
diff --git a/walker.c b/walker.c
index bb010f7a2b..4984bf8b3d 100644
=2D-- a/walker.c
+++ b/walker.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
+#include "progress.h"

 static struct object_id current_commit_oid;

@@ -162,6 +163,11 @@ static int process(struct walker *walker, struct obje=
ct *obj)
 static int loop(struct walker *walker)
 {
 	struct object_list *elem;
+	struct progress *progress =3D NULL;
+	uint64_t nr =3D 0;
+
+	if (walker->get_progress)
+		progress =3D start_delayed_progress(_("Fetching objects"), 0);

 	while (process_queue) {
 		struct object *obj =3D process_queue->item;
@@ -176,15 +182,20 @@ static int loop(struct walker *walker)
 		 */
 		if (! (obj->flags & TO_SCAN)) {
 			if (walker->fetch(walker, obj->oid.hash)) {
+				stop_progress(&progress);
 				report_missing(obj);
 				return -1;
 			}
 		}
 		if (!obj->type)
 			parse_object(the_repository, &obj->oid);
-		if (process_object(walker, obj))
+		if (process_object(walker, obj)) {
+			stop_progress(&progress);
 			return -1;
+		}
+		display_progress(progress, ++nr);
 	}
+	stop_progress(&progress);
 	return 0;
 }

diff --git a/walker.h b/walker.h
index 6d8ae00e5b..d40b016bab 100644
=2D-- a/walker.h
+++ b/walker.h
@@ -10,6 +10,7 @@ struct walker {
 	int (*fetch)(struct walker *, unsigned char *sha1);
 	void (*cleanup)(struct walker *);
 	int get_verbosely;
+	int get_progress;
 	int get_recover;

 	int corrupt_object_found;
=2D-
2.25.1
