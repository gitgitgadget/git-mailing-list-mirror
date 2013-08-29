From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 11:37:46 -0700
Message-ID: <xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
References: <20130829180129.GA4880@nysa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF76W-0000F7-AD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab3H2Shw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:37:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756575Ab3H2Shu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:37:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8C83D4D0;
	Thu, 29 Aug 2013 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnvDJhsISNDTuqu7A1Si42l+J98=; b=J6Cf05
	YUZpw1F10UTlqgmwOJyLSWj+H6IlQ4RTpjUiOH5lVrAjhETR26f0s9tqjkNr7o1j
	FXdVOs2cLnZM7tdG5P+M9hqk6HeW4Hji8fb1cClvcfDz9zWfGfkeCnFgtGeO4cuv
	zRr4sX4F27s8tzgiUwIz74QrmNMWWLqGIwd2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ACNIk/ybgh05CWvtL1lNgCmXmQl3o6CS
	0TPLk78NjMnRz1tNS80QjIOOJMNSrsEDDu2TtK/2WBQvMu6oLCG80EqX0LAYeUZb
	XKIoOuiPR3cCCssnWN5b8UVhEARjgF+iiyW7kmceB/q4mTlI+G7QLORoHe7ji7Q/
	bxxN1OEGLeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE383D4CE;
	Thu, 29 Aug 2013 18:37:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2415F3D4CD;
	Thu, 29 Aug 2013 18:37:48 +0000 (UTC)
In-Reply-To: <20130829180129.GA4880@nysa> (Felipe Contreras's message of "Thu,
	29 Aug 2013 13:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A5D2660-10DA-11E3-A87F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233328>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It has been discussed many times in the past that 'index' is not an
> appropriate description for what the high-level user does with it, and
> it has been agreed that 'staging area' is the best term.

"add" is the verb, not "index" (which is a noun that refers
to the thing that keeps track of what will be written as a tree to
be committed next).

And it will stay that way.

IIRC, when this was discussed, many non-native speakers had trouble
with the verb "to stage", not just from i18n/l10n point of view.
