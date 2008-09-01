From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [RFD] How to better document the "two and three dots" format
Date: Mon, 1 Sep 2008 14:49:12 +0200
Message-ID: <237967ef0809010549n72629d47gfdf3c483f1a9e369@mail.gmail.com>
References: <4d8e3fd30809010543o1e1562c1s4466e191e782ddcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 14:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka8rT-0002aA-9f
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 14:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYIAMtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 08:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYIAMtR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 08:49:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:56772 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbYIAMtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 08:49:17 -0400
Received: by ey-out-2122.google.com with SMTP id 6so900799eyi.37
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3kiKXiHZrN0CPC2C3ZAAAKtXANE3pdB9T70Taj/IGOI=;
        b=SYpv1XNJKV+isebN/WQLwbeOSlFHoHtPLVYjfGPKKaARTs8/MB6FfFXEqP4FO8YJAC
         T9HMgjYdirmUh3YI7ynCfNVsRD1x4JQIzZIMac7LRAVUKvyywnXQ2xHJxf7BYAJyptnE
         zqJUHhmCX/cnLGM+1cEVmSAduYLuZevUQaBDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W8Y7wflBkJsBCAocNJDld+VUEFEg6lzCvenWsOzYYBCxfLgFhmcSe4VdopVakVDCCh
         pxsuvFa6aWDqSbFqkMcHbSQF1wuozgSMQ3pVdzdaXWwYlDvbJRkrYrdWjg8Vqv2g539B
         erVWJiqhTbbykMPgoKpiNx0NXl8S1tPHmw198=
Received: by 10.210.36.8 with SMTP id j8mr6487099ebj.77.1220273352854;
        Mon, 01 Sep 2008 05:49:12 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Mon, 1 Sep 2008 05:49:12 -0700 (PDT)
In-Reply-To: <4d8e3fd30809010543o1e1562c1s4466e191e782ddcc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94579>

2008/9/1 Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>:
> Hi all,
> I'm looking in the existing documentation about some example and
> clarification about
> the two and three dots formats applied to git diff.
>
> The git-diff.txt file includes the following:
>
> ---8<---
> Comparing branches::
> +
> ------------
> $ git diff topic master    <1>
> $ git diff topic..master   <2>
> $ git diff topic...master  <3>
> ------------
> +
> <1> Changes between the tips of the topic and the master branches.
> <2> Same as above.
> <3> Changes that occurred on the master branch since when the topic
> branch was started off it.
> ---8<---
>
> I think <3> should be changed in something like:
> <3> Changes between the tips of the topic and the master branch that
> occurred since when the topic
> branch was started off it.
>
> What do you think?

Your proposed sentence is incorrect, the diff doesn't involve the tip
of topic at all. It shows the diff between the merge-base and the tip
of master. Ie, the combined diff of all the commits in the rev-list
range topic..master.

> I would like to add some graphical representation of <2> and <3> but
> I'm a bit loss
> with <3> (and I guess lot of newbies are not really understanding that point).
> Can anybody come up with some ASCII art?
>
> Thanks.
>
> Ciao,

-- 
Mikael Magnusson
