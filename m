Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8E620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeLMNIv (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:08:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:51107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbeLMNIv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:08:51 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9NIY-1gj0mw1Ydy-00CjaZ; Thu, 13
 Dec 2018 14:08:44 +0100
Date:   Thu, 13 Dec 2018 14:08:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] http: add support for selecting SSL backends at
 runtime
In-Reply-To: <87sgz1n53e.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812131403310.43@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com> <pull.46.v2.git.gitgitgadget@gmail.com> <85bd0fb27fcf7615b3f927344fd77ea49b9f5dcb.1540493630.git.gitgitgadget@gmail.com> <87sgz1n53e.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2006497846-1544706524=:43"
X-Provags-ID: V03:K1:4MRhbyDPOSGBxhqrv4MIzQw1yEUFu87VIUvVOo2BRXmm0rDHmf6
 bPfQpo5zuyOvS0wGj0ELJIchYiAFQ926yZVNY6Kge1c933dBRl7n0sdU4Cu3Ap7yduHGNJE
 9qyRgErxw+WHLzwnG/74mdXLTF1Ti91Xv/I8cu3oIZSl8OhndgxZtCHRbRQVuq5rwdvWX+0
 tKVtGhm3TMrjNXPAfQdtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwKGclTAUIo=:eQp8Nyae6YreEQbeSb6Cc3
 Mu8dGgd1T1QX+FX3fHAKgo2M4qWuKk8AVh+IUKZE3qnuofexd9TFVkslMT74Rn0S4GzqgL7zW
 IqYBdSILis04DZrlIQ7sHFJh/lEuhl5NT4f+KAuwyLu/C6AU5jnsGKq3Row7qtSMjbNU/8tqC
 aQHptTtU9iUAd3pQldjDKgH+GvKNTh3mQn016F+oDbkysG/WUL0CYb3qAZfz4rkxU3i4uOcrY
 5yJ46/MZr63y/ns66ksm1t8Qkd1fxWAMpKk0eRj/vBxpe9xyjXkc5BucuQKA9FzURWEf9ZVEj
 HIxUyBNJ8/ooL1/zQWER9UpBi9U39DnhDh7gvqSmenQjiAZ31UcwxkX/tu4M+kHGZzZR4957u
 sj1e6YVWdwdpV6MHUmjuyX5TpH73C/aFjb+Sw2aIihO1kU5x9nFCpFXqRwLyb2y4i9d2BF9XI
 98yolaUB/6RfUIStsQ2G7UasN3WocDWTDpmPS0gd8VC3jUSfWRTOd4vdBrHo40uE+EJTphP3E
 2DDpEVSW0KS5hbtj1g0Gr5v3TQjDv8FzKnzQlfluwEgKl+RcLy7MjEirEAdaLVbglIShLnSav
 N0QOUfcl8yijqNdVTG/JJjKG+8Vrd2ZMjXK71ro9IiJQP8lEz5VhS09t/7xPOWmLCAD6yTAfk
 t3qVJIeSXuUb3nNtRhyQ+xKo2EZyZX4Dfcf5zaqc8aQFFLcS3ZRBYlvqEPnF3vBBsA4310HdX
 bmSZiDVLKEI+eI9rSymvF9bqpnnj0VhlKMP4LtdbdVrNm0LYjf24GFvuTrJl78UxulVGKwLOC
 n/W7eCOyXbwL4+rOQ0v72QM/xQFHhIQpVGKit3pJAehrn70V7234IficNTwOk0Ti4iu8PrYtP
 pheNOxwkFZohcTk/qSEQjPk5BJaqROLIgWgz24KxJ+6qvunX41NDBvNnkfu71N8exE9txSo2m
 0opiz377DYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2006497846-1544706524=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Thu, 13 Dec 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Oct 25 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As of version 7.56.0, curl supports being compiled with multiple SSL
