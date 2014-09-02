From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] headers: improve header dependencies
Date: Tue, 02 Sep 2014 11:19:26 -0700
Message-ID: <xmqqvbp528cx.fsf@gitster.dls.corp.google.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
	<1409515893-48017-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOsgB-0003c3-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbaIBSTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 14:19:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52336 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaIBSTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 14:19:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 340C6368C1;
	Tue,  2 Sep 2014 14:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QUl7wVSUco0lRdR5Pq+yLVKU0Q4=; b=uUuLCR
	qF8+VZxjeuQSxh4PhIowgk6IwAOx0ngMux1IUWc10NopXH45DuQKB1GccrXGb0lC
	myT73f7URgmuyREJA/YSnv2G2oFYpJfVz0cO+aAhr0f7N3jxxtda4sDVv1JtAJJH
	DB0oUf2ED/fAioz7weWTZZO5XsKsxsOfKC5aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0Y2iovuZc/ZSp3Gz1LIuBhLdDgJ9jRW
	X7pmqTD0VetsQH0XGmzfXv1Ctd7N160nD+i80j4ltSNo/FfHgW0pgHISU3bnu1jH
	H4X5mriMyq328RDmUNiGuf8Y6gD7zlJwRpd65MwiAcQzS3NQ3eyqGLU7a13BGJXw
	Bkk6x/aYuQ0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2878A368C0;
	Tue,  2 Sep 2014 14:19:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B05BD368BE;
	Tue,  2 Sep 2014 14:19:28 -0400 (EDT)
In-Reply-To: <1409515893-48017-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 31 Aug 2014 13:11:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD6E16B0-32CD-11E4-8819-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256331>

David Aguilar <davvid@gmail.com> writes:

> Add missing includes or forward declarations where needed.

Sorry, but I am not sure what the "missing includes" refers to in
the above.

As far as I know, we never aimed to make "gcc -c $header.h" happy.
I suspect that that is what you are trying to do here?
