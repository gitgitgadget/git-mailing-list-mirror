From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 07/10] t5100-mailinfo.sh: use the $( ... ) construct for
 command substitution
Date: Tue, 22 Dec 2015 21:34:42 +0100
Message-ID: <5679B3E2.7090406@kdbg.org>
References: <1450798073-22811-1-git-send-email-gitter.spiros@gmail.com>
 <1450798073-22811-8-git-send-email-gitter.spiros@gmail.com>
 <567997E4.1000700@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 21:34:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBTdy-0006tU-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 21:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbbLVUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 15:34:45 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:2617 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945AbbLVUep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 15:34:45 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pQ8Xz0wG0z5tlC;
	Tue, 22 Dec 2015 21:34:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9D7D05333;
	Tue, 22 Dec 2015 21:34:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <567997E4.1000700@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282905>

Am 22.12.2015 um 19:35 schrieb Johannes Sixt:
> Am 22.12.2015 um 16:27 schrieb Elia Pinto:
>> -for mail in `echo 00*`
>> +for mail in $(echo 00*)
>
>> -for mail in `echo rfc2047/00*`
>> +for mail in $(echo rfc2047/00*)
>
> True, these are equvalence transformations. But a better way to get rid
> of the back-quotes is to write these lines as
>
> for mail in echo 00*
> for mail in echo rfc2047/00*

Ahem... both of these lines without the 'echo', of course!

>
> No?
>
> -- Hannes
>
