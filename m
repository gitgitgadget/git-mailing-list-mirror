From: Miles Bader <miles.bader@necel.com>
Subject: Re: Git branches - confusing behavior
Date: Mon, 12 May 2008 16:49:47 +0900
Message-ID: <buohcd4ufl0.fsf@dhapc248.dev.necel.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
	<4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet>
	<4826EEDF.4010404@gmail.com> <20080511132752.GA22778@atjola.homenet>
	<4826F72D.2070205@gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 09:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvSoB-000190-GN
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 09:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbYELHuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYELHuE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 03:50:04 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:34828 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYELHuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 03:50:03 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m4C7nowo010950;
	Mon, 12 May 2008 16:49:50 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Mon, 12 May 2008 16:49:49 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Mon, 12 May 2008 16:49:49 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 61253426; Mon, 12 May 2008 16:49:49 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <4826F72D.2070205@gmail.com> (Dima Kagan's message of "Sun, 11
	May 2008 16:39:57 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81839>

Dima Kagan <dima.kagan@gmail.com> writes:
> My proposed change shouldn't necessarily break the described
> workflow. Git can keep the current behavior for new branches, but
> automatically 'stash' the changes when checking-out an existing
> branch.

It's not going to happen, at least by default.  Many people already rely
on -- and like -- the current behavior, which is often quite convenient
(edit some files and then realize "oh, I should commit these to another
branch"... no prob! :-).

Occasionally it is inconvenient, of course, but git offers mechanisms to
use in such cases, most notably "git stash" (and of course super-cheap
local branches which can be amended or even deleted later).

I think the real problem here is that you haven't quite gotten used
to git yet.

-Miles

-- 
Faith, n. Belief without evidence in what is told by one who speaks without
knowledge, of things without parallel.
