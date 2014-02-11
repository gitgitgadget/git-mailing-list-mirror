From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Mon, 10 Feb 2014 16:28:33 -0800
Message-ID: <xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 11 01:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD1Db-0004lC-Do
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 01:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaBKA2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 19:28:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbaBKA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 19:28:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 749666B16F;
	Mon, 10 Feb 2014 19:28:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+WCdWALgUG6ckmiIAYZjuXwHgo=; b=jYoTSr
	YgQ+gF/Ovxu3IxA6YhOVQkPl1dVVDEldfCmC/YUWQAWCILlblhLnX0FPAQBpQ6WR
	qvH3oslYX2jO425pFLNg9iMJmJGVD2I55idHHEmoM1rK3YEpKbu4jzAVM8BXqIdu
	/6Nwung5UPtPLl1FFy7WNDpJFfsV1yFd3i59A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZS86UcA7yit0dUKOxejMuluGGE1qAebX
	K3JYNjv4QXancHbzFWa97HMPpOT9vnFoLnWmWQ5P8LL5dZ4tOr5NH5ADsr9ulW0H
	XL+5Vby28BZOaGY+wgdsUf7e2kUm40HlSPeikZjXlFqnfX7aj5GyQrLWBNDlUvaE
	O7V6rWDOFqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EC056B16D;
	Mon, 10 Feb 2014 19:28:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CA326B16B;
	Mon, 10 Feb 2014 19:28:35 -0500 (EST)
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru> (Kirill Smelkov's message
	of "Fri, 7 Feb 2014 21:48:41 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 71AC9972-92B3-11E3-B1C5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241937>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Here I'm preparing tree-diff.c to be ready for the new tree-walker, so that the
> final change is tractable and looks good and non noisy. Some small speedups
> are gained along the way. The final bits are almost ready, but I don't want to
> release them in a hurry.

No worries.  We are not in a hurry to apply non-regression-fix
changes during a pre-release feature freeze period anyway.

This seems to somehow conflict with other topics and does not
cleanly apply on top of your other tree-diff topic, by the way.
