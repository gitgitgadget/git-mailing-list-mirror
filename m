From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 11 Sep 2014 15:20:32 -0700
Message-ID: <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:20:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSCjL-0006W5-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaIKWUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:20:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52793 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbaIKWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:20:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 820393ACA6;
	Thu, 11 Sep 2014 18:20:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5t6Ogl6tToCCeW3SfUSUlVeVss=; b=g0KhIu
	CXp7Bg4RelZutKgEDPkVb4jeXYXQKV+TNTz1kDJeRZzOy3jbfTCoNILd4fmkLspu
	08yP4UKgPSR0NRNB++k5qtT7hm46kgVYO4uPN0FL7PXzTB/ARPF9giII9nfycZfy
	zPzZnVuCAC5lD7ea6A5Mtml6Z6JpWrQ9eqgaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rp9WBI1v3tEBbQyk5fNQZ5brvB/1VvRm
	KqFZmjzoW/WhdbwdVIDkOFxXwg1h3lIv2wvuSVC+IgTQlDkuObDtggEr4xU88b79
	/xlV2TaloeL4Qyhzll+quA+j7wLArDxsBPmXc4OB8djFJpfrKGpFZr8RC6Gs8iR7
	hlrkJyIBv2o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 787713ACA5;
	Thu, 11 Sep 2014 18:20:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED9013ACA2;
	Thu, 11 Sep 2014 18:20:33 -0400 (EDT)
In-Reply-To: <20140911030318.GD18279@google.com> (Jonathan Nieder's message of
	"Wed, 10 Sep 2014 20:03:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D91BFAB2-3A01-11E4-9D74-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256884>

Jonathan Nieder <jrnieder@gmail.com> writes:

> These patches are also available from the git repository at
>
>   git://repo.or.cz/git/jrn.git tags/rs/ref-transaction

The tag fetched and built as-is seems to break 5514 among other
things ("git remote rm" segfaults).
