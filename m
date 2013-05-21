From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix invalid revision error messages for 1.8.3
Date: Tue, 21 May 2013 09:36:41 -0700
Message-ID: <7vy5b8p9wm.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepYP-0008Qp-04
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab3EUQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:36:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872Ab3EUQgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:36:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A1620FAA;
	Tue, 21 May 2013 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pe+dv4O7thsgP4F6cFHokCGdwzE=; b=hiwDmC
	88Li0DhV8xsVh/QsX0KhME6m+5rGVPh1h1lyQwLVjvEQZ2ap1/um9UQARCYuzB9Z
	JloYfRE7MNAREUPQOyGrEGmBgoItHdXUWiS2XhQg9FiTpWrhzuhpb9WDPYM47rsg
	kcr0G/G+XGVi36ucwjbySHrN3/iobRG7I/u3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+Qizd9O94mJ6f36JVyuV7L5FjE56RTO
	qQ8cKFa0/cu6CGbAVV8v7qDeDvRq+thWgwinEpgumnJy7AJ/gWfTXpbp22P/YwcD
	+ETzi3NMx+8l5YMFuK/0P9XlTTFWx77+0oBaCTAqnQnRdxHJj1/xQMzRkNA7IN5c
	7oe+HhKgt8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C8420FA9;
	Tue, 21 May 2013 16:36:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EDD220FA7;
	Tue, 21 May 2013 16:36:43 +0000 (UTC)
In-Reply-To: <1369132915-25657-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 21 May 2013 16:11:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EDDFB2A-C234-11E2-8298-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225040>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Seeing other patches on the list, I decided that I should do something
> for 1.8.3 as well

Fixes to something that are broken the same way between 'master' and
older release versions are the same as enhancements (which you can
view as "fix to lack of feature").  They are not regression fixes
and not for 1.8.3 at this point in the cycle, deep into -rc.
