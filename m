From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3][GSOC] fsck: use bitwise-or assignment operator to set flag
Date: Thu, 20 Mar 2014 11:45:07 -0700
Message-ID: <xmqqlhw4yaj0.fsf@gitster.dls.corp.google.com>
References: <1395270124-2242-1-git-send-email-sh19910711@gmail.com>
	<xmqqtxasybnk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 19:45:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQhxv-0006Cs-QX
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 19:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759594AbaCTSpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 14:45:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758156AbaCTSpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 14:45:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE2674C85;
	Thu, 20 Mar 2014 14:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EbYLOgiJb7TEieWUBtY+wCXmmzk=; b=ko9hAW
	2cM4tsUUMNoHbUyFBqvFOgV3MjotV9inQNPvnAZfg0uQTLm3PPKgUD1FZA4tsuoG
	O4hM3+ZYcrW7icI3Ype+EZnUB+jr1Wtfx6FHJFiBLeDbTdEvXMYEHp8Hb2nt8gTn
	4iFRWZbWDMdUCy7OHgwMWuU7fdy7JI2FbqBbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bu98YWU8bgC/AUQHeKl40GRFxT9ZNQ6E
	RbTI6PqeZfI2XBxVGNLiQuYyByYw3QrVH/FRxYcSbThbhgGJMzHhnbtUco4m+AYh
	mNHbydUJ/VmA/Rn0hZqGGZc4qT/88U0S4+2GnB1eppd74sJPuGWkXKsZkzrQKUyZ
	Yd3YiHfytZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DDB274C82;
	Thu, 20 Mar 2014 14:45:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5892D74C81;
	Thu, 20 Mar 2014 14:45:10 -0400 (EDT)
In-Reply-To: <xmqqtxasybnk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Mar 2014 11:20:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3BF48C6-B05F-11E3-B779-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244570>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, "it is brief and to the point" merely _allows_ these
> statements to be expressed in the latter form; it does not say
> anything about which is better between the former and the latter.

In any case, that is a minor point.  I'll queue the patch on 'pu',
with a tweaked log message.

Thanks.
