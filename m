From: Sean <seanlkml@sympatico.ca>
Subject: Re: How about cherry-pick --squash?
Date: Fri, 14 Mar 2008 11:25:01 -0400
Message-ID: <BAYC1-PASMTP015BC6B5B35F790E097CBEAE0A0@CEZ.ICE>
References: <46dff0320803140815q5a342f5fjdde02c6b5fde4e5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBnE-00028c-Bi
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYCNPZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbYCNPZV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:25:21 -0400
Received: from bay0-omc2-s26.bay0.hotmail.com ([65.54.246.162]:8126 "EHLO
	bay0-omc2-s26.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752815AbYCNPZV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 11:25:21 -0400
Received: from BAYC1-PASMTP01 ([65.54.191.161]) by bay0-omc2-s26.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 08:25:20 -0700
X-Originating-IP: [70.54.5.51]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.5.51]) by BAYC1-PASMTP01.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 14 Mar 2008 08:25:20 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JaCiQ-0007ve-Ne; Fri, 14 Mar 2008 11:25:06 -0500
In-Reply-To: <46dff0320803140815q5a342f5fjdde02c6b5fde4e5f@mail.gmail.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 14 Mar 2008 15:25:20.0465 (UTC) FILETIME=[9D652410:01C885E7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77238>

On Fri, 14 Mar 2008 23:15:32 +0800
"Ping Yin" <pkufranky@gmail.com> wrote:

> Sometimes i want to cherry pick a commit, but i don't want the commit
> message of this commit. What i  want is the patch corresponding to
> this commit to be squashed to the top commit?
> 
> Now i have to type
> 
> git format-patch -1 --stdout  <sha1> | git apply --index && git commit --amend


Hi Ping,

There is an easier way:

$  git cherry-pick -n <sha1>
$  git commit -a --amend

HTH,
Sean
