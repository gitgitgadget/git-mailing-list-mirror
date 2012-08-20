From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 10:23:36 -0700
Message-ID: <7vvcgdjx47.fsf@alter.siamese.dyndns.org>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
 <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
 <7vobm5lejl.fsf@alter.siamese.dyndns.org>
 <CABPQNSZpS6YX-WSp7nYnav+Szk0V-N9nx-F+RXtZLw7s6KMBQg@mail.gmail.com>
 <7v8vd9ldxh.fsf@alter.siamese.dyndns.org>
 <CABPQNSZcyftefO1ikXRj6fqjDxwH1_6rwCLvt4z6Z4g6pGc-Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 20 19:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Vhc-0004Bt-So
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab2HTRXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:23:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421Ab2HTRXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:23:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F568736;
	Mon, 20 Aug 2012 13:23:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTeCzPM1aeTBNZOneGq/E1CJhcA=; b=QLA6yl
	QA/z37bOBzqTYvE/lpfhvzI+3q30I9UDzUD2aXmO3o/bwToSR9zqR0vDB25nMqPy
	jkO8HhzNCSVdFIXzeJNKTtqBJsspO9cqdUW1Vq7nWDkixS3F0wWEAs/LrOSEVl0S
	EA7/qP4e0CwdFRe0yLrS4hXANhsvGFoUNFzRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/38RYUD4t1R6pjoBoSt63xMUVs/LcYv
	emOmRnA+qbaC23VRtgEGqANfT/1qqjFr7XMag3a8Rmmr98h3rsi7O8e2rpi/ID1G
	pb+kkuBlJUurUdot9CklCStG8m37Voe9lo/MzEvDYalH2OrFP7bIxHCqp3jfOq5v
	OUz+B5e9G/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D838734;
	Mon, 20 Aug 2012 13:23:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77F568733; Mon, 20 Aug 2012
 13:23:37 -0400 (EDT)
In-Reply-To: <CABPQNSZcyftefO1ikXRj6fqjDxwH1_6rwCLvt4z6Z4g6pGc-Ow@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 20 Aug 2012 18:37:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7048AEA-EAEB-11E1-B174-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203859>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> OK, so is this a good description to go in the merge commit when it
>> goes to 'master'?
>>
>>     * ef/win32-cred-helper (2012-08-16) 1 commit
>>      - contrib: add win32 credential-helper
>>
>>      Credential helper for Win32, to allow access to the keychain of
>>      logged-in user.
>>
>
> Looks good to me.

Thanks.
