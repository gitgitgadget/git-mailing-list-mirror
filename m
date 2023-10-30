Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BE8835
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F3B6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:30:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3FD89219FE;
	Mon, 30 Oct 2023 09:30:25 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id C43A52D778;
	Mon, 30 Oct 2023 09:30:24 +0000 (UTC)
Date: Mon, 30 Oct 2023 10:30:23 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jeff King <peff@peff.net>
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030093023.GG6241@kitsune.suse.cz>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
 <20231030090626.GA84866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030090626.GA84866@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 3FD89219FE

On Mon, Oct 30, 2023 at 05:06:26AM -0400, Jeff King wrote:
> On Mon, Oct 30, 2023 at 09:52:05AM +0100, Michal Suchánek wrote:
> 
> > > If we look very carfully at the log, we see that all the messages prefixed
> > > with "remote:" come from the remote (git server).
> > > In your case github. Other "Git repo servers" like gitlab or bitbucket have
> > > the same feature.
> > > 
> > > Git itself, running on your local computer, does not produce this links.
> > > If you really want to push directly to the main branch and want to see the
> > > a link, then you better talk to the gihub folks.
> > 
> > On the other hand, option to NOT display those remote messages is also
> > missing. At least with git 2.35 they are displayed even when -q argument
> > is given.
> 
> That is also up to GitHub to fix on the server side:
> 
>   https://lore.kernel.org/git/20230519090559.GA3515410@coredump.intra.peff.net/

If the server did not reject the push the messages it returns could be
considered informational.

Not sure if the final status of the push is available or of the
rejection is only noted in these messages, though.

Thanks

Michal
