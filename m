From: Miles Bader <miles@gnu.org>
Subject: Re: renaming remote branches
Date: Fri, 17 Apr 2009 09:51:36 +0900
Message-ID: <buomyagf6g7.fsf@dhlpc061.dev.necel.com>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
	<20090416065934.GA20071@coredump.intra.peff.net>
	<76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
	<20090416135037.GA7770@coredump.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 02:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LucKi-0000eX-Io
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 02:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZDQAvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbZDQAvt
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 20:51:49 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:37962 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbZDQAvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 20:51:48 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n3H0paEv003014;
	Fri, 17 Apr 2009 09:51:36 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Fri, 17 Apr 2009 09:51:36 +0900
Received: from dhlpc061 ([10.114.114.58] [10.114.114.58]) by relay11.aps.necel.com with ESMTP; Fri, 17 Apr 2009 09:51:36 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 3C03852E274; Fri, 17 Apr 2009 09:51:36 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20090416135037.GA7770@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2009 09:50:37 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116722>

Jeff King <peff@peff.net> writes:
> All of that is assuming that remote renames are common enough to really
> care about. Personally, I've never actually done one.

The use-case which prompted my question was "retiring" obsolete branches
that exist on a public server (which is usually only interactived with
remotely using git).

E.g., a project has a long-term public branch "oink" which is finally
merged to master, and thereafter ceases to be kept up-to-date.
Sometimes the developers are reluctant to delete it becaue they want to
keep the history around.  However simply leaving it in place can be
pretty confusing, as people tend to keep downloading it, not realizing
how out-of-date it is.  A nice compromise is to rename "oink" to
"obsolete/oink", which keeps around the history for easy perusal, but
makes the status of the branch pretty clear at a glance.

-Miles

-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
