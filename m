From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Mon, 12 Mar 2012 09:11:12 -0700
Message-ID: <7vobs1u7dr.fsf@alter.siamese.dyndns.org>
References: <1kguf28.1u417v5fn74afM%lists@haller-berlin.de>
 <vpq1uoyx9zh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lists@haller-berlin.de (Stefan Haller),
	marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto),
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S77qI-0004wU-U4
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab2CLQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:11:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2CLQLP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:11:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8E165D7;
	Mon, 12 Mar 2012 12:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdfs99HV3W9kU5kR2eaOtTu7IQQ=; b=wLvBax
	p8m76KQqQcAv/HikKYoOJ4iC+KXh7SiGNXJxfJBPxbm/ibmYg5cFrhzczTGzBxcu
	hlzITzIdcnPuHCS5R8FKoeBvST/OxFje5lv6hICBO3omBO0JXj+1uXjH51Ug8yCd
	v0rzYwWhfREfCyXZdSKHLiSyK/Qf73R/YT9v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RUJsQmstLLqDYDPg2k4EPryUK/r78vom
	S4g4Q0a1eX+iwPbO7uaM0G8GiTmhfLmQ1nUqfHv4/DyQ/JYWOPkwTH+Z340ixMwu
	BZunVVY5FpNq07JjO28qEe5IF73VFHRGS73ZPfnYhOKzpydPmyFapXtmj8zqM/+U
	gfIwR4Hb/6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44C0C65D6;
	Mon, 12 Mar 2012 12:11:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D12CD65D5; Mon, 12 Mar 2012
 12:11:13 -0400 (EDT)
In-Reply-To: <vpq1uoyx9zh.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 12 Mar 2012 13:46:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD811F50-6C5D-11E1-BC1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192890>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Just to be clear: I'm not saying that your workflow is wrong, but my
> feeling is that you wouldn't be hurt by 'push.default=upstream'. The
> area of potential improvement for your case would be at branch creation
> time more than at push time.

Your analysis of Stefan's pain points sounds very sensible.
The autoSetupMerge mechanism may want to learn new tricks, but that
is a separate issue and it shouldn't affect the search for a sane
default for push.
