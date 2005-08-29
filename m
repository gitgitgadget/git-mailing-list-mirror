From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 23:58:23 +0000
Message-ID: <20050829235823.GA19351@localhost>
References: <11252426672473-git-send-email-robfitz@273k.net> <7vslwtein3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 01:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9tUN-00053t-MD
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 01:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVH2X4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 19:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVH2X4X
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 19:56:23 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:17051 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S932085AbVH2X4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 19:56:23 -0400
Received: from [212.17.39.138] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.42)
	id 1E9tU0-0005cJ-Q3; Tue, 30 Aug 2005 00:56:09 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslwtein3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.10i
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7927>

I should have mentioned before, these changes are being used in a
SourcePuller dump file to git import script I've been working on.

> I further wanted to apply the following to the proposed updates
> branch, but even with only the first one applied, it fails its
> own test, t4104-apply-complex.sh:

The test was the problem it tried to work with empty files.

> * Fix processing of a patch file which modifies the same file in git-apply.
> * Fix the processing of multiple patch files with --check in git-apply.
> * New option --ignore-applied for git-apply.

I've fixed up the problems with these patches and rebased them.

> * New option --ignore-whitespace for git-apply.

This change was just wrong and could cause file corruption, I've got
another version in the works which fixes the problem and adds some of
the suggested features.

Robert Fitzsimons
robfitz@273k.net
