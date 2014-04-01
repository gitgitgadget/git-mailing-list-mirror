From: "Jonas Bang" <email@jonasbang.dk>
Subject: RE: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Tue, 1 Apr 2014 19:57:26 +0200
Message-ID: <002a01cf4dd3$d88c8640$89a592c0$@jonasbang.dk>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>	<xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>	<002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk> <xmqqha6e8f67.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 19:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV2wQ-0001iO-2w
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 19:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbaDAR5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 13:57:34 -0400
Received: from mail4.surf-town.net ([212.97.132.44]:58348 "EHLO
	mailgw22.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751598AbaDAR5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 13:57:32 -0400
Received: by mailgw22.surf-town.net (Postfix, from userid 65534)
	id 30259F18F6; Tue,  1 Apr 2014 19:57:29 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by mailgw22.surf-town.net (Postfix) with ESMTP id 1CEC1F1932;
	Tue,  1 Apr 2014 19:57:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw22.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw22.surf-town.net ([127.0.0.1])
	by localhost (mailgw22.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nRkJwa8O8IXz; Tue,  1 Apr 2014 19:57:26 +0200 (CEST)
Received: from Mainframe (unknown [5.103.38.58])
	(Authenticated sender: email@jonasbang.dk)
	by mailgw22.surf-town.net (Postfix) with ESMTPA id BA4BCF18F6;
	Tue,  1 Apr 2014 19:57:25 +0200 (CEST)
In-Reply-To: <xmqqha6e8f67.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQNHwG5eq+VqsEUk7jNiAAPbKL6k0gDp71pIAwWu0U4C0+NR5pfV27Lw
Content-Language: da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245619>

> >> For some people it is also a norm to keep files that have been
> >> modified from HEAD and/or index without committing for a long time
> >> (e.g. earlier, Linus said that the version in Makefile is updated and
> >> kept modified in the working tree long before a new release is
> >> committed with that change).  The default behaviour would cover their
> >> use case so your proposal would not hurt them, but I wonder if there
> >> are things you could do to help them as well, perhaps by allowing
> >> this new configuration to express something like "local changes in
these
> paths are except from this new check".
> >
> > Yes, those people would probably use the default 'false' behavior as
> > it is already. If they however would like to use e.g. the 'true' or
> > 'include-untracked' setting as a configuration variable, then they can
> > use the command line option 'false' if they wish to do a 'git
> > checkout' even with modified files in the working tree.
> 
> So in short, you are saying that "The added code necessary to implement
this
> feature will not help them in any way, it is just that we will make sure
it does
> not hurt them".

I didn't realize they needed help. Based on what you describe it seems that
they are quite happy about their current workmode. The feature request I'm
proposing is to aid a different workmode used by a different group of users.

I did try to give it some thought to figure out if it would be possible to
address also your mentioned users workmode, but it didn't seem straight
forward to solve in combination with my feature request, and the solution
wouldn't end up being as simple. However I did already manage to include
proposals on how to address your other comments, I believe.

I have focused primarily on proposing a feature request which is as simple
as possible and which addresses an issue with a workmode for a group of
users, and which in the same time doesn't "hurt" others.

What are your thoughts on that part?
How and who to decide if this is a reasonable feature request to accept?
