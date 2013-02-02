From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk-git/.gitignore: add rule for gitk-wish
Date: Fri, 01 Feb 2013 16:33:35 -0800
Message-ID: <7vlib78sgw.fsf@alter.siamese.dyndns.org>
References: <1359456750-29342-1-git-send-email-artagnon@gmail.com>
 <20130201235209.GK12368@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 01:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1R3R-0003TA-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 01:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093Ab3BBAdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 19:33:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab3BBAdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 19:33:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C12F6B6CB;
	Fri,  1 Feb 2013 19:33:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0v+Z+7BedULzb5yhPCTldJeh0Kk=; b=mflqAF
	IWiDkCipzNaQxWNbXUgQJIEvesa3rQRBTAX0jpVb0cArxOVvonma9ywHnxHZ6ol3
	Q/n3qnD+OHa/CLQytFSP8+bBv9V920GesNbpGf6P9CVpaTp1OpylOZ46xy4H/gPZ
	dXjyiidmAha4/TxsMVfE9Eqmlpi3wjkELnUK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHNZapiCcl1hsUwMo2rTU24VObwPcctC
	pVwMKO4QWremHSAykhh1R+2twG5eDyupeq14rlWzmIJzIGBZVRigSxQIvwFoEkn3
	VKJ3lGmFIVbcytWNSDVwpI18XtSP2zU0dyOjF+GiBdp4amKu5iwWCw/4SYSxOaOt
	Blp2Bu98XEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B64D6B6CA;
	Fri,  1 Feb 2013 19:33:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37A9FB6C8; Fri,  1 Feb 2013
 19:33:37 -0500 (EST)
In-Reply-To: <20130201235209.GK12368@google.com> (Jonathan Nieder's message
 of "Fri, 1 Feb 2013 15:52:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F04C1B2-6CD0-11E2-80D2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215282>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Looks like this was fixed in the week since last pull.
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/214312
>
> Paul, would it be safe for Junio to pull again?

Thanks.  I think I pulled a few days ago, and the result should have
already been propagated out.

    commit 9a6c84e6e9078b0ef4fd2c50b200e8552a28c6fa
    Merge: 070c57d a8b38d9
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Wed Jan 30 13:52:44 2013 -0800

        Merge git://ozlabs.org/~paulus/gitk

        * git://ozlabs.org/~paulus/gitk:
          gitk: Ignore gitk-wish buildproduct
