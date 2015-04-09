From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shallow Push?
Date: Wed, 08 Apr 2015 20:54:17 -0700
Message-ID: <xmqqmw2iardi.fsf@gitster.dls.corp.google.com>
References: <CAHkN8V-pK3ngfShmTrAaR5gixhRKbWwDoM21QBVw6hp8AngTkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Samuel Williams <space.ship.traveller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg3Xx-0008Ms-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 05:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbbDIDyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 23:54:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932416AbbDIDyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 23:54:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BBDF48002;
	Wed,  8 Apr 2015 23:54:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rXzpj8UWjbu1YNpJTLez3HztNcQ=; b=ShtjS1
	tMfzfrdfLzmIv/NRYjhlWq+jjmlfwH78EHEg0iu/whX2LmNX8B5664yGxKlker6s
	aoPd0F9oaTdgDG4ZzYAIhTzUz+LNH1NOVCA1Gj78NtHrGyznUL3UvgRg+deR9d4A
	rE2PqH0acfAdTYdNmiFPd4BC4hkBmistx/XFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qEoio8uAq/JF+8BWwnCt5xcuLB/z8j/d
	3VgUmSqaDoRK9gVLDCVGdJswe+mIcDLTjd5bJxtdxnIprVNNu+kXzi3kGnQc12D/
	lrg7KVYw09X/bFmr4GAivFze50udC/4u0ToXu2vWXZEundsA3uZ8Y3aXOFjsjLH5
	yXOMUOzabyw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 932CF48001;
	Wed,  8 Apr 2015 23:54:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1551D48000;
	Wed,  8 Apr 2015 23:54:19 -0400 (EDT)
In-Reply-To: <CAHkN8V-pK3ngfShmTrAaR5gixhRKbWwDoM21QBVw6hp8AngTkw@mail.gmail.com>
	(Samuel Williams's message of "Wed, 8 Apr 2015 03:08:14 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1958B6D8-DE6C-11E4-AC18-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266982>

Samuel Williams <space.ship.traveller@gmail.com> writes:

> Is it possible to only push what is required to checkout the latest HEAD?

What is the receiving repository expected to have?  Does it have
everything that is required to checkout the back-then latest HEAD
the last time a push was made into it, and you are pushing an
update?
