From: Junio C Hamano <gitster@pobox.com>
Subject: Ready for 1.6.6-rc2?
Date: Wed, 09 Dec 2009 13:54:26 -0800
Message-ID: <7vws0vn78t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 22:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIUUt-0005qG-50
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 22:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbZLIVy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 16:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757300AbZLIVy1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 16:54:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080AbZLIVy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 16:54:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4756FA53DE;
	Wed,  9 Dec 2009 16:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=cz9r
	EXuaeLhcWc7y2FFqzzhVhRY=; b=ui2PvXP5b1lBxqvmvUnbFn0dgDVyl/ssDgiM
	wv+PCxtXCNhz07Hdgsb62Zhu1stVcS9dlmw2xCCta0QguIRzY1jqSIXuouUtGEWJ
	vMVCvXxbIf+wjCKLivcOHUZEBUps/bfFCibvdjRml9g/Qye7cnTYbvgR5e6TW4wf
	bArchFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vC3
	aSTuQ4lTSTWjWD39xKms93nDNe8CqbgBWD+7rsnsJXoGxtp0WunKBbBy+v4uX6zh
	+FgRx5oGD8oguuB0GdV4N8OTriyfuzV9tESfXr+yEd7f+frNy8B+4xmJapKLEQPG
	eyczxAF92gmYMEIltQIXsPHl3EfGxBWfcAxwLMlg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36C80A53DD;
	Wed,  9 Dec 2009 16:54:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71487A53DB; Wed,  9 Dec 2009
 16:54:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D7A3786-E50D-11DE-85BB-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135001>

I see many people have been actively adding commits to 'pu', but we are in
pre-release freeze and I'll be tagging 1.6.6-rc2 hopefully later today.
Depending on how fast the earth rotates, perhaps I'll do so tomorrow, as I
am expecting one order-to-pull from the other side of the globe.

If anybody, including those who are working on new topics, notices a bug
that didn't exist in 1.6.5 in the post-1.6.5 code, please give it a higher
priority than anything else.  Bugs and glitches that we had in 1.6.5 are
what users have lived with, and unless fixes to them are really trivial,
they can stay in the upcoming release a bit longer.

But new bugs introduced after 1.6.5, iow, regressions, are something we
would really want to avoid.

Thanks.
