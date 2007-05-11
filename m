From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Fri, 11 May 2007 14:51:33 +0200
Message-ID: <vpq1whn7cbu.fsf@bauges.imag.fr>
References: <vpq7irfengj.fsf@bauges.imag.fr>
	<8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:51:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmUb7-00049l-KS
	for gcvg-git@gmane.org; Fri, 11 May 2007 14:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660AbXEKMvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 08:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbXEKMvp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 08:51:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:46774 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271AbXEKMvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 08:51:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4BCpYFT005152
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 14:51:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HmUas-0002yC-0K; Fri, 11 May 2007 14:51:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HmUar-0000vh-UI; Fri, 11 May 2007 14:51:33 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com> (Lars Hjemli's message of "Fri\, 11 May 2007 13\:27\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 11 May 2007 14:51:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46957>

"Lars Hjemli" <lh@elementstorage.no> writes:

> On 5/11/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Hi,
>>
>> I'm using git-svn, which usually works fine, but I occasionally get
>> this:
>>
>> $ git-svn dcommit
>>         A       file1
>>         A       file2
>> Network connection closed unexpectedly: Connection closed unexpectedly at /path/to/git-svn line 401
>
> Is this happening if you dcommit a file in a new directory?

There seem to be a correlation, yes. Usually, simple commits will work
fine, and when I do something complex with the filesystem, it breaks.
I don't remember all the cases where it broke, but at least, last
time, it was about a new file in a new directory, yes.

-- 
Matthieu
