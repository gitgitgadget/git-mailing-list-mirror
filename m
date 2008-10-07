From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Tue, 07 Oct 2008 07:52:02 +0200
Message-ID: <48EAF902.3040402@viscovery.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr> <20081007012044.GA4217@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 07:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5Xh-0004B4-7o
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 07:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYJGFwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbYJGFwH
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 01:52:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16852 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbYJGFwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 01:52:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kn5UJ-0005ML-EJ; Tue, 07 Oct 2008 07:52:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 05B9254D; Tue,  7 Oct 2008 07:52:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007012044.GA4217@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97666>

Jeff King schrieb:
> On Mon, Oct 06, 2008 at 05:15:22PM +0200, Matthieu Moy wrote:
> 
>> Actually, I understand you don't want git gui and gitk to load MS-Word
>> anytime you click something, but I'd love to see the textconv+diff in
>> gitk.
>>
>> (yeah, that's pretty hard to specify right, the ideal requirement
>> seems to be "in a gui, use the good part of the diff driver, but not
>> the other" :-\).
> 
> I think it is even more complex than that. Sometimes when doing "git
> show" I want to see the textconv'd version, and sometimes I don't. So I
> really want a command-line flag or environment variable that I can use
> to control it (with a sane default).

How about this: If I run 'git show -- foo.doc' (foo.doc resolves to a
single path, obviously), I want MS Word, but for other uses of 'git show'
I don't. I think that heuristics could be very effective: With a plain
'git show' I get the overview of the change, and with 'git show --
foo.doc' I drill down into a single document.

Or this: 'git show -p' uses the textconv'd version, 'git show' does not
("Binary files differ").

BTW, also with 'git diff' I sometimes don't want MS Word to pop up...

-- Hannes