> > backends.
> >
> > This patch adds the Git side of that feature: by setting http.sslBackend
> > to "openssl" or "schannel", Git for Windows can now choose the SSL
> > backend at runtime.
> >
> > This comes in handy on Windows because Secure Channel ("schannel") is
> > the native solution, accessing the Windows Credential Store, thereby
> > allowing for enterprise-wide management of certificates. For historical
> > reasons, Git for Windows needs to support OpenSSL still, as it has
> > previously been the only supported SSL backend in Git for Windows for
> > almost a decade.
> >
> > The patch has been carried in Git for Windows for over a year, and is
> > considered mature.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/config.txt |  5 +++++
> >  http.c                   | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 154683321..7d38f0bf1 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1984,6 +1984,11 @@ http.sslCAPath::
> >  	with when fetching or pushing over HTTPS. Can be overridden
> >  	by the `GIT_SSL_CAPATH` environment variable.
> >
> > +http.sslBackend::
> > +	Name of the SSL backend to use (e.g. "openssl" or "schannel").
> > +	This option is ignored if cURL lacks support for choosing the SSL
> > +	backend at runtime.
> > +
> >  http.pinnedpubkey::
> >  	Public key of the https service. It may either be the filename of
> >  	a PEM or DER encoded public key file or a string starting with
> > diff --git a/http.c b/http.c
> > index 98ff12258..7fb37a061 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -155,6 +155,8 @@ static struct active_request_slot *active_queue_head;
> >
> >  static char *cached_accept_language;
> >
> > +static char *http_ssl_backend;
> > +
> >  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
> >  {
> >  	size_t size = eltsize * nmemb;
> > @@ -302,6 +304,12 @@ static int http_options(const char *var, const char *value, void *cb)
> >  		curl_ssl_try = git_config_bool(var, value);
> >  		return 0;
> >  	}
> > +	if (!strcmp("http.sslbackend", var)) {
> > +		free(http_ssl_backend);
> > +		http_ssl_backend = xstrdup_or_null(value);
> > +		return 0;
> > +	}
> > +
> >  	if (!strcmp("http.minsessions", var)) {
> >  		min_curl_sessions = git_config_int(var, value);
> >  #ifndef USE_CURL_MULTI
> > @@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  	git_config(urlmatch_config_entry, &config);
> >  	free(normalized_url);
> >
> > +#if LIBCURL_VERSION_NUM >= 0x073800
> > +	if (http_ssl_backend) {
> > +		const curl_ssl_backend **backends;
> > +		struct strbuf buf = STRBUF_INIT;
> > +		int i;
> > +
> > +		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
> > +		case CURLSSLSET_UNKNOWN_BACKEND:
> > +			strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
> > +					    "Supported SSL backends:"),
> > +					    http_ssl_backend);
> > +			for (i = 0; backends[i]; i++)
> > +				strbuf_addf(&buf, "\n\t%s", backends[i]->name);
> > +			die("%s", buf.buf);
> > +		case CURLSSLSET_NO_BACKENDS:
> > +			die(_("Could not set SSL backend to '%s': "
> > +			      "cURL was built without SSL backends"),
> > +			    http_ssl_backend);
> > +		case CURLSSLSET_TOO_LATE:
> > +			die(_("Could not set SSL backend to '%s': already set"),
> > +			    http_ssl_backend);
> > +		case CURLSSLSET_OK:
> > +			break; /* Okay! */
> > +		}
> > +	}
> > +#endif
> > +
> >  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
> >  		die("curl_global_init failed");
> 
> Here's someone who upgraded to 2.20 on Arch linux & started getting
> "Could not set..." errors because of this change:
> https://www.reddit.com/r/git/comments/a5ne5v/git_fatal_could_not_set_ssl_backend_to_openssl/

Yeah, I don't see bug reports that were opened via Reddit.

> I don't know the context well enough, but is there perhaps enough info
> here so we could give a better error message, e.g. "don't set xyz twice
> in your config", or just emit a warning?

This is actually not the symptom of a Git bug, but of a cURL bug that I
fixed in https://github.com/curl/curl/pull/3346. I suspect the fix for
this particular symptom to be
https://github.com/curl/curl/commit/231a328c1c563acb53d8222894975e96bf7e6ea7

(Granted, I introduced that bug, and did not catch it earlier because I
almost never build cURL with a single TLS backend these days, and that is
necessary to trigger the bug.)

According to https://curl.haxx.se/changes.html, this bug fix
(https://curl.haxx.se/bug/?i=3346) made it into v7.63.0, which is one day
old.

Feel free to update that Reddit post (I don't have an account, nor any
inclination to get one).

Ciao,
Dscho
--8323328-2006497846-1544706524=:43--
