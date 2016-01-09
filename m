From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: for-each-ref output order change in 2.7.0
Date: Sat, 9 Jan 2016 19:00:50 +0100
Message-ID: <56914AD2.9060303@kdbg.org>
References: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
 <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr>
 <CAOLa=ZT7n8qCoS81iijf9vswWV+S8n7=4kmbKP0EAMnOenXwSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 19:00:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHxow-0001SH-5J
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 19:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbcAISAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 13:00:54 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:47494 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888AbcAISAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 13:00:53 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pd8H70tTMz5tlD;
	Sat,  9 Jan 2016 19:00:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AE00E51D4;
	Sat,  9 Jan 2016 19:00:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAOLa=ZT7n8qCoS81iijf9vswWV+S8n7=4kmbKP0EAMnOenXwSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283606>

Am 09.01.2016 um 18:21 schrieb Karthik Nayak:
>>> (Note: The alphabetical-ness of the branch names is reversed, which
>>> seems logical given my original sort was -committerdate. A
>>> --sort=refname looks like this.
>>>
>>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>>> refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
>>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>>>
>>> That's probably more correct too.)
>>>
>>> Best regards,
>>> Bryan Turner
>
> This is correct as per the patch, But I'm wondering if this is desired.
> I.E when sorting in reverse order should the fallback (alphabetical sort)
> also be in reverse order?

IMO, the fallback sorting should be in reverse order only when the user 
explicitley asked for reverse order. Just because committer date implies 
some "reverse" ordering should not imply that refs with the same 
committer date should also be listed in reverse alphabetical order.

-- Hannes
