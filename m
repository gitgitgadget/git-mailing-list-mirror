From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: git 2.8.1 not working with socks5h https proxy anymore
Date: Fri, 08 Apr 2016 21:07:33 +0200
Message-ID: <1460142453.32486.2.camel@kaarsemaker.net>
References: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Felix Ruess <felix.ruess@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 21:07:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobky-0007Ku-8R
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 21:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbcDHTHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2016 15:07:38 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37225 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcDHTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 15:07:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so33723536wmn.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7eiBQqDwQv6ENb9O/NMi3vqDAyEbE2g1XTttSC5Rks=;
        b=1eloXcsRcQqRGlQlBCUbi7OJcd9onQMUglOxwktCFpzYY7JXvvHfeyplvDFlTCpjRp
         oW65TmogiaI4domLyEJMD6YrIktEwZAxO1gA9jFswrCXOnLA6DZ807D2CP0y8wUf+mY+
         j5IJBbUd6UX2Dpl+DRHvHOJ1jTPizb4eYElAdKW2nD/5Zujge7J1NTo+nc9EcQvlE9lK
         0prksxxn1EuUYQosVPMMbB+8e26r1PH63miP5ZaW2s+YXLDMgis5C9PYQ3cJkbUVBgzM
         b5l5TCBxBIkkqdUV7tTs8deERiLy6F9cXxYHFdEoEBTE+oKa5zIOeDTwRFxSVEFVRFlN
         n/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7eiBQqDwQv6ENb9O/NMi3vqDAyEbE2g1XTttSC5Rks=;
        b=b7QoB7WtvKdPCgJm7eG8FL228kxymVC/i1jqFGncmPi5HhkXXN3hS2eulVil8EZkou
         qqwGzgV2ai+PJpgpnExO0k0pjexh2j7rDb9C7yy61iW5pFpgLm29et0aikssr72whUR8
         9NWAOWAmTxFnYtGgI4KVpmlrstct/H6Y4lF/REVuU94q4/k9KBij4hMi3InTEZvIYAaq
         J0h3xXTQj88wjSeywgyMsfGu4G8XQYxuxBYSZQLZrpRK7vWqibdIm7ZgMtQA+BAqKnKH
         qxWnujz5dAY6DUEnTFscQVV6wIOclfNjZMVTcJMWBxkwIIgbVmBxD0jy1JRVtHHJZHbe
         KPmg==
X-Gm-Message-State: AD7BkJJsoqvem9N2Z4Ofj3LwjyzXUL3xBaQ9JvUg9haPBEY01hVIA/WvCBzUsUQz4pYQIQ==
X-Received: by 10.194.22.97 with SMTP id c1mr11129042wjf.19.1460142455592;
        Fri, 08 Apr 2016 12:07:35 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id hh8sm14689114wjc.42.2016.04.08.12.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Apr 2016 12:07:34 -0700 (PDT)
In-Reply-To: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291054>

On vr, 2016-04-08 at 20:46 +0200, Felix Ruess wrote:
> Hi all,
>=20
> I just encountered a problem with the latest git version (2.8.1) that
> looks like a regression to me:
> When trying to clone a repo via a https socks5 proxy the connection
> times out:
>=20
> $ git config --global 'http.proxy=3Dsocks5h://127.0.0.1:1080'
> $ export GIT_CURL_VERBOSE=3D1
> $ git clone https://foo.de/bar.git
> Cloning into 'bar'...
> * Couldn't find host foo.de in the .netrc file; using defaults
> * Hostname was NOT found in DNS cache
> *=C2=A0=C2=A0=C2=A0Trying 127.0.0.1...
> * Hostname was NOT found in DNS cache
> * 80
> * 147
> * 201
> * 194
> channel 2: open failed: connect failed: Connection timed out
> channel 4: open failed: connect failed: Connection timed out
> * Failed to receive SOCKS5 connect request ack.
> * Closing connection 0
> fatal: unable to access 'https://foo.de/bar.git/': Failed to receive
> SOCKS5 connect request ack.
>=20
> I'm on Ubuntu 14.04 64bit and it works perfectly fine with git 1.9.1
> (and was also working with older git 2.x versions, although not sure
> any more what the last working version was).

I think that's=C2=A06d7afe07f29df75f831a46fb0f657fa37e561779, which
interprets that as a socks5 proxy.

I think this should fix it (but haven't tested it beyond 'it
compiles'):

diff --git a/http.c b/http.c
index 69da445..4304b80 100644
--- a/http.c
+++ b/http.c
@@ -605,7 +605,10 @@ static CURL *get_curl_handle(void)
=C2=A0	if (curl_http_proxy) {
=C2=A0		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
=C2=A0#if LIBCURL_VERSION_NUM >=3D 0x071800
-		if (starts_with(curl_http_proxy, "socks5"))
+		if (starts_with(curl_http_proxy, "socks5h"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
+		else if (starts_with(curl_http_proxy, "socks5"))
=C2=A0			curl_easy_setopt(result,
=C2=A0				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
=C2=A0		else if (starts_with(curl_http_proxy, "socks4a"))

But I have no socks5h proxy to test with. Can you give this patch a spi=
n?
--=20
Dennis Kaarsemaker
www.kaarsemaker.net
