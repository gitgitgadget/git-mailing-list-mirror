From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 05 Aug 2007 17:03:47 +0200
Message-ID: <85wswa6n1o.fsf@lola.goethe.zz>
References: <20070803125634.GB28323@fieldses.org>
	<1186318785677-git-send-email-prohaska@zib.de>
	<Pine.LNX.4.64.0708051457110.14781@racer.site>
	<17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bfields@fieldses.org, gitster@pobox.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 17:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhe6-0008I5-RT
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 17:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbXHEPDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 11:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXHEPDv
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 11:03:51 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40770 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754806AbXHEPDu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 11:03:50 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id F18BD303295;
	Sun,  5 Aug 2007 17:03:48 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id D129A23D2D9;
	Sun,  5 Aug 2007 17:03:48 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 6306224E341;
	Sun,  5 Aug 2007 17:03:48 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AF1C91C3D500; Sun,  5 Aug 2007 17:03:47 +0200 (CEST)
In-Reply-To: <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de> (Steffen Prohaska's message of "Sun\, 5 Aug 2007 16\:17\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3862/Sun Aug  5 15:38:34 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55031>

Steffen Prohaska <prohaska@zib.de> writes:

> On Aug 5, 2007, at 3:58 PM, Johannes Schindelin wrote:
>
>> Hi,
>>
>> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
>>
>>> git gui is especially useful because it allows to select diff hunks.
>>
>> You should give a _big_ _fat_ _red_ warning there.
>>
>> If you selectively commit diff hunks, you _never_ tested what you
>> committed.
>>
>> That is the reason we're not advertising git add -i more actively.
>
> Hmm... If you do 'git cherry-pick' or 'git rebase' you also did
> not test what you committed. Should we advertise them less
> actively as well?

Selectively committing diff hunks also means that a subsequent rebase
-i or git-cherry will have to reconsider the same commit as it has
only been incompletely applied.

So it can mean more work later.  Also one would in general have to
edit the commit message (if it describes everything that has been
done).

There are simply consequences for the workflow if you do things
right.  Whether they are worth a "big fat red warning" is one
question, but mentioning them is probably not amiss.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
