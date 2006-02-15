From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 17:25:30 +0000
Message-ID: <b0943d9e0602150925v6f01accfw@mail.gmail.com>
References: <20060210195914.GA1350@spearce.org>
	 <20060210211740.GO31278@pasky.or.cz>
	 <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com>
	 <20060214100844.GA1234@diana.vm.bytemark.co.uk>
	 <43F1F5CB.10402@citi.umich.edu>
	 <20060214160747.GA6350@diana.vm.bytemark.co.uk>
	 <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chuck Lever <cel@citi.umich.edu>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 18:26:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9QPO-0008V4-8M
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 18:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946042AbWBORZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 12:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946043AbWBORZj
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 12:25:39 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:11156 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946042AbWBORZj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 12:25:39 -0500
Received: by xproxy.gmail.com with SMTP id s15so1017721wxc
        for <git@vger.kernel.org>; Wed, 15 Feb 2006 09:25:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vu+NH5bgNvRFU5fLpAIuHZ806ihpQmbu26d3hO5GBzLIVc3xPArtdnCmJRY7lm+31XX8gopP049cjKo4PQ3TFNhjERdxF4xhdSqfp7phAHnCDYAqeU8Irl16ES/HsUS/wudOBtaxHLae0qIMJe5l8tZuoXBdTDlA4DTq7cLA0SQ=
Received: by 10.70.112.2 with SMTP id k2mr653463wxc;
        Wed, 15 Feb 2006 09:25:31 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Wed, 15 Feb 2006 09:25:30 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060214222913.GK31278@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16250>

On 14/02/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Tue, Feb 14, 2006 at 09:58:02PM CET, I got a letter
> where Chuck Lever <cel@citi.umich.edu> said that...
> > my impression of git is that you don't change stuff that's already
> > committed.  you revert changes by applying a new commit that backs out
> > the original changes.  i'm speculating, but i suspect that's why there's
> > a "stg pick --reverse" and not a "stg uncommit."
>
> It is ok as long as you know what are you doing - if you don't push out
> the commits you've just "undid" (or work on a public accessible
> repository in the first place, but I think that's kind of rare these
> days; quick survey - does anyone reading these lines do that?), there's
> nothing wrong on it, and it gives you nice flexibility.
>
> For example, to import bunch of patches (I guess that's the original
> intention behind this) you just run git-am on them and then stg uncommit
> all of the newly added commits.

This is a sensible way of using an uncommit command but I initially
thought it would be better to make things harder for people wanting to
re-write the history. Anyway, I'll keep this command on my todo list.

--
Catalin
