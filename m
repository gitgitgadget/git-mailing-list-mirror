From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 14:45:59 -0400
Message-ID: <e06498070809061145j712a578bobb761fbbbc34c082@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <20080906173925.GA4044@coredump.intra.peff.net>
	 <e06498070809061133p2e3a206fmfd47961645b15ff@mail.gmail.com>
	 <20080906184033.GA4598@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2ow-0005aW-0G
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYIFSqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbYIFSqD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:46:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:52379 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbYIFSqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:46:01 -0400
Received: by wr-out-0506.google.com with SMTP id 69so942890wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zc3ebw1gnWsYoTcEB4eI4MD9qcD5432tc5abhGDDVcw=;
        b=hfNyqxF43JndSRRarNE1it1hre6hzfVp5iCkJw/p31r1BgAIOl8Qtky+lbPbdwwOUq
         ywM7Cgsu7HUVhMbUcGA0HMaw0N5d9rNlLpRQlGkVtGl3OxBlS0uYI6oNSqj+gther1Ts
         +yckG9UvRxSPTbn/5P5DZEeyB1CTTvVrtFh3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hk3qkHj4j+Kt57symgFK5VWRrAG8RSfmAriyTtWzM3XoC9CdSoDn9wSkp9BMpn6iB/
         2pmQcf951e1SvYCpKlIaPcTvD2v2aEEdRJfH7cfabAwKfRXzCopGf9W4oZp/eSLsCR7y
         towz4eh34i9nGmN/c5YeyYfxmGWvEFhpBGEd4=
Received: by 10.90.94.12 with SMTP id r12mr1742392agb.29.1220726759878;
        Sat, 06 Sep 2008 11:45:59 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Sat, 6 Sep 2008 11:45:59 -0700 (PDT)
In-Reply-To: <20080906184033.GA4598@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95092>

On Sat, Sep 6, 2008 at 2:40 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 06, 2008 at 02:33:21PM -0400, Steven Walter wrote:
>
>> http://repo.or.cz/w/yap.git
>
> Hmm. Bug, or am I missing something fundamental?

Nope, simple bug.  Everything should still work correctly, but the
output was a bit confusing.  I just pushed a fix.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
