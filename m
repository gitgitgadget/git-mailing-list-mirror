From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: How to push properly a la subversion
Date: Wed, 05 Aug 2009 06:15:04 +0900
Message-ID: <20090805061504.6117@nanako3.lavabit.com>
References: <4A7095CE.8030307@gmail.com>
	<20090729195044.GA27178@dpotapov.dyndns.org>
	<111060c20907300111u4345b1f1x784229c066fb3f88@mail.gmail.com>
	<20090730115448.GB27178@dpotapov.dyndns.org>
	<111060c20908040017y753a3cb4mbc4d7654192a5d1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRMF-00053A-Ts
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbZHDVPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbZHDVPb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:15:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43982 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbZHDVPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:15:31 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id B080611B9BC;
	Tue,  4 Aug 2009 16:15:31 -0500 (CDT)
Received: from 9884.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id 9L71FXLXU4DO; Tue, 04 Aug 2009 16:15:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=NakBkFcqk24RQSx5qVrtREST3h2qEYEUqPTz09tDbZNfuQ4PWK8HH4uFFVPR1MiTuwo43GW1tF2u35coxz9c1zSrp5IyDVqtI12fzkcDd/SFWHkcqeRwTeJCWbmnMSwVTVdk4yxJogm4yK8cdgpCLCItSEZkYcyZvZMaJMfFx+E=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <111060c20908040017y753a3cb4mbc4d7654192a5d1a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124814>

Quoting Matthieu Stigler <matthieu.stigler@gmail.com>

> 2009/7/30 Dmitry Potapov <dpotapov@gmail.com>:
>
> Second, you said
>> So, your normally should never push to the branch that is currerently checked out. (New versions of Git will warn you about that).
>
> Is there a way to avoid that? Manually, do I just need on post A
> (against which it was pushed from clone B) to use:
> git-reset --hard HEAD
>
> And if yes, can I automate that in hooks/post-update in A? Or post-commit in B?

The standard way to communicate changes to a repository with a working tree A from your repository B is to pretend as if A fetches from B even when you are pushing from B to A..

Here are some recommended readings:

 * http://git.or.cz/gitwiki/GitFaq#Whywon.27tIseechangesintheremoterepoafter.22gitpush.22.3F
 * http://git.or.cz/gitwiki/GitFaq#push-is-reverse-of-fetch

 * "Push into another repository" item in http://www.kernel.org/pub/software/scm/git/docs/everyday.html illustrates this with an example.

 * http://article.gmane.org/gmane.comp.version-control.git/123331

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
