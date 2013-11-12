From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/11] transport-helper: updates
Date: Tue, 12 Nov 2013 14:24:51 -0800
Message-ID: <xmqqtxfhfebw.fsf@gitster.dls.corp.google.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 23:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgMOJ-0002Iq-C4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 23:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab3KLWY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 17:24:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870Ab3KLWYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 17:24:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 335B0521AD;
	Tue, 12 Nov 2013 17:24:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c9z5Ek/kZK0cEfseTkx8Wc8hrhk=; b=YGv8JP
	CZwUef7kVQtRqXKRggsoH48Lw2Qwr9naCXTQvCA6zq7nXUE1Qwi6W0swyFN7MqWz
	yuP+dh/gh6nmhfirwxapyDVkcWUhn0Pc2AWqyi6ON31O1JOZ4PCVVWfvH8PXYT+V
	9iufk4GKqxGn0LL5IZ+4UGF6OGupLbM/f7hVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uTNUJGaVJddzOgh9q4Ukwst77gbtmCgE
	1WIFRiAgUT3PV7AQcIRQwNSXKEtA/CfszIZWZayTeFrIXACfMyHSoXDK2WnTqcco
	1NVWtpKACyFQv3mGSbKniM+FI4gjugMlKMy//qyBLRdnmfK+jq3/ky5FHIgUEykh
	B/12gYuU4rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21420521AC;
	Tue, 12 Nov 2013 17:24:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77EA3521AB;
	Tue, 12 Nov 2013 17:24:53 -0500 (EST)
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 12 Nov 2013 14:56:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40A0BF0E-4BE9-11E3-AD8D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237763>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here are the patches that allow transport helpers to be completely transparent;

Thanks, will replace what is on 'pu'.

> Felipe Contreras (10):
>   transport-helper: fix extra lines

I'll retitle this one to "mismerge fix" to make it clear where the
blame lies ;-)
