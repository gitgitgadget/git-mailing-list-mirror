From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Wed, 02 Apr 2014 07:05:39 +0200
Message-ID: <87ha6cian0.fsf@fencepost.gnu.org>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
	<xmqqppl0yaf9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIM-0006sp-RN
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbaDBFF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 01:05:56 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:53761 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbaDBFFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 01:05:55 -0400
Received: from localhost ([127.0.0.1]:52803 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WVDN4-0007Qi-Fv; Wed, 02 Apr 2014 01:05:54 -0400
Received: by lola (Postfix, from userid 1000)
	id B77DCE04FD; Wed,  2 Apr 2014 07:05:39 +0200 (CEST)
In-Reply-To: <xmqqppl0yaf9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Apr 2014 15:03:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245707>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't reverted the merge of that "submodule update" topic yet; I
>> should do that soonish.
>> ...
>
> Sigh...  This is giving me a lot of headache.
>
> As 23d25e48 (submodule: explicit local branch creation in
> module_clone, 2014-01-26) has been in 'master' since fairly early
> during this cycle, a lot of topics that are not planned to be on the
> 'maint' branch has forked from the tip of 'master' and are now
> contaminated by that commit.
>
> I think I have a preparatory patch to correctly revert 00d4ff1a
> (Merge branch 'wt/doc-submodule-name-path-confusion-2', 2014-03-31)
> and 06c27689 (Merge branch 'wk/submodule-on-branch', 2014-02-27),
> and also a part of 384364b (Start preparing for Git 2.0,
> 2014-03-07), but I am not sure what to do with them ;-<))

Why not just revert on master?  When merging with the topic branches,
the revert should then override the contamination.

It makes some sense then to rewrite the "submodule update" topic branch
so that when it gets reintroduced, its commits are not negated by the
branch revert on master.

Sounds like a stock case out of the "using Git with topic branches"
book, so what am I missing?

-- 
David Kastrup
