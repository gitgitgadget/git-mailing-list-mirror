From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 18:36:33 -0700
Message-ID: <xmqqtwvy2y8u.fsf@gitster.dls.corp.google.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
	<xmqqbni64kum.fsf@gitster.dls.corp.google.com>
	<20150430010256.GA5089@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndP5-0001ac-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbbD3Bgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:36:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750996AbbD3Bgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 973CA4DC84;
	Wed, 29 Apr 2015 21:36:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BuWL+cwto31MzSmL+7pP5kf/1BY=; b=MxE0Um
	KMWmsZUYF0vuczflSoETjk3apQBmuIT1RRgWZ/A6qyPhOYp/J1/n95Ls/k/0NxwA
	zWyBQpJNxzrldmWI4NLQJrfE7IqVvvkr4R6qHQaQPfUGVa7YCTDtco8QU7M4vtrR
	VBnFTRo1SCoX0iL1Y6m2EWKGbGc/2+8d/sWTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKTKsyFEDeJTFeF9QuHuX9MCePqiWj6k
	6i4wZLxi3pKlssauIIDkMgOYZn2Jl4XCFhSqBiYiQHe/pbGiI4hPnV9xpLlk6O4c
	mh9mJ6G7MD9yk5puXZnnMG5xNe66qIeEvsFgw0F93LjN04+cmqFtMRi2awsnIoGT
	JdCE9OBoSks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F9AE4DC83;
	Wed, 29 Apr 2015 21:36:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 173104DC82;
	Wed, 29 Apr 2015 21:36:34 -0400 (EDT)
In-Reply-To: <20150430010256.GA5089@peff.net> (Jeff King's message of "Wed, 29
	Apr 2015 21:02:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55B392EC-EED9-11E4-985E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268047>

Jeff King <peff@peff.net> writes:

> I can send the intermediate version (i.e., the re-roll with a few minor
> fixups based on list comments), and we can build the other on top, but I
> don't think there's any rush, and it can wait for the refactor (which
> shouldn't be _too_ bad, I don't think).

No rush. I just wanted to make sure none of these is abandoned (and
drop any that is).

Thanks.
