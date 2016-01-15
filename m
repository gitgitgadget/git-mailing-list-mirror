From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Fri, 15 Jan 2016 10:54:14 -0800
Message-ID: <xmqqbn8mish5.fsf@gitster.mtv.corp.google.com>
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
	<xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
	<87oaczwvz8.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Fri Jan 15 19:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK9Vt-0006iz-ES
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbcAOSyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:54:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcAOSyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:54:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 423E13A764;
	Fri, 15 Jan 2016 13:54:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SAFpUO7K4teEII+7e7vC0D/XzW4=; b=iwnr2t
	LRzedFevGSfBT5IunhJ+WL28lB96+WEDiYA+R1RrjELNhOOZu6I7Ha83zYzopZxH
	6YyJwfbcROnEMeKyi7nhkZS9v2XtOKYocAuNQDja5PxGqn6zn8W8PwE8niAHYyIV
	Iyy/1dzaN3gLTEvm/jjWX3mcpVxepspoPtwE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9UpdmAV22oRM3l8saGlfEVOyVOR1DkA
	1sukozw6N/CCTTZbtLrpNj1HFU5WDteLo4MFBt+mxA4FG/GRnNa2SMyTPoJHCf9G
	5C9sOO/ciA7Ry74xh5m/d3lYt6MZJLL5MkK6z/W5H/Sfq5CZHlcytT4bJ5Dl3tR1
	xE3FcFadxKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36D413A763;
	Fri, 15 Jan 2016 13:54:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 881103A762;
	Fri, 15 Jan 2016 13:54:15 -0500 (EST)
In-Reply-To: <87oaczwvz8.fsf@waller.obbligato.org> (David A. Greene's message
	of "Tue, 05 Jan 2016 15:35:23 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FE011FC-BBB9-11E5-A6AC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284199>

greened@obbligato.org (David A. Greene) writes:

> If you really don't want to get rid of this, I guess that's ok but my
> preference as maintainer is to reduce the feature set to those things
> people seem to actually regularly use (according to my very unscientific
> Google searches) and add features as requested/evaluated.  --annotate
> isn't a huge maintenance burdern but some of those other changes I
> mentioned do in fact significantly reduce the maintenance burden of
> git-subtree.  I hope I will have some leeway with those, even if they
> change semantics slightly.

OK.  It is easy enough to add back when people complains, so...

;-)

Thanks.
