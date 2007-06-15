From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Fri, 15 Jun 2007 15:59:24 +0100
Message-ID: <tnx1wgds1pv.fsf@arm.com>
References: <4671B96A.1080202@midwinter.com>
	<20070615030542.GA30110@diana.vm.bytemark.co.uk>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Grimm <koreth@midwinter.com>, "'git'" <git@vger.kernel.org>
To: =?iso-8859-1?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDa3-00061p-3g
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbXFOPTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 15 Jun 2007 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXFOPTR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:19:17 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45558 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbXFOPTR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:19:17 -0400
X-Greylist: delayed 1169 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2007 11:19:16 EDT
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l5FExPrc016925;
	Fri, 15 Jun 2007 15:59:26 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 15 Jun 2007 15:59:25 +0100
In-Reply-To: <20070615030542.GA30110@diana.vm.bytemark.co.uk> (
 =?iso-8859-1?q?Karl_Hasselstr=F6m's_message_of?= "Thu, 14 Jun 2007 20:05:42
 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Jun 2007 14:59:25.0770 (UTC) FILETIME=[C3F3C2A0:01C7AF5D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50267>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-06-14 14:55:54 -0700, Steven Grimm wrote:
>
>> I've asked this on IRC a couple times and nobody seemed to have a
>> good answer, so: These two tools seem like they are solving the same
>> general problem using similar approaches. They are both under active
>> development. In what areas is each of them stronger than the other?
>> Why would one choose to use one of them instead of the other?
>
> I have never had a close look at guilt, but from what I remember it
> stores patches as plain old plaintext patches (corrections to this
> statement welcome). StGIT uses git's object database.

I haven't tried quilt either but, if it uses plain text patches, the
disadvantage might be the losing of the three-way merge when pushing a
patch onto the stack. The solution is to remember which commit the
patch applies to, switch the tree, apply the patch and merge with
HEAD.

Are the guilt patches accessible as commit objects at the top of the
stack?

StGIT might have some more features as it is older but I see a lot of
development is going on with guilt. Another difference is that StGIT
is written in Python and guilt uses shell scripts (some people don't
like the dependency on Python).

I would welcome such a discussion (so please keep me cc'ed) as we can
share the experience with various issues.

--=20
Catalin
