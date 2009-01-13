From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound
 variable errors.
Date: Mon, 12 Jan 2009 23:50:24 -0500
Message-ID: <496C1D90.1020609@tedpavlic.com>
References: <496C0003.7040909@tedpavlic.com> <7vy6xfew2n.fsf@gitster.siamese.dyndns.org> <200901122157.03658.bss@iguanasuicide.net> <496C19E0.6060308@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 05:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbFn-0007Yw-5S
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 05:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbZAMEu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 23:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbZAMEu1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 23:50:27 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:54344 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338AbZAMEu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 23:50:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BA6EF80D802F;
	Mon, 12 Jan 2009 23:44:43 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxPEouBy6SiF; Mon, 12 Jan 2009 23:44:43 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 6D5A380D8022;
	Mon, 12 Jan 2009 23:44:43 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <496C19E0.6060308@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105453>

> Without the modeline, the vim I was using didn't set ft=sh. It seemed
> like the original authors were careful to use tabs everywhere, which was
> the major reason I used the modeline. I added the fdm=marker just in
> case someone would want to clean up the code someday and do some folding.

NOTE: On my system, I save git-completion.bash to .git_bash_completion. 
Because of that, Vim can't ftdetect off of the file name. The modeline 
allows ft=sh even when you don't end in .sh or .bash.

An alternative (to a Vim modeline) is to put

#!bash

at the top of the script. That would do the same thing as the modeline 
(even though it would never actually get used by the sourced "script").

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
