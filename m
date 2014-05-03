From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Evil
Date: Sat, 03 May 2014 08:55:29 +0200
Message-ID: <87siorwdum.fsf@fencepost.gnu.org>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
	<xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
	<20140502074027.GB6288@inner.h.apk.li>
	<87wqe4y3e6.fsf@fencepost.gnu.org>
	<20140503061717.GA19561@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 08:56:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgTrQ-0001Xf-Ts
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 08:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbaECGzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 02:55:42 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45241 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaECGzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 02:55:41 -0400
Received: from localhost ([127.0.0.1]:44282 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WgTrI-0007K8-KN; Sat, 03 May 2014 02:55:40 -0400
Received: by lola (Postfix, from userid 1000)
	id D7B6FE08B6; Sat,  3 May 2014 08:55:29 +0200 (CEST)
In-Reply-To: <20140503061717.GA19561@inner.h.apk.li> (Andreas Krey's message
	of "Sat, 3 May 2014 08:17:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248021>

Andreas Krey <a.krey@gmx.de> writes:

> On Fri, 02 May 2014 10:46:09 +0000, David Kastrup wrote:
> ...
>> What the gibbins?  I don't even use git pull.
>
> I do, but I watch for the fast-forward message
> and undo as appropriate.
>
>> I use git fetch, and then, depending on my needs, I rebase or merge.
>
> I wouldn't mind that, but I have a century of newbies who are used
> to having other people's changes appear in their workspace without
> any interaction. Teaching them the mainline thing (aka first-parent)
> and the commands to properly merge&push is...tricky.
>
> And that goes for every user base, so some improvement would be
> greatly appreciated.

I've seen the proposals for "git update" and whatever.  It's sort of
like having an assembly line where there are separate automatic screw
drivers for screwing and unscrewing.  The latter are hard to find in the
rare case you need them, with quite different handling and looks.

This is modeled after the successful fastening model for nails, where
hammer and pliers look and behave quite differently, so people are used
to handle and arrange hammer and pliers on different racks and have
different numbers for them.

Since this model works well for nails, let's employ it for screws as
well and call right-turning screwdrivers "hammers" and left-turning
screwdrivers "pliers" and sort them accordingly in order to avoid
confusion for beginners and help them learn to deal with screws properly
and deftly.

-- 
David Kastrup
