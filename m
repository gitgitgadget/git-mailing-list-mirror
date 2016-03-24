From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/GSoC] add a add.patch config variable
Date: Thu, 24 Mar 2016 14:20:30 -0700
Message-ID: <xmqqvb4b7eu9.fsf@gitster.mtv.corp.google.com>
References: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
	<1458853787-29807-2-git-send-email-d.f.fischer@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: XZS <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCgJ-00053X-96
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcCXVUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:20:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbcCXVUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A09094EAA8;
	Thu, 24 Mar 2016 17:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fr3BVt2JpQZL6rVt1pmKNtV8fmY=; b=f25/0O
	pMT3idhHIbxSF8C5jmhIB9vkKWScnn7mawXc/njVxDxZLPyDZge2U1QRa/8NQ9su
	1Gcxr7XpYYJx932QH9lb4/2Y6NfoHHl/Bf2Oq7Xm6EclHEIHXb9n58HwuHYDWJ+u
	Djra/qx9WLzrFPwVLHSlNzh2HbyEF8iez3GKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ab6dIMMEOeTGm9eX2Rd+RpFHYlQVwfJ1
	SDJpezP0XE6BW4LK33PUHOwDuVMXHAZz8hwe8g83+adPANpyrJHgkbc90XtWM5V4
	6b2F6M9jLI681QChb6xjkoglfDnhqGUwN7fbtpH+BhW+7+sGfRIRERloYZ35ypOV
	takA92MFOJU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B1D94EAA6;
	Thu, 24 Mar 2016 17:20:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0FBE44EAA5;
	Thu, 24 Mar 2016 17:20:31 -0400 (EDT)
In-Reply-To: <1458853787-29807-2-git-send-email-d.f.fischer@web.de> (XZS's
	message of "Thu, 24 Mar 2016 22:09:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D88B626-F206-11E5-B5E7-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289802>

XZS <d.f.fischer@web.de> writes:

> Users may like to review their changes when staging by default. It is
> also a convenient safety feature for beginners nudging them to have a
> second look at their changes when composing a commit.
>
> To this end, the config variable allows to have git-add to always act
> like -p was passed.

Now with such a configuration in her ~/.gitconfig, how would she
ever run the normal "git add", which perhaps is invoked by one of
the scripts she regularly uses?  E.g. "git mergetool"?
