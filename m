From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Mon, 29 Oct 2007 20:46:50 -0700
Message-ID: <7vmyu1s1qt.fsf@gitster.siamese.dyndns.org>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
	<46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
	<20071028111443.GA29183@xp.machine.xx>
	<46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
	<20071030005217.GT14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yin Ping <pkufranky@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 04:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imi4R-0008Ua-FP
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 04:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbXJ3Dq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 23:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbXJ3Dq6
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 23:46:58 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59284 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXJ3Dq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 23:46:57 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 63FB62EF;
	Mon, 29 Oct 2007 23:47:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D97E990362;
	Mon, 29 Oct 2007 23:47:14 -0400 (EDT)
In-Reply-To: <20071030005217.GT14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 29 Oct 2007 20:52:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62654>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> 2. pull with subtree strategy
>> ~/git-gui$  git-pull -s subtree git master:master
>
> You are merging in the wrong direction.  You want to merge git-gui
> into git.git:
>
> 	git clone git://repo.or.cz/alt-git.git mygit
> 	cd mygit
> 	git pull -s subtree git://repo.or.cz/git-gui.git master
>
> So you are pulling git-gui into git, not the reverse.

Actually, subtree strategy was designed to allow merging back
and forth.  But the result, as it _is_ a merge, will not omit
any commit from the history from both branches.
