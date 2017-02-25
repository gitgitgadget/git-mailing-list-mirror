Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278EC2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 11:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdBYLu5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 06:50:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:49738 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdBYLu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 06:50:56 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg4FJ-1cvYpZ3vIj-00NS7Q; Sat, 25
 Feb 2017 12:48:57 +0100
Date:   Sat, 25 Feb 2017 12:48:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     David Turner <David.Turner@twosigma.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
In-Reply-To: <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702251243390.3767@virtualbox>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net> <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net> <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com> <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZtHGJp+rL/puiDNQ8du8hCc8LWeRpessgJc6dQzjTHRB3m0SMAw
 iYPeSGBc0FIi3bjigkMh6QPmm/wCv+zTIbKbCZCoOuElPJCFJNOEHxxyHTw/fvK1lIt+f5m
 HoJBq4TJQZV747NUZfTReRLC/ro5pYGGgujL4F/MReKhH2aDEJXj/ZBhAsujfrClll8BD0V
 +NbPbK9181Ek/BNdULCKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fHYgb/TmEBg=:nRv52xNr6cERv/iiTaVIbs
 mjc4OvjXYhoXZPzmgLyZHuDrSjBHsOYhDwpEmG4sighDOJDvcXA/gVR/+IQHaOnVt9mMYWCDZ
 5h07C8hQc+tsXRwqgDsMPF6LmsI9vswfjsErHmKfUyB1TmBOhG2FMk1ZeAWPpNA+wXX6++hpc
 37n72iudFz9By391HIKMRP9wwkGz8n6ighkGyCSMHWYu2H8NOl9rkLrNmV72noq/rkPzMYOst
 rjCjelFjG+16d50fbkNNVI0w3HQa4iwqKkCt12dY6+uL6+rmdaLIe337gpP4CjaWcARod3yDW
 /6fFK/PkIVjjpXx9yNdvn9JURnG4QP/8FhieNdagksUb3bJ+TUgNNNNNAdc2vGZtYuxiQREGl
 snkO8rnpKRm5OhQ4i32FfcnG7GeXGKTnL9O0PdDnzKD7SCh/VeLD8Osk4N7oHoU0enedoHF5S
 H15JdVMZZ2ckJlNTVecBp6ByPNPhMifRflqAozcU0r9+w7ZIvSJUZA38YEKZU4NiCGYW0pxtf
 2tjl5fqsftM5bWmfg7MsNMwGfR4xArLcqPwHhkvJzoIIYUL+VTfttmani6DcA9kQxLfYLB3+V
 MWTTjoGXMdcd65N8J0tc4FdTZR2LO8UGtYXRxWO33uJsgtYg+WWqGTBrwzsAyL+ACieWXhJSt
 o98IdAJgTtuMcYLx3XZNmSHz45XO8b22INTZQWnyvFWv/LSTWVjCJBGPlAMFKfAg+kaHzKSvH
 qUoX/FNvZALtqJmlvIIkIRZ19IdXsR50mCgcKmnZjotQKhmAYZp/XNuETtxDr5BSsUxwO4DTa
 zgdNzkK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 22 Feb 2017, Jeff King wrote:

> [two beautiful patches]

I applied them and verified that the reported issue is fixed. Thank you!

Hopefully you do not mind that I cherry-picked them in preparation for
Git for Windows v2.12.0?

I added a small fixup (https://github.com/dscho/git/commit/44ae0bcae5):

-- snip --
Subject: [PATCH] fixup! http: add an "auto" mode for http.emptyauth

Note: we keep a "black list" of authentication methods for which we do
not want to enable http.emptyAuth automatically. A white list would be
nicer, but less robust, as we want to support linking to several cURL
versions and the list of authentication methods (as well as their names)
changed over time.

[jes: actually added the "auto" handling, excluded Digest, too]

This fixes https://github.com/git-for-windows/git/issues/1034

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 55 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index f8eb0f23d6c..fb94c444c80 100644
--- a/http.c
+++ b/http.c
@@ -334,7 +334,10 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&user_agent, var, value);
 
 	if (!strcmp("http.emptyauth", var)) {
-		curl_empty_auth = git_config_bool(var, value);
+		if (value && !strcmp("auto", value))
+			curl_empty_auth = -1;
+		else
+			curl_empty_auth = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -385,29 +388,37 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static int curl_empty_auth_enabled(void)
 {
-	if (curl_empty_auth < 0) {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-		/*
-		 * In the automatic case, kick in the empty-auth
-		 * hack as long as we would potentially try some
-		 * method more exotic than "Basic".
-		 *
-		 * But only do so when this is _not_ our initial
-		 * request, as we would not then yet know what
-		 * methods are available.
-		 */
-		return http_auth_methods_restricted &&
-		       http_auth_methods != CURLAUTH_BASIC;
+	if (curl_empty_auth >= 0)
+		return curl_empty_auth;
+
+#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
+	/*
+	 * Our libcurl is too old to do AUTH_ANY in the first place;
+	 * just default to turning the feature off.
+	 */
 #else
-		/*
-		 * Our libcurl is too old to do AUTH_ANY in the first place;
-		 * just default to turning the feature off.
-		 */
-		return 0;
+	/*
+	 * In the automatic case, kick in the empty-auth
+	 * hack as long as we would potentially try some
+	 * method more exotic than "Basic".
+	 *
+	 * But only do this when this is our second or
+	 * subsequent * request, as by then we know what
+	 * methods are available.
+	 */
+	if (http_auth_methods_restricted)
+		switch (http_auth_methods) {
+		case CURLAUTH_BASIC:
+		case CURLAUTH_DIGEST:
+#ifdef CURLAUTH_DIGEST_IE
+		case CURLAUTH_DIGEST_IE:
 #endif
-	}
-
-	return curl_empty_auth;
+			return 0;
+		default:
+			return 1;
+		}
+#endif
+	return 0;
 }
 
 static void init_curl_http_auth(CURL *result)
-- snap --

As you can see, I actually implemented the handling for
http.emptyauth=auto, and I was more comfortable with handling the "easy"
cases first in the curl_empty_auth_enabled function.

I also took Dave's suggestion:

> On Thu, Feb 23, 2017 at 01:16:33AM +0000, David Turner wrote:
> 
> > > +		 * But only do so when this is _not_ our initial
> > > +		 * request, as we would not then yet know what
> > > +		 * methods are available.
> > > +		 */
> > 
> > Eliminate double-negative:
> > 
> > "But only do this when this is our second or subsequent request, 
> > as by then we know what methods are available."
> 
> Yeah, that is clearer.

Thank you all!

Now, how to get this into upstream Git, too? Jeff, do you want to submit a
v2? In that case, would you please consider the fixup! I mentioned above?
Otherwise I'd be happy to take it from here.

Ciao,
Dscho
