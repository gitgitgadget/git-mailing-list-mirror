From: "Brian Scott Dobrovodsky" <brian@pontech.com>
Subject: Re: Data Integrity & un-Commited Branches
Date: Fri, 14 Sep 2007 23:24:42 -0700
Message-ID: <2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	 <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	 <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	 <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	 <20070915025129.GY3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 08:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWR5F-0001x0-3b
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 08:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXIOGYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 02:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbXIOGYo
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 02:24:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:40525 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXIOGYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 02:24:43 -0400
Received: by fk-out-0910.google.com with SMTP id z23so946497fkz
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=cF5DXL/yURMdJJ/0UHxGumaNNSuMXRskhRERQ5tmjW0=;
        b=adqFYQNPplfSsUqTU+6Mz0gufV1ovDL3bTPSlEc4J78jM6823N0Nrq5jKwX8AmThDmQgRP/AcwSL/hMgB6i90nlLWdCrBc72tJs1yNcg5yrLJrOmmFqzkNSZXB2upPdd1cwoKUWxwL0XqFOFdzDgZqfWk0vLkfPBdCXIpl3VJnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JRO4d4eRp4JxI4em/B7Qd61MIk6R/O0ljAg+a1ebV/CovS18i9DXTF72JQEmYL75tIVDPYcgsKTgT7Z6dfcYXXu38zPWcFm7sFo/yK8kJca+P/QtoO3ojyjgYxNOKziRFNTibbHrRz1e3Pnrugvi1HmTfTVH87v9K65KNk4uomU=
Received: by 10.82.178.11 with SMTP id a11mr3232891buf.1189837482145;
        Fri, 14 Sep 2007 23:24:42 -0700 (PDT)
Received: by 10.82.161.6 with HTTP; Fri, 14 Sep 2007 23:24:42 -0700 (PDT)
In-Reply-To: <20070915025129.GY3099@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 730eefacd4992d12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58219>

> My point is just that some people actually assume that work done
> while having one branch checked out is related to that branch and
> that branch alone and that switching a branch should put that work
> on hold.  Unfortunately for me some of these people at day-job have
> also just assumed Git can read their mind and forget to switch
> branches at the proper times, resulting in unrelated work mashed
> together for days straight (and criss-crossed merge to hell and back)
> before they call me and say "MAKEITWORKNOW".
> </rant>

As I have learned over the years, assumptions can be fatal. I can not
use something until I wrap my head around it and test it. Especially
for managing something in production! So far, this has been the only
problem/mis-understanding.

> It isn't unreasonable to want Git to save uncommitted work for the
> current branch and then you switch to another, ending up with a
> clean working directory when you finally get there.  Today we have
> git-stash to help you with this, but I'm thinking maybe we want to
> connect git-checkout with it?

That would be great as a default action when using checkout!
+Switching branches without having to commit improves work flow.
+Fewer commits = cleaner logs.
+More Intuitive!

I am currently using git-1.5.1.6, which apparently does not have
git-stash. I will upgrade and check it out.

Cheers,
-- 
Brian Scott Dobrovodsky
