From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 08/19] read-cache: add watchman 'WAMA' extension
Date: Thu, 05 May 2016 15:44:29 -0700
Message-ID: <xmqq37pw9lbm.fsf@gitster.mtv.corp.google.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
	<1462484831-13643-9-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS0d-0006mZ-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158AbcEEWof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:44:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758151AbcEEWod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:44:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6981719AB4;
	Thu,  5 May 2016 18:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pPnVr29yyRXKgE0svy5EQ00Qgsg=; b=n9plp9
	x7xxivmXte/MSHl7A8r1ToW4VNw/zuIDC7w4UHdqTB7D50rJYvh5yksefBKuGK08
	GJ+/3PsWUy4NpN7uuUksZ32M9CZGDztr2UAfj7NmWuiUug5gcYOUSBk9ds6uqnn3
	EUdYWMiDC2sFyutRlrLGcmHfHD9q66rHbmMXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B9Um4EXUHcN8vs7737M7sRbHYr9b8S9F
	EOBRFuAxl3VzPaLqTBOb4RnsfAtK9wgB667fmRdLmjRQbBn8X/APic3FBdXAX/gL
	1i1R3kELcDT10qc438kVGwVIm/U7GDdTP/xCKH6t9uSZZF9841HZm7l+D7cAosiK
	IpIFlsK+Txs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6195819AB3;
	Thu,  5 May 2016 18:44:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D14E819AB2;
	Thu,  5 May 2016 18:44:31 -0400 (EDT)
In-Reply-To: <1462484831-13643-9-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 5 May 2016 17:47:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EED64F06-1312-11E6-ACEF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293714>

David Turner <dturner@twopensource.com> writes:

> +void write_watchman_ext(struct strbuf *sb, struct index_state* istate)

void write_watchman_ext(struct strbuf *sb, struct index_state *istate)

Asterisk sticks to the variable, not to the type.
