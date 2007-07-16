From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 14:58:57 -0700
Message-ID: <469BEA21.5080308@slamb.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org> <20070716200024.GD16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org> <20070716202550.GH16878@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161332280.20061@woody.linux-foundation.org> <469BE1D4.1070408@slamb.org> <alpine.LFD.0.999.0707161442410.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 23:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAYbH-0006Yd-Bk
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 23:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761212AbXGPV7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXGPV7Y
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 17:59:24 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:60018 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760796AbXGPV7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 17:59:23 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id B4F8898105;
	Mon, 16 Jul 2007 14:59:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <alpine.LFD.0.999.0707161442410.20061@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52728>

Linus Torvalds wrote:
> 
> On Mon, 16 Jul 2007, Scott Lamb wrote:
>> But Solaris remove() is broken, too, so it's a moot point.
> 
> In fact, with the Solaris behaviour for unlink(), you *cannot* have a 
> non-broken "remove()".

I'd hoped to see that they made a new syscall to properly implement the
new behavior. But they didn't. It reminds me of glibc's pselect().

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
