From: Stephen Kelly <steveire@gmail.com>
Subject: Re: No way to resolve git am conflicts.
Date: Sat, 08 Jan 2011 20:21:42 +0100
Message-ID: <igadg7$4tb$1@dough.gmane.org>
References: <ig9nqq$4ib$1@dough.gmane.org> <20110108163633.GB28898@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 20:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbeMd-0003c4-E2
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 20:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1AHTV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 14:21:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:58670 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab1AHTVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 14:21:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PbeMM-0003VS-K9
	for git@vger.kernel.org; Sat, 08 Jan 2011 20:21:54 +0100
Received: from dslb-092-078-138-003.pools.arcor-ip.net ([92.78.138.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 20:21:54 +0100
Received: from steveire by dslb-092-078-138-003.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 20:21:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-092-078-138-003.pools.arcor-ip.net
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164837>

Jonathan Nieder wrote:

> Stephen Kelly wrote:
> 
>> git am the.patch
> [...]
>> Applying: Introduce new configuation option to override committer
>> information
>> error: patch failed: builtin/commit.c:1352
>> error: builtin/commit.c: patch does not apply
>> Patch failed at 0001 Introduce new configuation option to override
>> committer information
>> When you have resolved this problem run "git am --resolved".
>> If you would prefer to skip this patch, instead run "git am --skip".
>> To restore the original branch and stop patching run "git am --abort".
>> $ git diff
> [...]
>> As git status doesn't tell me what the conflict is, I can't resolve it.
> 
> Have you tried "git am -3" or "git am --reject" (after "git am
> --abort")?

git am -3 worked, thanks.

> 
> I agree that the hints printed are suboptimal in this case.  Please
> feel free to make them better if you have time for it. :)
