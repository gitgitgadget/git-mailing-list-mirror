From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 22:11:13 +0200
Message-ID: <237967ef0808221311o2c4b1b38m7a6ab1664dff686@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andi Kleen" <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWczb-0001Gr-FT
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYHVULP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbYHVULP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:11:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:58696 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbYHVULP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:11:15 -0400
Received: by ug-out-1314.google.com with SMTP id c2so223818ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ua7nn0nTWOaHiOoEb9BdSUI6q2pgzqgNPdug3sy3nJU=;
        b=xL6aDetEv4MI7wbxKwOwi/iB0WMJFa9Sh3gYucVtsQTQeFAyF2tOiDMBlmJ4gQ8WNU
         0kffvikKmJBf3eJDguL43mybcsxcwOZs6aNZtA7p0wZRP8zsLF+UzhPkqMe2w1yCmnpa
         tEuBhtADsmcT6VyKO57k2txyK2I6J0BjDxksY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YmCVU9NdBVwAShOqUwf17+gsyv9iTNHSd8y2lqyjbShjAC0r3BxDncA70SAebgdAoR
         Wd5cjMCnqBxwtbAAUaI3i/pEmTQ4db8m88cNimYmt9FNn1B9YR+AeTOmqcZKoaS16UaS
         vkFvW+LNIe8ZUH2gU2Vx0t9ORWhD6kr4AInBY=
Received: by 10.210.127.13 with SMTP id z13mr2004205ebc.106.1219435873921;
        Fri, 22 Aug 2008 13:11:13 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Fri, 22 Aug 2008 13:11:13 -0700 (PDT)
In-Reply-To: <20080822174655.GP23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93354>

2008/8/22 Andi Kleen <andi@firstfloor.org>:
>
> A common use case for git here is to just use it as a code
> downloader without actually changing anything in the main branch.
>
> Especially in Linux kernel land there seem to be quite a few tree
> which are frequently rebased, which means that the usual "git pull -u"
> usually leads to conflicts even when one hasn't changed anything
> at all and just wants the latest state of that tree.
>
> I found this initially quite frustrating ("$@#!-git cannot
> even download new trees"), until I managed to
> script the necessary magic incarnations after some
> documentation study (which are quite a handfull to type manually).
>
> But I presume that's a reasonable common usage. Would it
> make sense to have some standard git sub command that does that?
> ("get latest state of remote branch, doing what it takes to get it")
> Or is there already one that I missed?

I'm pretty sure "git pull --rebase" will handle this case. You can set up
a config variable (per branch if you want) to make it the default so you
can just "git pull" again.

-- 
Mikael Magnusson
