From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH 1/7] Documentation: do not use regexp in refspec descriptions
Date: Sun, 02 Nov 2008 18:08:56 +0100
Message-ID: <877i7mnjh3.fsf@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
	<1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
	<7v7i7pba2x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 18:10:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwgTA-00049Q-Vg
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 18:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbYKBRI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 12:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbYKBRI7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 12:08:59 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:41422 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYKBRI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 12:08:58 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5730614062;
	Sun,  2 Nov 2008 18:08:58 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 200FA1405A;
	Sun,  2 Nov 2008 18:08:58 +0100 (CET)
In-Reply-To: <7v7i7pba2x.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 30 Oct 2008 22\:35\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99855>

Junio C Hamano <gitster@pobox.com> writes:

> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>> The syntax is now easier to read, though wrong: all parts of the
>> refspec are actually optional.
>
> It probably is easier to read, but strictly speaking it is not
> wrong. The two parts, <src> and <dst>, _always_ exist, even though
> either or both of them can be an empty string.

The colon is not required, though the format suggests that it is.


>>  <refspec>...::
>>  	The canonical format of a <refspec> parameter is
>> -	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
>> +	`[+]<src>:<dst>`; that is, an optional plus `{plus}`, followed
>>  	by the source ref, followed by a colon `:`, followed by
>>  	the destination ref.
>
> I am wondering if it would be clearer and easier to understand if we just
> said:
>
>   	The canonical format of a <refspec> parameter is
> 	an optional plus `{plus}`, followed by the source ref,
>         followed by a colon `:`, followed by the destination ref.
> 	Find various forms of refspecs in examples section.

I think that is an improvement. Removing the word "canonical" would be
even better, IMHO.


Anders.
