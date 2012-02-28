From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] http: authenticate on NTLM proxies and others suppported, by CuRL
Date: Tue, 28 Feb 2012 15:32:33 +0100
Message-ID: <8762er6nb2.fsf@thomas.inf.ethz.ch>
References: <4F4CCE01.8080300@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <peff@peff.net>, <sam@vilain.net>,
	<sam.vilain@catalyst.net.nz>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 15:32:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2O6d-0007H4-9W
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 15:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab2B1Och (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 09:32:37 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15373 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755731Ab2B1Ocg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 09:32:36 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 15:32:32 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 15:32:32 +0100
In-Reply-To: <4F4CCE01.8080300@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 28 Feb 2012 13:52:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191735>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> -	if (curl_http_proxy)
> +	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +	}

There was another attempt at doing the same very recently:

  http://thread.gmane.org/gmane.comp.version-control.git/191140

I could swear there was a second one, but apparently that was you.
Neither you nor Marco submitter have so far answered the question I
raised in

  http://thread.gmane.org/gmane.comp.version-control.git/191155

which can be summarized as: please make a case -- and put it in the
message! -- for or against making this configurable.  Is there a speed
tradeoff?  (However, you could steal some of Daniel Stenberg's
reasoning!)

Note that Marco (the submitter in the first one) has told me privately
that he could not pursue this further right now, so I suppose he'd be
happy if you could finish it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
