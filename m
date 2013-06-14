From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to cherry-pick a merge?
Date: Fri, 14 Jun 2013 12:44:03 -0700
Message-ID: <7v7ghwo4u4.fsf@alter.siamese.dyndns.org>
References: <20130614193729.17663.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 21:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZuw-0003cc-1B
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3FNToJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 15:44:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3FNToI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:44:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2249628B2E;
	Fri, 14 Jun 2013 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x0J8JFxEqnUAWTLfPy4n+2so050=; b=XelFB2
	9IHYLHP+HW8xQHgjTv6HawjTcpRObkThRfGCHiA/Gj815KdVSFBnU39K89t1CN/l
	R7JBG7ZMK0XtCoSsxPgnWJBbki8UoYSWt+pz21gZIA5gA/b+x4t3Y0Pb7B7LV3wQ
	VOggTfXQi0/Bg26Qn3uaYgnkRJlkIaoAQpK2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQC2C76biVKrSzsJ8QuprHu2+1TS+Yle
	k6kowJ4LsOfO6k1RhtrYtMF3682CqFiq1SXToztFTt6ohEY642gz4aDhkEiKLO2L
	SoJu1v80wyVQk26ZLe5ezJgfdyKd+3vgNg0S36wLlFHzwPS43riKkcUiq4JUnPaY
	Rd8YyE1Aoco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A2D28B2C;
	Fri, 14 Jun 2013 19:44:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBA5128B28;
	Fri, 14 Jun 2013 19:44:05 +0000 (UTC)
In-Reply-To: <20130614193729.17663.qmail@science.horizon.com> (George
	Spelvin's message of "14 Jun 2013 15:37:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5FDD5BE-D52A-11E2-BC3C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227916>

"George Spelvin" <linux@horizon.com> writes:

> Sometimes I'd like to repeat a previously performed merge, preserving
> the commit message.  And, if possible, the conflict resolutions.

Is it "git merge commit^2"?
