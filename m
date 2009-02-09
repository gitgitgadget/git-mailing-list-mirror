From: Jeremy White <jwhite@codeweavers.com>
Subject: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
 as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 07:52:33 -0600
Message-ID: <49903521.1060101@codeweavers.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Bucksch <ben.bucksch.news@beonex.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWbP-00057Z-4U
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZBINxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbZBINxm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:53:42 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58253 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZBINxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 08:53:41 -0500
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWWZw-0008LF-3B; Mon, 09 Feb 2009 07:53:40 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109073>

> Yeah, I think my background dictates that I stay by my word and recommend 
> other mailers than Thunderbird.
> 
> It is one thing to be nice to the "average" user, but another one to be 
> unfriendly to the people making the internet revolution possible.

Gah!  With all due respect, I think this attitude is a part of the problem.

It is clear to me that Ben and all the Thunderbird devs are doing their level
best to make the best possible MUA.

Patch senders are a tiny fraction of the Thunderbird user base, and it's
reasonable to down prioritize our concerns.  Even so, Ben has spent a lot of time
on this issue.   One of my great frustrations on the bug I copied was that 
I thought that Robin was articulating some valid points, but then couldn't 
help flaming on, thereby making it much harder for any human Mozilla dev to want to help.

I'd like to hope that there is a reasonable solution that 
works both for us and for the general public.

I spent some time with the git-format-patch code as well as the Thunderbird
code.  I discovered that if I just injected charset=iso-2022-jp, format=flowed
would stay off! <grin>

Ben, along those lines, we do have the ability to control the entire
body of a possible patch before Thunderbird sees it.  Would it be possible,
or reasonable, for Thunderbird to look for and preserve a 'format=fixed'
setting inside a body that we generated?

Cheers,

Jeremy
