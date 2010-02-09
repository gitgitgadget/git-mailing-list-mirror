From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 09 Feb 2010 12:06:15 -0800
Message-ID: <7vbpfy9nt4.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B71B574.3010609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NewM1-0003jz-1c
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 21:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab0BIUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 15:06:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab0BIUGY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 15:06:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C80D98ABE;
	Tue,  9 Feb 2010 15:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQfd9Dzazpc5rW6lOq348FiaGEg=; b=Kpj4kb
	Qj7gHRrmGk5WtCSHJC0gyxy4t7WZQZnZrv3OIxAZ+x/HgR+LgD5jTDyWM2z/WNGz
	o1JZLwkLfCxXCXLHvOLc1coIi6bKj64shhVIHBhFvLj1penE8BmCyT0BRAixQZMu
	K8GwcRW95yKT1+JmIj2UjA04GRh32tuHf4PBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYd6ryr8abPef58+FIjrAnowJgYuGgKK
	Xc4EBdAPzSz2GffxjmX1V2aPW+fsWZfNzT/FNMzQwmEbOnAjOvzkIkR5aukFbnBx
	n2tSZ2zj3F919tBZIIWO5/leIwtWsl8q6I4UNulBR5LgRzHmyhpSBZnSG7yWxtfQ
	XLpwZYiTHdo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4677798ABB;
	Tue,  9 Feb 2010 15:06:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 876A798AB9; Tue,  9 Feb
 2010 15:06:17 -0500 (EST)
In-Reply-To: <4B71B574.3010609@web.de> (Markus Elfring's message of "Tue\, 09
 Feb 2010 20\:20\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97645B24-15B6-11DF-BB6F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139439>

Markus Elfring <Markus.Elfring@web.de> writes:

>>
>> We _can_ start experimenting with an option (similar to "checkout -m"),
>> which does:
>>   
>
> Does the documentation need any improvements on the dependencies between
> the mentioned subfunctions?

Sorry, you lost me.  I did say and still think that it would be good to
have in the documentation a separate section that teaches the users what
happens to their uncommitted changes when checking out a different branch
(or an unnamed branch).  But I am at loss guessing what dependencies among
what "subfunctions" you are talking about.
