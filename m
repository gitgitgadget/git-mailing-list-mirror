From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Document the fact that commit -a is the way to go for simple operations
Date: Mon, 07 May 2007 10:21:25 +0200
Message-ID: <vpqy7k1t56i.fsf@bauges.imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LFD.0.99.0705061904050.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 10:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyTc-0002mW-AP
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbXEGIVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbXEGIVp
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:21:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:58794 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbXEGIVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:21:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l478LQ3R015399
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 10:21:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkyTG-0005fJ-1L; Mon, 07 May 2007 10:21:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkyTF-0003pt-VR; Mon, 07 May 2007 10:21:25 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.99.0705061904050.24220@xanadu.home> (Nicolas Pitre's message of "Sun\, 06 May 2007 19\:07\:48 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 May 2007 10:21:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46431>

Nicolas Pitre <nico@cam.org> writes:

>> --- a/Documentation/git-commit.txt
>> +++ b/Documentation/git-commit.txt
>> @@ -54,7 +54,8 @@ OPTIONS
>>  -a|--all::
>>  	Tell the command to automatically stage files that have
>>  	been modified and deleted, but new files you have not
>> -	told git about are not affected.
>> +	told git about are not affected.  You should use it for most
>> +        trivial operations.
>
> I don't think this patch is worth it.  If anything it might create more 
> confusion.
>
> There are many ways to commit without -a which still could be considered 
> amongst "most trivial operations".

My proposal is not perfect, and I'm sure we can do better.

But the problem with most of git's manpages for beginners is that the
documentation is mostly technical and factual. That is, it tells you
what git will do if you provide such or such option, but not _why_ and
_when_ you should use it.

Probably just a "gitlink:" to the place in the user manual which talks
about the index would be OK here.

-- 
Matthieu
