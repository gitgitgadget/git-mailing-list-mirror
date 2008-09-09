From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:07:43 +0200
Message-ID: <200809100107.44933.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <20080909205003.GA3397@coredump.intra.peff.net> <200809100035.23166.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCKW-00083f-5t
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYIIXH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYIIXH6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:07:58 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:8264 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYIIXH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:07:57 -0400
Received: by el-out-1112.google.com with SMTP id z25so439542ele.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=T9FGlp6Qd2HicNH3ttUA+88jmHpEc18BwW0CUS6fEvA=;
        b=PPODcd8xSIAH+HZrQ+m0/D3ETpkjmhjU/XUyIv/ouPiqy0s1HY1PiBK2zf77p/P1E2
         EC469UaWN4yo3mDHpqTMg4O9t+noZB1qzJ20GHQgOFkc5/S7n+W8dwUWdBVTCG1HtzS5
         4LM+yEQg5c72ru59lluQDR2xECFP3w7Zj9R+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rJ+b7Jv79xSt77jAmgYnXbEN2hP4s6iFCknNIupO3rLoGN9Zhi7S0Q38VmWN7K4YQV
         dMqplu4hSMCsBw0NfdZI7cDjiFCoLK6haVAuaBC+k99dLsQrMBaKRqFSKx/Sk90NmaJj
         rMKNyZ6VoFnKLdyTg2jQdFrl/PNX+Ni1ZpbRs=
Received: by 10.86.98.10 with SMTP id v10mr371017fgb.39.1221001674790;
        Tue, 09 Sep 2008 16:07:54 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.71])
        by mx.google.com with ESMTPS id 4sm7665709fgg.4.2008.09.09.16.07.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 16:07:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809100035.23166.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95456>

Jakub Narebski wrote:
> On Tue, 9 Sep 2008, Jeff King wrote:
> > On Tue, Sep 09, 2008 at 01:42:52PM -0700, Junio C Hamano wrote:

> > Now, that being said:
> > 
> > > After reading the discussion so far, I am still not convinced if this is a
> > > good idea, nor this time around it is that much different from what the
> > > previous "prior" link discussion tried to do.
> > 
> > For the record, I am not convinced it is a good idea either; I was
> > hoping to steer it in a direction where somebody could say "and now this
> > is the useful thing we can do now that we could not do before." If the
> > ultimate goal is to put links to other commits into history viewers,
> > then the commit message is a reasonable place to do so. The only thing I
> > see improving with a header is that it makes more sense for pruning and
> > object transfer.
> 
> I'm also not all convinced that 'cousin'/'origin'/'changeset'/'cset'
> header is a good idea.  I only tried to steer discussion in good
> direction if it is somewhat a good idea.

By the way, beside graphical history viewers it would also help rebase
(and git-cherry) notice when patch was already applied better.

-- 
Jakub Narebski
Poland
