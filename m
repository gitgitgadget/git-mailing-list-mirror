Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B36AD9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC57103
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:06:29 -0700 (PDT)
Received: (qmail 1575 invoked by uid 109); 30 Oct 2023 09:06:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:06:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9356 invoked by uid 111); 30 Oct 2023 09:06:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:06:31 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:06:26 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030090626.GA84866@coredump.intra.peff.net>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030085205.GF6241@kitsune.suse.cz>

On Mon, Oct 30, 2023 at 09:52:05AM +0100, Michal Suchánek wrote:

> > If we look very carfully at the log, we see that all the messages prefixed
> > with "remote:" come from the remote (git server).
> > In your case github. Other "Git repo servers" like gitlab or bitbucket have
> > the same feature.
> > 
> > Git itself, running on your local computer, does not produce this links.
> > If you really want to push directly to the main branch and want to see the
> > a link, then you better talk to the gihub folks.
> 
> On the other hand, option to NOT display those remote messages is also
> missing. At least with git 2.35 they are displayed even when -q argument
> is given.

That is also up to GitHub to fix on the server side:

  https://lore.kernel.org/git/20230519090559.GA3515410@coredump.intra.peff.net/

-Peff
