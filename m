From: ff <ff@member.org>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 14:46:15 -0400
Message-ID: <fa7d16350807111146m18b0ca9q6902c2167bfd3512@mail.gmail.com>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
	 <20080711161923.GE10347@genesis.frugalware.org>
	 <fa7d16350807111107o40c5cbb5xc06c3c56b16b7499@mail.gmail.com>
	 <20080711181413.GI10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNeF-0005ds-Vu
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbYGKSqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYGKSqR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:46:17 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:62843 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbYGKSqR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:46:17 -0400
Received: by py-out-1112.google.com with SMTP id p76so2256031pyb.10
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=EfFgPi5zazeheF9eqP3ZX2AKMDfQTstCDyQEJ3ATjng=;
        b=Mfl9fd3cMy81TTJZsAXWQEkX0dIptaHVgTgi0Wdw1xjUH6V4eTItjWpyTehJmhFObY
         5Y8JhZiilE8bADKd9Q1pGNbLhXRhyiK3UuXGJm/KCmDVHcOfy/mn4qmwRUSeUBJXH+Xq
         QXuOL9hxK8RPnDv6Iqq7YUKWtiYwk9wE2ce8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=e09szYryHcWZxcjAqLL9IE9Wnl7xw/nMeclHlTQNTxgkvOa0NyOcrShOYRnQPy/T2h
         dwUC9RuBvxgBjbAYWvgF1K9QsBOtP+RX7p2G0EvB6OXXdsVpSWuamBWfL9GlwsPumlYb
         EcC9WLJU13dw1ItGgq1JoNs6Kpy6S+nMxMbyw=
Received: by 10.114.124.12 with SMTP id w12mr14361836wac.210.1215801975873;
        Fri, 11 Jul 2008 11:46:15 -0700 (PDT)
Received: by 10.141.91.21 with HTTP; Fri, 11 Jul 2008 11:46:15 -0700 (PDT)
In-Reply-To: <20080711181413.GI10347@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: d1f9e33799931f91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88154>

> [ Did you reply off-list intentionally? ]

ooops... yes... I'm scared of the reply-all button. :)

> For example, if you were on branch 'master' and you merged 'foo' to
> master using 'git merge foo', and you want to revert that merge then you
> need '-m 1'.

Ok, so... sorry for not getting it completely, even after reading the info.

In your example, how and why you can determine that the number 1
represents the "foo" branch? Would "-m 2" represent the master branch?
In your example is there any other choice for the "-m" number to use?

-- ff



On Fri, Jul 11, 2008 at 2:14 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> [ Did you reply off-list intentionally? ]
>
> On Fri, Jul 11, 2008 at 02:07:44PM -0400, ff <ff@member.org> wrote:
>> thank you.
>>
>> I did see the -m option in the revert man page. It talks about
>> "parent" and I did
>> not understand what that is. Is parent the commit id of the merge commit?
>>
>> Thanks again!
>
> http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html#def_parent
>
> A merge commit has two parents, but obviously only one of the was the
> HEAD commit before the merge. So when you revert a merge, you need to
> specify which which parent's tree should be the tree of the new HEAD.
>
> For example, if you were on branch 'master' and you merged 'foo' to
> master using 'git merge foo', and you want to revert that merge then you
> need '-m 1'.
>
