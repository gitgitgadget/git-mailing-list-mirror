From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/3] diff: Add diff.orderfile configuration variable
Date: Wed, 18 Dec 2013 16:40:40 -0800
Message-ID: <xmqqr499fzav.fsf@gitster.dls.corp.google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<1387411692-15562-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 01:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtRfW-0000Br-2k
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 01:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab3LSAkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 19:40:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab3LSAkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 19:40:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0555A8F4;
	Wed, 18 Dec 2013 19:40:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+edmSyCGkNreCzShcEvesdGMAk=; b=FzQ3ET
	QlaBgjBgyGaX8+wDX9glA04Nf+8D4niSpVeabvuMUNWg903+vt4PbbBH3DtHmU5I
	Zpdx7u0q0AF8i+91lB7TvdB63W7w2DVv32S7r64yBvjCyACBL4YYXmchSN2TpFSg
	h6Hq0V8oKUNWq9GOcEzeaXOykP9ZBrFFc2hmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nCYyhahpP+a+Tajzo1e+4vAZNK65JuN8
	GiFXlFWf1QkS4meg2bmvsJcfT2tHCTBlKShH19bi7DbVZh2vQQe/pWz8pk/9DMNJ
	VUKLSWkFH8bJ3CTCFfWxwIqpCl683N6fMUoWlD/b+fcswR9VjxtaY2Or0ZCAIh2G
	4auiTJNnsZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 723BA5A8F3;
	Wed, 18 Dec 2013 19:40:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9D195A8F0;
	Wed, 18 Dec 2013 19:40:43 -0500 (EST)
In-Reply-To: <1387411692-15562-1-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Wed, 18 Dec 2013 19:08:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31707EC4-6846-11E3-A13D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239508>

Looks good; will replace and merge to 'next', but not today (I am
already deep into today's integration cycle).

Thanks.
