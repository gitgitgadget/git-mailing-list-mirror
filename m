From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] README: use markdown syntax
Date: Tue, 23 Feb 2016 20:50:25 +0100
Message-ID: <vpq60xfgq9q.fsf@anie.imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-2-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqoab71c09.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:50:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYIyh-0002pn-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbcBWTub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:50:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49311 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997AbcBWTub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:50:31 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJoMr0032005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 20:50:22 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJoPVd014334;
	Tue, 23 Feb 2016 20:50:25 +0100
In-Reply-To: <xmqqoab71c09.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:07:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 20:50:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NJoMr0032005
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456861824.49106@adDaUpU4blUrqqiefK5YzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287106>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This allows repository browsers like GitHub to display the content of
>> the file nicely formatted.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>
> To be honest, I have the most problem with this step in the whole
> series.
>
> Markdown when rendered may be easier to read, but plain text is even
> easier, and it somehow feels backward to cater to those who browse
> at GitHub sacrificing those who use "less" in the source tree.

Well, actually almost all the page was already in markdown. The real
change done by this patch is a rename, and change the asciiart in the
title:

>> --- a/README
>> +++ b/README.md
>> @@ -1,8 +1,4 @@
>> -////////////////////////////////////////////////////////////////
>> -
>> -	Git - the stupid content tracker
>> -
>> -////////////////////////////////////////////////////////////////
>> +# Git - the stupid content tracker

Markdown would also accept ascii-art underlining.

Git - the stupid content tracker
================================

we can use this if people think it's easier to read in the source.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
