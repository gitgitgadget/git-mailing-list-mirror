Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF36CA64
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0A94
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:52:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E8DB81FEE4;
	Mon, 30 Oct 2023 08:52:06 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 975C8A3E61;
	Mon, 30 Oct 2023 08:52:06 +0000 (UTC)
Date: Mon, 30 Oct 2023 09:52:05 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc: Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030085205.GF6241@kitsune.suse.cz>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030063633.GA7451@tb-raspi4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E8DB81FEE4

On Mon, Oct 30, 2023 at 07:36:33AM +0100, Torsten Bögershausen wrote:
> On Sun, Oct 29, 2023 at 06:15:35PM -0500, Alexander Mills wrote:
> > When a feature branch is pushed, we get a link in the console to go to
> > remote, however when I push directly to main/master, no such link, eg:
> >
> > ```
> > alex.mills@alex node-be % git push
> > Enumerating objects: 20, done.
> > Counting objects: 100% (20/20), done.
> > Delta compression using up to 12 threads
> > Compressing objects: 100% (10/10), done.
> > Writing objects: 100% (11/11), 1.56 KiB | 799.00 KiB/s, done.
> > Total 11 (delta 7), reused 0 (delta 0), pack-reused 0
> > remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
> > remote: Bypassed rule violations for refs/heads/main:
> > remote:
> > remote: - Changes must be made through a pull request.
> > remote:
> > To github.com:elx-onlinx/beautychat-chatcards.git
> >    ffe1e05..bb7b0ef  main -> main
> > ```
> >
> > Having the link in the console saves me tremendous time and is
> > extremely effective/efficient. Can we get links in the console plz?
> >
> 
> If we look very carfully at the log, we see that all the messages prefixed
> with "remote:" come from the remote (git server).
> In your case github. Other "Git repo servers" like gitlab or bitbucket have
> the same feature.
> 
> Git itself, running on your local computer, does not produce this links.
> If you really want to push directly to the main branch and want to see the
> a link, then you better talk to the gihub folks.

On the other hand, option to NOT display those remote messages is also
missing. At least with git 2.35 they are displayed even when -q argument
is given.

Thanks

Michal
