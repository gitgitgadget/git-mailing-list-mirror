From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sun, 14 Dec 2008 09:45:49 +0800
Message-ID: <46dff0320812131745h3d30738ajf704a4336f5dec40@mail.gmail.com>
References: <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness>
	 <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
	 <29095.1229109133@redhat.com>
	 <20081213230504.GA21912@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Howells" <dhowells@redhat.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Nick Andrew" <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 02:47:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBg4b-000713-AJ
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 02:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYLNBpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 20:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYLNBpv
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 20:45:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:61021 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYLNBpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 20:45:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so975081wah.21
        for <multiple recipients>; Sat, 13 Dec 2008 17:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hylHq7KaJszxY+zLQjhszl1MvSb0CQ6IWKinluWIS/A=;
        b=icY7CUfHEKiNGAc+39iSBon7by+rJv3Ax4oVgA72OKuT/sHAlm1+OswZLtZqFr7533
         XCqlNsfH8VTiHKf2UXzpsrN3ihDB9Aj3xcnN0zReqKwk04gzyHLYcgJe5N2QoCHvvQPa
         0aFKQM5uNls41iKPi4Rbpk2ZgwDBojGIv7Yi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nmD7ik1HnGXA7M7fIsSa77pII5Hif0QbrLAYm+Agf5ciqPIJL7P/3E3JRtNlfq3B+9
         U0sL8i9sKQYO/Iwxncy8yS0cpJhWlFCgWCmIxRzxCFst3RCGvzTRxwjpjCn7rtTol2wm
         ekCDnah90FsTKW5O4sM9AzLdeHpAKr6sZm2Q0=
Received: by 10.114.92.2 with SMTP id p2mr3895683wab.122.1229219149410;
        Sat, 13 Dec 2008 17:45:49 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Sat, 13 Dec 2008 17:45:49 -0800 (PST)
In-Reply-To: <20081213230504.GA21912@mail.local.tull.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103039>

On Sun, Dec 14, 2008 at 7:05 AM, Nick Andrew <nick@nick-andrew.net> wrote:
> The way I did it was to start with the directed acyclic graph of
> commits, explaining how branches fork the graph and merges join
> it. This was presented to people who know subversion, and so they
> immediately became aware that there are other ways to manage source
> code than in a linear r1 r2 r3 r4 r5. I described tags and branch
> heads briefly.
>
> Next up I described the things you'd do with git: add new commits,
> create a branch, merge a branch, rebase, tag, push and fetch and
> showed what that does with the dag of commits.
>
> Finally I showed the actual commands used to perform those actions.
> I didn't get into the object database structure at all (that was
> prepared in case I had extra time).
>

I think this is the right way to start with the DAG. And i do the same.
