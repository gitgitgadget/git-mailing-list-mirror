From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Weird message when pulling git version 1.6.6.rc1.39.g9a42
Date: Wed, 09 Dec 2009 12:55:56 +0900
Message-ID: <20091209125556.6117@nanako3.lavabit.com>
References: <hfmijf$dl1$1@ger.gmane.org> <7vmy1t6nye.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 05:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIDis-0007IQ-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 05:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936153AbZLIEAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 23:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936137AbZLIEAF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 23:00:05 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37739 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936139AbZLIEAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 23:00:04 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id BA61211B864;
	Tue,  8 Dec 2009 22:00:10 -0600 (CST)
Received: from 4204.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id BN8POTYIRNMA; Tue, 08 Dec 2009 22:00:10 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rlkiVJrZ7sMK11ZHSU1E6EjEELHnN+kOtOVvdoeqDe5/d0qvOldt0SRebQN7KoMJesPB/Hrq23iImZ5uLruUZJAljaas1iiX2spI0mvnp7Vf97qF0AmdS0wOJjk5OOU8MjTZIBIeF3BuCNhHHop+06OedV9hkc+8ha7UV5bDxIM=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
X-Draft-From: ("nnml:git-mail" 72630)
In-Reply-To: <7vmy1t6nye.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134932>

Quoting Junio C Hamano <gitster@pobox.com>

> Alejandro Riveira <ariveira@gmail.com> writes:
>
>> $ git pull
>> remote: Counting objects: 9, done.
>> remote: Compressing objects: 100% (5/5), done.
>> remote: Total 5 (delta 4), reused 0 (delta 0)
>> Unpacking objects: 100% (5/5), done.
>> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>>    6035ccd..a252e74  master     -> origin/master
>> Updating 6035ccd..a252e74
>> Fast-forward (no commit created; -m option ignored) # what is this ??
>>  net/sctp/sysctl.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> Thanks for reporting.
>
> Warning about a message that the end user didn't give the command is
> clearly wrong.  I guess we would want to revert c0ecb07 (git-pull.sh: Fix
> call to git-merge for new command format, 2009-12-01), and b81e00a
> (git-merge: a deprecation notice of the ancient command line syntax,
> 2009-11-30).
>
> Reverting them will still keep 76bf488 (Do not misidentify "git merge foo
> HEAD" as an old-style invocation, 2009-12-02) that resulted in the change
> we are reverting here, so we are still ahead ;-)
>
>   http://thread.gmane.org/gmane.comp.version-control.git/134103/focus=134145

Sorry for causing too much trouble. I feel bad.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
