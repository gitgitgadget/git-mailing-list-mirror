From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make git status usage say git status instead of git commit
Date: Mon, 03 Dec 2007 11:09:24 +0100
Message-ID: <854pf0hyy3.fsf@lola.goethe.zz>
References: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com>
	<7vir3gqr3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8FJ-0001Ss-HL
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXLCKJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXLCKJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:09:29 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:38058 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXLCKJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:09:29 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Iz8Ey-0006hR-3a; Mon, 03 Dec 2007 05:09:28 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5E84B1C4D3AA; Mon,  3 Dec 2007 11:09:24 +0100 (CET)
In-Reply-To: <7vir3gqr3d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Dec 2007 21:34:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66898>

Junio C Hamano <gitster@pobox.com> writes:

> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>
>> As a side question, should the usage information also use the non
>> dash notation of the command since it is deprecated?  I noticed all
>> of the other commands are presently using the dash form, so I left it
>> as is for now.
>
> Wise choice.  We would probably want to clean them up at the same time
> early post 1.5.4.

Deprecating the dash form will probably mean that we need to think up
(and document) a rationale for

  man git-commit

I actually have typed something like

  man git commit

a number of times already with obvious results.  Finger memory.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
