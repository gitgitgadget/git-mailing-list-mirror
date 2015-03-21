From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] Fixing memory leaks
Date: Fri, 20 Mar 2015 20:21:29 -0700
Message-ID: <xmqqa8z7c9xi.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:21:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ9yi-00068N-Mj
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbCUDVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:21:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbbCUDVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:21:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D4C2426B9;
	Fri, 20 Mar 2015 23:21:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AgF3QQ8R/zFfEYmfFfl0W89y/MM=; b=S1K0vK
	wHyjbn1x/W2Z4XG+hIXgsHE5eY5R6WauAHumfOLcRxPgpMjoAXldp4QPxYanNjMY
	02pEZLiq53OvpWdZYRnFvdIPe75+TGMe8QPLM/s9B5RmSIQhaOcsuSBMg6mOt/9v
	CcEr6kf6Hjo0BTHYuxc8Jb0bYjlwJIJ+ipQKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m9KDqelwA8k8xAFsjbYEfhKEuyc/lJyx
	9IKi3UaH/v+mbsmnz2UfbyaO7qv+T4n4t1bcgux3aXFwo3KTDdh9V88AOubCsTua
	kt9PYGWLV77zDH2cSETlBz4XRYOE6oD2sg5GOctGu8GmLg3XkHmOgMepCqzkUWr4
	DKfAd3/I+Sw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 841B9426B8;
	Fri, 20 Mar 2015 23:21:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A20B426B7;
	Fri, 20 Mar 2015 23:21:30 -0400 (EDT)
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:27:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E73A0C2-CF79-11E4-95D7-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265999>

Stefan Beller <sbeller@google.com> writes:

> So here comes another bunch of mem leak fixes.

Looked mostly sensible.
