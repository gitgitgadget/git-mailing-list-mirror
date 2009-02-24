From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Tue, 24 Feb 2009 10:39:36 -0500
Message-ID: <49A414B8.8010906@tedpavlic.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com> <20090223161657.GL22848@spearce.org> <7vab8cpqgl.fsf@gitster.siamese.dyndns.org> <49A40372.2060600@tedpavlic.com> <49A40858.6010108@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzPI-0005Qv-IC
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbZBXPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZBXPjt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:39:49 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:58578 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755756AbZBXPjs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 10:39:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 840AF80D8017;
	Tue, 24 Feb 2009 10:32:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mb85AqCvtHQI; Tue, 24 Feb 2009 10:32:55 -0500 (EST)
Received: from TedBook.local (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 6ABA080D8014;
	Tue, 24 Feb 2009 10:32:55 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <49A40858.6010108@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111299>

>> Keep in mind that "BARE:master" doesn't make much sense. If you're
>
> It reflects what HEAD points to in the bare repository.

Obviously, but that seems disingenuous when you're inside the git dir. 
"HEAD" is supposed to reflect the name of the currently checked-out 
branch, and so it is tied to a working directory. I'm not sure why it's 
useful to show $GIT_DIR/HEAD in PS1 while inside .git as it invites 
operations that probably should not be done while within the bare repo.

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
