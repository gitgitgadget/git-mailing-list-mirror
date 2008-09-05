From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for backward compatibility.
Date: Fri, 05 Sep 2008 14:06:55 +0200
Message-ID: <vpqy7266bkw.fsf@bauges.imag.fr>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
	<1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
	<20080904123046.GX10544@machine.or.cz>
	<7v63pb3emm.fsf@gitster.siamese.dyndns.org>
	<vpqaben6r3n.fsf@bauges.imag.fr>
	<7v3akfxd74.fsf@gitster.siamese.dyndns.org>
	<20080905080759.GN10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 05 14:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kba8c-0007uu-00
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 14:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbYIEMI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYIEMI6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 08:08:58 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56676 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbYIEMI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 08:08:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m85C6vsP021211;
	Fri, 5 Sep 2008 14:06:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kba5X-0007Q5-ES; Fri, 05 Sep 2008 14:06:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kba5X-0002Bk-Bo; Fri, 05 Sep 2008 14:06:55 +0200
In-Reply-To: <20080905080759.GN10360@machine.or.cz> (Petr Baudis's message of "Fri\, 5 Sep 2008 10\:07\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 05 Sep 2008 14:06:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95007>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Sep 05, 2008 at 12:29:51AM -0700, Junio C Hamano wrote:
>> diff --git c/Documentation/git-annotate.txt w/Documentation/git-annotate.txt
>> index 8b6b56a..78dc5e2 100644
>> --- c/Documentation/git-annotate.txt
>> +++ w/Documentation/git-annotate.txt
>> @@ -14,6 +14,11 @@ DESCRIPTION
>>  Annotates each line in the given file with information from the commit
>>  which introduced the line. Optionally annotate from a given revision.
>>  
>> +The only difference from this command and linkgit:git-blame[1] is that
>                        ^^^^ between?
>> +they use slightly different output formats, and this command exists only

I'm not sure it's clear enough that "this command" is "annotate" since
you talked about git blame right before, but I'm being picky.

>> +for backward compatibility to support existing scripts, and provide more
>> +familiar command name for people coming from other SCM systems.
>> +
>>  OPTIONS
>>  -------
>>  include::blame-options.txt[]
>
> I like this one.

Meetoo.

-- 
Matthieu
