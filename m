From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 12:49:40 -0800
Message-ID: <xmqq8utq8uxn.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<87lhxqwse8.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 21:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmwL-00081S-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbaBDUtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:49:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbaBDUtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:49:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17EA9692E4;
	Tue,  4 Feb 2014 15:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YBHgCgb6Uc36cCMRUCc0x95cuwA=; b=ImaAQr
	X/Y408LmUWB1yr0QuYa/7TsQLnUEhnZoWWoje0EP2/d5gHLBR4urTr/k1sD1ln0B
	nsvZuqodbttSBct6hje7uuFC+xuEBbifftrOxwnopiXruP4j/WupD/488k7fuj05
	ml2+OYXn+QsiwhRcivkgAfDS5MVGRUb6Nif4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AgUU4uobQG6LnHw6cD8G2LEbVPlkIObw
	MdN97R/sZnNpl5Kw18MUIRoI6LwZz1whvg6pXKhY/6+HBVD2547HYv0a7Yv7WdrC
	y9Xsn3XFla0EwXIHvkQxTd9sIT/2k9iJZMapBHW4QP0FFczk17nR6+SyqoCZefy6
	j+rVpCqEO2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A296B692E0;
	Tue,  4 Feb 2014 15:49:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DF97692CD;
	Tue,  4 Feb 2014 15:49:43 -0500 (EST)
In-Reply-To: <87lhxqwse8.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Feb 2014 21:10:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFFF1934-8DDD-11E3-B4B0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241550>

David Kastrup <dak@gnu.org> writes:

> Whitespace error in line 1778.  Should I be reposting?

Heh, let me try to clean it up first and then repost for your
review.

Thanks.
