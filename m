From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 02 May 2013 08:38:33 -0700
Message-ID: <7v4nel2xza.fsf@alter.siamese.dyndns.org>
References: <20130501203449.GA12535@sigill.intra.peff.net>
	<51820B37.8010503@viscovery.net>
	<20130502064630.GA15208@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 17:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXvaj-0003O8-MC
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3EBPih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:38:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201Ab3EBPig (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:38:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 811E8198E0;
	Thu,  2 May 2013 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+B8bvbFTtYQ/3GzxAqrVg9SnTCQ=; b=Y6cU0T
	PhDjX42tKGMK7Nn4BV32dlkUORjjWk/KJ0zfUMoAFuAMy9r7poQCiLdwCgaDnA3h
	0NWY5Hc/Nkjzjc6wcDytFETgoAZKU5KQganAFZIQN0ym36YFGnFmK8QASQXmCMi0
	VRlJQhFaY9+YOJsiLI4ax0PiIp7VckQhWSd7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mga6LK1Olfbb1DxvelzMYfdHOlfI4W4x
	Om5NTFnbmMN125B7T7C8F2/2tEOfJA/woC8zBhsoR3iZ2qz4SNL2PSakM6iJkw1h
	dy6e8Ac89QveG8iofz8sdHZoWeuYdWmZUZbbHlZke0734WjlN3VxbClxV+D5SZg7
	c7u8TzDdI+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F45198DF;
	Thu,  2 May 2013 15:38:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDA33198DA;
	Thu,  2 May 2013 15:38:34 +0000 (UTC)
In-Reply-To: <20130502064630.GA15208@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 May 2013 02:46:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59C2F81A-B33E-11E2-A943-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223213>

Jeff King <peff@peff.net> writes:

> I figured the lengthy description in the commit message would be
> sufficient, but I don't mind adding something like your suggestion to
> point readers of the code in the right direction when they see it.

Yeah, I'll squash J6t's comment in and requeue.

If somebody is learning the internals by reading code, having a
comment there would certainly help.
