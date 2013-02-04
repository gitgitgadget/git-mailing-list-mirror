From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Mon, 04 Feb 2013 08:18:18 -0800
Message-ID: <7vk3qo3ved.fsf@alter.siamese.dyndns.org>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
 <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <vpqpq0hnlb1.fsf@grenoble-inp.fr> <7v1ucx83fz.fsf@alter.siamese.dyndns.org>
 <vpqr4kwmdcs.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:18:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Okm-0007CP-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329Ab3BDQSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:18:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756212Ab3BDQSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:18:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7EACD25;
	Mon,  4 Feb 2013 11:18:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lG/axC676uZnKfAU2qGIfcjOgvY=; b=ndfI+n
	qn2m4pYGqQmWan8ccudQEbMWSIHFNOM79C/0x87U9D+itTOjhMjoaS15WDXq/Tfx
	mVXtDhtHvqj+++WZGDEfRcp5yEvxYRfkIJycQlCIFn5zGqtdmFOUn+yYmL19WEUT
	7yhxfk7ozb7GudLHuyND3KWxmMJkQckYRTqbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f5IvSIsjB+UXZretW0qga8mH5cZ5J72V
	5Fy6KXJLtxtqPZl+UCaT1uDIn4VF/MSfw6EnQ9Oj9PZaNyHVHBpJHEGUzP85hoh9
	yalB/Y4Ueqjk497GJUvuKLooAkokg7WSuFD9eBVo8Num6HFUvnJM+Ycbu72WJOEG
	AoMw1MBJD5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6275FCD24;
	Mon,  4 Feb 2013 11:18:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB75DCD22; Mon,  4 Feb 2013
 11:18:19 -0500 (EST)
In-Reply-To: <vpqr4kwmdcs.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 04 Feb 2013 14:13:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D595202-6EE6-11E2-8C24-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215386>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Just to be sure: "other" here is not a hardcoded message "bisecting
> other", but an instance of "bisecting <branch-name>" with the branch
> being called "other".

OK, then I do not have any objection.  Thanks.
