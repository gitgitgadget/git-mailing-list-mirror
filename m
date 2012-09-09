From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Sat, 08 Sep 2012 20:31:49 -0700
Message-ID: <7voblfub16.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 09 05:32:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAYGR-00049U-8o
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 05:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab2IIDbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 23:31:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223Ab2IIDby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 23:31:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F5AA95A1;
	Sat,  8 Sep 2012 23:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HJJOAP5mB+0md70galbT9sj6wSE=; b=Gnijnl
	Fp+1BJQ8GGKe2//Zu0gUiBSWfZ5PGep3R2Bsz++Ej4YKi/3ATQIrdPN6E5uUbwIV
	W9rNc+OwTrUrsCXQERZxv0qb0H9b1EKlMr26xwUgOzhbzvD69xJ4fVaNOVmfkRYk
	3o5T0dDchHJ7wfSKw/bIQ5ehlSIZ5M9zUU+W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wyrbELuru//qSf5f9tBkSSjmuRbWeOAj
	Bn4GvNFaoYL+y3EPBIy2k/6ggviWJCsC9ER07asPl0nxM/F4DvgP7kXiu9b2Ea2o
	bgppuasM3rooDBhQrN6rLz8La6kRFtyNmNpGPs+hJKM8YCLECI1FY/Od8x1iPMHl
	Wwei6BkzK8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2A295A0;
	Sat,  8 Sep 2012 23:31:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08A66959F; Sat,  8 Sep 2012
 23:31:50 -0400 (EDT)
In-Reply-To: <3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley> (Philip Oakley's
 message of "Sat, 8 Sep 2012 21:40:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4B69720-FA2E-11E1-B874-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205035>

"Philip Oakley" <philipoakley@iee.org> writes:

> Having said that, it would therefore be better to point folk at gitcli
> in a few more places, not just the 'see also' line at the very end of
> the general 'git' page, and buried within rev-parse.

Didn't we update the very early part of git(1) for exactly for that
reason recently?
