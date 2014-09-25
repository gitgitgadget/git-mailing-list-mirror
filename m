From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 25 Sep 2014 14:35:53 -0700
Message-ID: <xmqqfvff9ydi.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:36:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXGhk-0006XD-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 23:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaIYVf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 17:35:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59593 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbaIYVf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 17:35:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A36703DC34;
	Thu, 25 Sep 2014 17:35:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4KkGYYDeGwhzou4x986jMzpiE/s=; b=vXMtn/
	jIwYTNhX1myJWm0+HgQMrpaIlmsiomyqfKER5uDOsftiRhmLJHIM/Jk/Dhz839pZ
	EDb0sSIjQ/OUl1Bun2xgLMcJToLnD2RoZ9fnZ+gAxiirvJitcSkW7Yh3T9gF/pqD
	gkGNER6cFKjeYe9RVJX1iiJV6wTd8aL0Adn30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9eQG3otBcAgZqOqrZmZ05hX7r1M4Hzc
	HvzB6hdXYVXCEupsMIfjODHgHdGQxlP93WzCxt0qTv08kFMu/PDWHLgeVRUjBLXa
	TciKhLHF9OnpIuz9LM81bVeHfmRibeJoCL77adAXxIvOElh6C2FJkrIZTIOoYWAJ
	5+MXWQNPCuo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99AB13DC33;
	Thu, 25 Sep 2014 17:35:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2171E3DC32;
	Thu, 25 Sep 2014 17:35:55 -0400 (EDT)
In-Reply-To: <20140911030318.GD18279@google.com> (Jonathan Nieder's message of
	"Wed, 10 Sep 2014 20:03:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE2EBDA4-44FB-11E4-9230-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257497>

I know that a review-update cycle is still going in the dark at

  https://code-review.googlesource.com/#/q/topic:ref-transaction

for this series.  Are we almost there for v22 which hopefully be the
final before we merge it to 'next' and go incremental?  
