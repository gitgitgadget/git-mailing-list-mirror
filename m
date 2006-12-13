X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 00:52:47 +0100
Message-ID: <slrneo14if.qkg.Peter.B.Baumann@xp.machine.xx>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Wed, 13 Dec 2006 23:53:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34265>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudud-00049I-NX for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751770AbWLMXxU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWLMXxU
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:53:20 -0500
Received: from main.gmane.org ([80.91.229.2]:36833 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751770AbWLMXxT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:53:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuduJ-0002gn-Pk for git@vger.kernel.org; Thu, 14 Dec 2006 00:53:04 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:53:03 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 00:53:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

>>  * git-branch is not verbose enough when creating a new
>>  branch, for a new user a little reassurance that what they
>>  meant to happen has happened would be nice.
>
> The same comment applies here.  
>
> However, perhaps you could make lack of "[user] expert = true"
> in ~/.gitconfig to trigger more verbose messages that say "yes
> sir I did what I was told to do".
>
> Not interested in implementing that myself at all, though.
>
>>  Tell them if they
>>  made a branch as well, which branch they are now on.
>
> I think you are talking about "checkout -b" not commit here;
> this might be a borderline (branch creation is less often done
> and it might warrant assuring feedback), but I think it still
> falls into the "doing exactly what it was told to do" category.
>

Yes. checkout -b works. But only _if_ you have read the manpage.
Someone thinking about branching at the current commit would just have

	git branch

in mind (so would I). Its not obvious to say

	git checkout -b <newbranchname> oldbranch

becouse checkout implies to advance to another version.

-Peter
