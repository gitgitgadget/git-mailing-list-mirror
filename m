Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC0320A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeLMNQF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:16:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:35361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbeLMNQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:16:04 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGAdz-1gcfur1ZNX-00FGA9; Thu, 13
 Dec 2018 14:15:58 +0100
Date:   Thu, 13 Dec 2018 14:15:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] http: add support for selecting SSL backends at
 runtime
In-Reply-To: <nycvar.QRO.7.76.6.1812131403310.43@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1812131411030.43@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com> <pull.46.v2.git.gitgitgadget@gmail.com> <85bd0fb27fcf7615b3f927344fd77ea49b9f5dcb.1540493630.git.gitgitgadget@gmail.com> <87sgz1n53e.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1812131403310.43@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401895731-1544706958=:43"
X-Provags-ID: V03:K1:ebc0gcqd6l/UVHCxH1cSYCtEsum2mMIU2DUFqCgG2tH14C0aueO
 O0+wlN17DY3RUnJTq+DTdzxDWkvCUaQrYqFfBnFTD7t0XRkE5+JvLbqypMuLygt0LYPlxeZ
 9glIhaY/LnDhIZkIPRZSDnGgqQtriO14mgxN7gcQIBVfLgEXPptiVTzPQS6/RHeq00Vg62z
 BocE6NXDBsJUqb5O8AhsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3v9InGWOko=:kUKrmuvFPysWJlfpJuU6tC
 2sIowx2fi3LeNVd0739LTxWK+OF2I0OdWldRCcD3iNVp9UkpKR4zll4gFfDo2lxQi+hy070Se
 60GOQJrTKqNRXbmUO9twP9wft3rP3U6PlnG9A80hbzoLSSf451ElQhLsTF0iJ77oBiP52FCVD
 PjKzqwT8K/5CK6AsGvmM5sdamwty80YARpJRwWXv1yCPR4YPnCI+UbR5hfw4kG6n5bBYRRI6N
 d+ioXAN/I87Ng+Rwf36m9QVpUtoxG7Ap8+jixLNWL7cWa/0t1d41tp5pWKfnzHX+6QzmCgBnM
 tQoWgCtwEHA0B9Hp7+ge8KnOHMSM9u5vSE/WOdkmTR8YCNqGVhGY+ZRQwllMMoy1mwT6ElO/V
 VFmYvOgcBGIHbGLi+nBVnIAxIz53PlraFkj99f4WGQV1Ia8FCARRSfp/pF2E6zDbAnSPdKQ3C
 TdxXZm0Co16dibHP67Q+rWKeDASjcTwNWUqC2vCYOsMixZ03rh0KS51K+3VUemWgFlt0s/JtJ
 XTxuMMF5JtbKOy0Xqd13PwrlzeLA/mxLqy0IavaIfWcdb4/JTDBRn1O6GGmyhFl/NtdYSiCA2
 yH/HtIK8ePpC9Mh1e/zcTBKsGOgQaFF3fVfmQ64GSNVwex0E6oMN2n6C2D5uP4/rASIcpq+BT
 KSalGvP2plZfhFFBfXMvtWI/UcHKdE6UqXgnt30aQYKyY/D+nXbkU1JPphzdAFjs9xRjVKamf
 m/cX3raE/oV98IEVQ0I/VdJLQTC01Q7YiceqlIfpgTwNT16tLwUlshGGWXNUw4BgznQfOHAP1
 j+h88u4AQ1mDPpy5Fiy0qFi8dc+8xVdoEMo8Dl76XZD/6VkcFr6jmP6mmtEMLQbjbYuJF1qNL
 HRJgWu265dZLJGAsVrT3yB+46/AGfzc0FfmQpTYsXQ5rO9Sa8mFc3FmM4FajyNXts/3I3QXy7
 2HdrJ+qV3/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401895731-1544706958=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 13 Dec 2018, Johannes Schindelin wrote:

