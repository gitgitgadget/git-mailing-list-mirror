Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB340E4
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 17:32:30 -0800 (PST)
Received: (qmail 5908 invoked by uid 109); 12 Dec 2023 01:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 01:32:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8995 invoked by uid 111); 12 Dec 2023 01:32:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 20:32:29 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 20:32:29 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2023, #01; Sat, 9)
Message-ID: <20231212013229.GF376323@coredump.intra.peff.net>
References: <xmqqa5qknnej.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5qknnej.fsf@gitster.g>

On Fri, Dec 08, 2023 at 06:02:44PM -0800, Junio C Hamano wrote:

> * jk/end-of-options (2023-12-09) 1 commit
>  - parse-options: decouple "--end-of-options" and "--"
> 
>  "git log --end-of-options --rev -- --path" learned to interpret
>  "--rev" as a rev, and "--path" as a path, as expected.
> 
>  Will merge to 'next'.
>  source: <20231206222145.GA136253@coredump.intra.peff.net>

A minor correction here (since this will eventually go to the release
notes): "log --end-of-options --rev -- --path" always worked. It is "git
reset" that is fixed (along with "checkout" and many other programs).

-Peff
