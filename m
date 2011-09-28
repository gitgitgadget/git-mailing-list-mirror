From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed push progress?
Date: Wed, 28 Sep 2011 09:35:09 -0700
Message-ID: <7v62kc1v7m.fsf@alter.siamese.dyndns.org>
References: <20110928075054.GA13727@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 18:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8x6Q-0006EG-I1
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 18:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab1I1QfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 12:35:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab1I1QfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 12:35:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D29D4B59;
	Wed, 28 Sep 2011 12:35:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahqoS2T4zq8TlNCaa1IAeudklmA=; b=asqTeg
	8rf1wQfdlNUEcon+Dl/NbBxV0dqpYvxhTLI0sbN+flknalkyTwb+v37bm/2wiXMk
	sxl8O0U+jxYeDRyDafRPgusOzKlx9Y61WAuoWXQXWbVuUhbjsISdDONX5TiFGJLx
	oUVviBq9HQ+gvtHuynKg4xeVrt/l5p5VVq5x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fGhzE3ajbvwWdYdqGWuAsMRoiI64Rt13
	eejoG+BK9VUEZ+345RU8mdxGaiOxq9/r9UTOVFlJdkdvRd2DnwJQ6eqxeMy7Myam
	vmA6vI3+weiIgL+/d4yxlbnVDaz6kxeSsUyihDpnKBRhtKKPzhUWdR9oeDOSWEha
	UPgn+fwKzGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3449B4B58;
	Wed, 28 Sep 2011 12:35:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB5B64B57; Wed, 28 Sep 2011
 12:35:10 -0400 (EDT)
In-Reply-To: <20110928075054.GA13727@orbis-terrarum.net> (Robin H. Johnson's
 message of "Wed, 28 Sep 2011 07:50:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D55BA9D2-E9EF-11E0-8088-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182340>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> from CVS to Git (we're very close now), we've decided that the signed
> pushes will provide better security than our plan of previous plan of
> using signed notes, so we'd like to see signed pushes succeed.

Could you elaborate on your "previous plan" a bit? What is a signed note,
how would it help validate the authenticity, how do developers interact
using it and what do you perceive as weaknesses compared to the signed
push that we discussed a few weeks ago?
