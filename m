From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 08 Oct 2007 08:37:27 +0200
Message-ID: <4709D027.3090003@viscovery.net>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com> <20071008020435.GA20050@coredump.intra.peff.net> <alpine.LFD.0.999.0710071916510.23684@woody.linux-foundation.org> <20071008022205.GA21277@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 08:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IemFL-0006xC-1V
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 08:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXJHGhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 02:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbXJHGhd
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 02:37:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51344 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXJHGhd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 02:37:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IemEz-0007ei-V4; Mon, 08 Oct 2007 08:37:22 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 39B7454D; Mon,  8 Oct 2007 08:37:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071008022205.GA21277@coredump.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60295>

Jeff King schrieb:
> On Sun, Oct 07, 2007 at 07:17:50PM -0700, Linus Torvalds wrote:
> 
>> fchdir() is not portable.
> 
> I was using the "even Solaris has it!" test, but yes, it's not POSIX. I
> don't know how common it actually is (for curiosity's sake, do you know
> of a common platform that lacks it?).

Windows. ;)

-- Hannes
