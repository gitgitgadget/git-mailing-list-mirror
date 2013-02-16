From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when run
 with strace
Date: Fri, 15 Feb 2013 16:09:27 -0800
Message-ID: <7vd2w1f7bc.fsf@alter.siamese.dyndns.org>
References: <511E8D84.6060601@gmail.com> <kfmclb$4ro$2@ger.gmane.org>
 <kfmide$4ro$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alain Kalker <a.c.kalker@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 01:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6VLm-00089y-Bq
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 01:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab3BPAJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 19:09:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3BPAJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 19:09:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0A56BC55;
	Fri, 15 Feb 2013 19:09:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2btg0tGr11LdCmmSnL4tvEW+ywY=; b=h3iXXn
	RwNgSrSsrF/XUt4PJZFHoH8kwZ5rPyNSLH3jhT0+spNDVX2frsxcPOg05ZiELfKP
	7nsD7DffDeUGEBhZYCVsI4ZKHdOuDQrkRaiHhWF9lIwAtUuqlMFNpxUFoF8ObQKp
	8TqZMBB32ErXLIe0hBqXIFWBbyvPXyKOcJJTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iiU38Skrdns5/x3xeskqOKoNA0f7OCVY
	02ZEYxv+YpdYUnFLlDJ5fsb50M448OMwGSQ1Y1Rc1f6OyOPNiREWRb5EdLux9Oaf
	uAgzvyu1Lqwa58sNN9fSsL5yEs2gWXh6jY0Ex1aCuQLwXNDLE4z3zbpNa2FFyBgv
	ve2Gc/3gCf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C58CABC54;
	Fri, 15 Feb 2013 19:09:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D51CBC53; Fri, 15 Feb 2013
 19:09:29 -0500 (EST)
In-Reply-To: <kfmide$4ro$3@ger.gmane.org> (Alain Kalker's message of "Sat, 16
 Feb 2013 00:03:58 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21C73D24-77CD-11E2-8FEF-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216369>

Alain Kalker <a.c.kalker@gmail.com> writes:

> P.S. I hereby promise to _never_ _ever_ alias `git` to something else and 
> then post a Git bug about that "something else" on this ML.
>
> Sorry to have wasted your time,

Thanks.

People around here tend to be quiet until they sufficiently have dug
the issue themselves; unless the initial report grossly lack
necessary level of details, you may not hear "does not reproduce for
me" for some time, so some may still have been scratching their
head, and your honestly following-up on your message will save time
for them.  Thanks again, and happy Gitting ;-)
