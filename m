From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-add--interactive works only in top level
Date: Tue, 04 Dec 2007 09:45:13 -0800
Message-ID: <7vd4tm5p7a.fsf@gitster.siamese.dyndns.org>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
	<7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
	<4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU>
	<7vmysr9dxg.fsf@gitster.siamese.dyndns.org>
	<9AADB5DF-15FA-4A5F-BF4B-509135E486B6@wincent.com>
	<Pine.LNX.4.64.0712041148310.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Reid Barton <rwbarton@MIT.EDU>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 18:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izbq1-0001mw-AH
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 18:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXLDRpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLDRpV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 12:45:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:32956 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLDRpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 12:45:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D4E0E2F2;
	Tue,  4 Dec 2007 12:45:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BB699AD2B;
	Tue,  4 Dec 2007 12:45:37 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712041148310.27959@racer.site> (Johannes
	Schindelin's message of "Tue, 4 Dec 2007 11:48:57 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67067>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Here he have two options: blame the user for his/her stupidity, or look 
>> at this a UI problem and try to make the UI "idiot proof".
>> 
>> In this particular case I see no impediment to favouring the second 
>> option, because we're not talking about making changes that would make 
>> Git less powerful or useful for "non-idiots", "power users" or "real 
>> men" (whatever you want to call them). In other words, we are not 
>> talking about "dumbing down" Git for the sake of the ignorant. This is 
>> an opportunity to polish the UI in the same way that we polish the 
>> internal pack format.
>
> You know, without patches you will not convince me ;-)

Honestly, I do not want a patch for that to git-add--interactive.

Once WIncent's and Dan's UI enhancements to it becomes stable (not
implementation-wise but more interface- and user-experience-wise),
rewriting it in C should not be too much of a hassle.  When that
happens, it won't be a standalone program but will be a function
builtin-add.c::interactive_add() will call into and we won't have this
problem at that point.  If somebody does do a patch, the time is better
spent there instead.
