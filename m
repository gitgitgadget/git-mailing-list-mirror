From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed, 08 Aug 2007 22:08:48 +0200
Message-ID: <85lkclrdpr.fsf@lola.goethe.zz>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
	<Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrq4-00049m-F3
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934364AbXHHUIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934330AbXHHUIy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:08:54 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:57871 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762731AbXHHUIx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 16:08:53 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 7DCCC37A70D;
	Wed,  8 Aug 2007 22:08:51 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 6F945ABEB1;
	Wed,  8 Aug 2007 22:08:51 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 0898212F0B;
	Wed,  8 Aug 2007 22:08:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5C6791C3C79D; Wed,  8 Aug 2007 22:08:49 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Wed\, 8 Aug 2007 21\:42\:19 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3898/Wed Aug  8 20:20:48 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55354>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 8 Aug 2007, Alexandre Bourget wrote:
>
>> ---
>> Adds a context menu for commits, so that a 'rebase' can be done.
>> 
>> Optionally, it will ask if you want to 'stash' current work before doing so.
>> 
>
> You want something like this as a commit message, _not_ between "---" and 
> diffstat.
>
> General question: should this not be in git-gui rather than gitk?  Gitk as 
> of now is really more a viewing tool.

Well, yes.  But git-gui only works on a single branch head at a time,
and that is not enough for rebasing.  It would be really nice if
git-gui did not outsource its branch handling and viewing to gitk.

Could git-gui perhaps be merged with giggle at some point of time?
Another option might be to let it talk with uDraw(Graph) over a
socket: uDraw(Graph) keeps track of the graph layout and tells its
client what has been dragged where.

Rebasing would also be a fine operation for drag and drop on a
graphical revision history/branch system: pull one head onto another,
or mark one segment and pull it onto another head.  And use the reflog
to recover from catastrophes...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
