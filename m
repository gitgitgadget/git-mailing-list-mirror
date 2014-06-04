From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jun 2014, #01; Tue, 3)
Date: Wed, 04 Jun 2014 21:15:28 +0200
Message-ID: <538F7050.3040103@web.de>
References: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGf0-00040O-54
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaFDTPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 15:15:37 -0400
Received: from mout.web.de ([212.227.15.14]:64784 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaFDTPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:15:36 -0400
Received: from [192.168.178.41] ([79.193.71.10]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LiUC0-1WFvAb1b00-00cjUH; Wed, 04 Jun 2014 21:15:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:rD7UYe/fdivEbHKo9bxDY47eJKglkbCyA8wed5LUQG2JcRsuIW2
 fo+JF4Qs/45ZO66grTby093fplgKUbBcQPZyeCFvzvYho858R2OYoHXDevCuWSpJygKWQ5j
 s/AZXCcacMvpuDYw1/k7VAfnPVcQc3g2nKG5OF24kNTvKlcY3CZNKapgXUvF3Nmx3PJ5r2e
 iBfS7scA6iZHuqb4wOxSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250773>

Am 04.06.2014 00:16, schrieb Junio C Hamano:
> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>  - commit -m: commit staged submodules regardless of ignore config
>  - status/commit: show staged submodules regardless of ignore config
> 
>  There also are a few patches Ronald Weiss and Jens are working on
>  polishing around this topic, and a patch from Jens each for gitk
>  and git-gui.
> 
>  Waiting for the dust to settle until picking them up all.

To me it looks like the dust settled enough around that part of the
topic and I remember consensus about that change. But it would be
nice to have the gitk and git-gui patches in at the same time.

> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>  - Teach checkout to recursively checkout submodules
>  - submodule: teach unpack_trees() to update submodules
>  - submodule: teach unpack_trees() to repopulate submodules
>  - submodule: teach unpack_trees() to remove submodule contents
>  - submodule: prepare for recursive checkout of submodules
> 
>  An RFCv2 exists ($gmane/241455) with sizable review comments.
>  Expecting a reroll.

Will do, but only after I rerolled the submodule test harness
($gmane/245048) soonish, as I intend to reuse the infrastructure
introduced there for tests.

> * jh/submodule-tests (2014-04-17) 1 commit
>  - t7410: 210 tests for various 'git submodule update' scenarios

Will look deeper into that one in the next days, we really need more
test coverage in that area.
