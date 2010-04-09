From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is
 ignored by git?
Date: Fri, 09 Apr 2010 09:52:37 -0700
Message-ID: <7v8w8w36wa.fsf@alter.siamese.dyndns.org>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com> <m3sk74hjkg.fsf@localhost.localdomain>
 <20100409140215.GB27899@thyrsus.com> <vpqy6gw7lio.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, Jakub Narebski <jnareb@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 18:53:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0HS0-0007zt-3u
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab0DIQwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 12:52:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0DIQwy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 12:52:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2631AA909C;
	Fri,  9 Apr 2010 12:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IB3SuzY7jfm5BThnhKfXmZtNG90=; b=WGsdS+
	myJ2o9jPb5Yqdb7U/N0L3iVckOBmZ+ksSjPu++oskgMtwddXVNjHNfFQQqCrY8Ja
	AN2al5+duV3tFpB25RZzngyZCo1w5O18gOn+GCShsv7DLUprufSw4+RxwmbvZ05M
	qUhcbcvkT7Mk3jfjmtLeih5FqskTvgDHV6fKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0KJdy36LwmM6AM9pRpwpwt8tPkVSZyS
	nvAHhWNnJtZ9VIokOfBp7gxl8DvvLoBB9WgUMTERlantB2i+lw5Pyh8I/Lv81bXM
	jCmkewJ9xYxVwNlermZ4QyaFAERj3DxCWG78iCRNSjys16usQM9T9RZXe1Y308Hm
	Kv66Keax8CU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B410BA9092;
	Fri,  9 Apr 2010 12:52:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C559CA908D; Fri,  9 Apr
 2010 12:52:38 -0400 (EDT)
In-Reply-To: <vpqy6gw7lio.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 09 Apr 2010 16\:23\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 525B90FE-43F8-11DF-B374-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144453>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> In short, "git ls-files -t" was written long ago, never tested, and
> probably mostly used by no one.

It was added primarily for Cogito, which is presumably dead by now.