> On Thu, 13 Dec 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Thu, Oct 25 2018, Johannes Schindelin via GitGitGadget wrote:
> > 
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > As of version 7.56.0, curl supports being compiled with multiple SSL
> > > backends.
> > >
> > > This patch adds the Git side of that feature: by setting http.sslBackend
> > > to "openssl" or "schannel", Git for Windows can now choose the SSL
> > > backend at runtime.
> > >
> > > This comes in handy on Windows because Secure Channel ("schannel") is
> > > the native solution, accessing the Windows Credential Store, thereby
> > > allowing for enterprise-wide management of certificates. For historical
> > > reasons, Git for Windows needs to support OpenSSL still, as it has
> > > previously been the only supported SSL backend in Git for Windows for
> > > almost a decade.
> > >
> > > The patch has been carried in Git for Windows for over a year, and is
> > > considered mature.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  Documentation/config.txt |  5 +++++
> > >  http.c                   | 35 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >
> > > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > > index 154683321..7d38f0bf1 100644
> > > --- a/Documentation/config.txt
> > > +++ b/Documentation/config.txt
> > > @@ -1984,6 +1984,11 @@ http.sslCAPath::
> > >  	with when fetching or pushing over HTTPS. Can be overridden
> > >  	by the `GIT_SSL_CAPATH` environment variable.
> > >
> > > +http.sslBackend::
> > > +	Name of the SSL backend to use (e.g. "openssl" or "schannel").
> > > +	This option is ignored if cURL lacks support for choosing the SSL
> > > +	backend at runtime.
> > > +
> > >  http.pinnedpubkey::
> > >  	Public key of the https service. It may either be the filename of
> > >  	a PEM or DER encoded public key file or a string starting with
> > > diff --git a/http.c b/http.c
> > > index 98ff12258..7fb37a061 100644
> > > --- a/http.c
> > > +++ b/http.c
> > > @@ -155,6 +155,8 @@ static struct active_request_slot *active_queue_head;
> > >
> > >  static char *cached_accept_language;
> > >
> > > +static char *http_ssl_backend;
> > > +
> > >  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
> > >  {
> > >  	size_t size = eltsize * nmemb;
> > > @@ -302,6 +304,12 @@ static int http_options(const char *var, const char *value, void *cb)
> > >  		curl_ssl_try = git_config_bool(var, value);
> > >  		return 0;
> > >  	}
> > > +	if (!strcmp("http.sslbackend", var)) {
> > > +		free(http_ssl_backend);
> > > +		http_ssl_backend = xstrdup_or_null(value);
> > > +		return 0;
> > > +	}
> > > +
> > >  	if (!strcmp("http.minsessions", var)) {
> > >  		min_curl_sessions = git_config_int(var, value);
> > >  #ifndef USE_CURL_MULTI
> > > @@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> > >  	git_config(urlmatch_config_entry, &config);
> > >  	free(normalized_url);
> > >
> > > +#if LIBCURL_VERSION_NUM >= 0x073800
> > > +	if (http_ssl_backend) {
> > > +		const curl_ssl_backend **backends;
> > > +		struct strbuf buf = STRBUF_INIT;
> > > +		int i;
> > > +
> > > +		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
> > > +		case CURLSSLSET_UNKNOWN_BACKEND:
> > > +			strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
> > > +					    "Supported SSL backends:"),
> > > +					    http_ssl_backend);
> > > +			for (i = 0; backends[i]; i++)
> > > +				strbuf_addf(&buf, "\n\t%s", backends[i]->name);
> > > +			die("%s", buf.buf);
> > > +		case CURLSSLSET_NO_BACKENDS:
> > > +			die(_("Could not set SSL backend to '%s': "
> > > +			      "cURL was built without SSL backends"),
> > > +			    http_ssl_backend);
> > > +		case CURLSSLSET_TOO_LATE:
> > > +			die(_("Could not set SSL backend to '%s': already set"),
> > > +			    http_ssl_backend);
> > > +		case CURLSSLSET_OK:
> > > +			break; /* Okay! */
> > > +		}
> > > +	}
> > > +#endif
> > > +
> > >  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
> > >  		die("curl_global_init failed");
> > 
> > Here's someone who upgraded to 2.20 on Arch linux & started getting
> > "Could not set..." errors because of this change:
> > https://www.reddit.com/r/git/comments/a5ne5v/git_fatal_could_not_set_ssl_backend_to_openssl/
> 
> Yeah, I don't see bug reports that were opened via Reddit.
> 
> > I don't know the context well enough, but is there perhaps enough info
> > here so we could give a better error message, e.g. "don't set xyz twice
> > in your config", or just emit a warning?
> 
> This is actually not the symptom of a Git bug, but of a cURL bug that I
> fixed in https://github.com/curl/curl/pull/3346. I suspect the fix for
> this particular symptom to be
> https://github.com/curl/curl/commit/231a328c1c563acb53d8222894975e96bf7e6ea7

I should actually talk about that symptom a bit more so you understand
where it comes from: the idea of cURL when compiled with multiple TLS
backends is that it has a meta backend that, upon first call, will see
which backend to use and then plugs that.

When compiled with a single backend, that meta backend is not plugged at
all, the single backend is plugged by default.

And here lies the rub, when *now* trying to select a TLS backend *by
name*, the code incorrectly reported an error (instead of success in case
that the correct backend was already "selected", or *another* failure if
trying to select a backend that was not compiled in).

Ciao,
Dscho

> (Granted, I introduced that bug, and did not catch it earlier because I
> almost never build cURL with a single TLS backend these days, and that is
> necessary to trigger the bug.)
> 
> According to https://curl.haxx.se/changes.html, this bug fix
> (https://curl.haxx.se/bug/?i=3346) made it into v7.63.0, which is one day
> old.
> 
> Feel free to update that Reddit post (I don't have an account, nor any
> inclination to get one).
> 
> Ciao,
> Dscho
--8323328-1401895731-1544706958=:43--
