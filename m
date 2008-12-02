From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: Managing websites with git
Date: Mon, 1 Dec 2008 20:36:43 -0500
Message-ID: <ee2a733e0812011736o122b43bbxb30a92261f584370@mail.gmail.com>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
	 <20081130170722.GJ6572@eratosthenes.sbcglobal.net>
	 <20081130172717.GA7047@coredump.intra.peff.net>
	 <87k5ajflp0.fsf@sparse.dyndns.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"David Bryson" <david@statichacks.org>,
	"Felix Andersen" <felix@nibbo.se>
To: "Jason Riedy" <jason@acm.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 02:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KDE-0001Gl-Ek
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYLBBgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYLBBgr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:36:47 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:27649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLBBgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:36:46 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1975260fgg.17
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qHBCcIvarEE1o/GQpvpPbbEiFadJsPRBYM6ZhEm2u40=;
        b=eyppun+pMCQyZelyGTLssqOSyWNmj97yzgJ39XEY2XcRC1yfSa4vboOFfcadKouO5D
         kKxUu0JaMcO3IY71kJCRdm9GMuEvZsbFUImlp2BzFsGu0rpCquI1P4S/fTP5Mr09TeO2
         cPMAl73DJ2MHukdm9ZIBYHlokjPbKq4cHfToU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=X3b+Au7cbSO1X28p5v43o8rDs7SpI90Losl6Vv3QHXxXRwuq6+Kk7QmQBa771l9yk9
         EFro/g6k3EkZI3hirdzb0lppl+l8SVHhQWpzfpt/80tjUWwgakt4wTUQYWZ11TLjWLXm
         cOFO4iOVgEWVUfzhwW3C4g3g0bubroImydg5A=
Received: by 10.181.18.2 with SMTP id v2mr4094048bki.194.1228181803158;
        Mon, 01 Dec 2008 17:36:43 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Mon, 1 Dec 2008 17:36:43 -0800 (PST)
In-Reply-To: <87k5ajflp0.fsf@sparse.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102091>

On 12/1/08, Jason Riedy <jason@acm.org> wrote:
> And David Bryson writes:
>  > One really should not push to a non-bare repo.
>
>
> WHAT?!?!?!
>
>  And Jeff King responds:
>
> > It's in master and should be in 1.6.1, but it is a config option that
>  > defaults to "warn" for now, so as not to break existing setups.
>
>
> WHAT?!?!?!
>
>  I do this all the time.  I clone from my main working directory
>  onto some cluster / MPP where the build system is all wonky.
>  Once I get everything building, I push back to a branch (often
>  new) in my main working directory.  Then I can merge the build
>  changes whenever I get a chance.
>
>  Pushing from these systems often is much, much easier than
>  pulling from the origin.  Sometimes you're working in temporary
>  space on a back-end node; you can connect out but you cannot
>  connect in.
>
>  I've gotten a few people interested in git for managing these
>  nearly one-off build problems.  git is the first system that has
>  "just worked" for them.  Their having to configure each repo
>  eliminates the "just works" factor.
>
>  It feels like newer gits make more and more decisions about what
>  I shouldn't do.
>
>
>  Jason
>

I second Jason's opinion. I also frequently push to non-bare
intermediary repos. This functionality is essential for several of my
work flows. Please, please, do not handicap git-push operation!!

--Leo--
