From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Thu, 12 May 2016 08:39:11 -0700
Message-ID: <xmqqvb2jguao.fsf@gitster.mtv.corp.google.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
	<1459802325-22056-2-git-send-email-alex@fournova.com>
	<xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
	<57040EE0.40503@kdbg.org>
	<C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
	<xmqqy47gi6xz.fsf@gitster.mtv.corp.google.com>
	<D97D1033-70B9-46D5-A672-042DE0283CCA@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Thu May 12 17:39:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0shr-0007Wy-UX
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbcELPjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:39:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752476AbcELPjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:39:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FCB419F88;
	Thu, 12 May 2016 11:39:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dTMssQXDj9foCx9ZbO9Ddte6ey4=; b=pAh3d5
	u/b3QprOTUZxVL3N1nlwLLDiHnHwNuhZZ/9pI80qu9Y2tykHIxNUmm4kZuJZNPxc
	9c7owsn7mzv8jYWhksMu14ilcLdTg3O+OKHn7OfOZdRm5Q1ez/nAnTk1rjGqtw+X
	Mq01vMRvHR6Tfww7Ryys1SpqTXIZreluQ5v2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L33hS00kqy2eK+Ki1R25N65lFX96mcnp
	xwqT3tcoVjDay128I0HfifLneXbrY8nW4sG4nX5cEDNrPSunbc/7J/HrV0clwJaE
	tHzbgJh8IqW7DYFsdLspKTgjh8/kn/LAoAKTvm42h0nKrkDn6BIVyPAGlyexJc/+
	sfBOsySqLPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9797E19F87;
	Thu, 12 May 2016 11:39:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0997419F86;
	Thu, 12 May 2016 11:39:13 -0400 (EDT)
In-Reply-To: <D97D1033-70B9-46D5-A672-042DE0283CCA@fournova.com> (Alexander
	Rinass's message of "Thu, 12 May 2016 13:16:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADEC8222-1857-11E6-A242-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294408>

Alexander Rinass <alex@fournova.com> writes:

> I will create a v2 patch until the weekend and send it to the mailing list.

Thanks.
