From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/27] refs: Remove API function update_refs()
Date: Tue, 01 Apr 2014 12:46:45 -0700
Message-ID: <xmqqlhvozvbu.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-22-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:46:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4e4-0001k8-TU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaDATqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:46:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbaDATqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:46:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E25979C10;
	Tue,  1 Apr 2014 15:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KdP0/FHEBnIYn7/PZAPLLOgvYtc=; b=k31Gti
	Z7SK4haAs8foyX3HSlDlFl1WuFskdBC9JNadeoAi45+nyvkskoxPErCwWpBCr6Wi
	c+K5ZOOHrV99NX/655OqOqHzUyZZz52tZb3z5njVQ0090SWCyeQ4axeWTEovATZx
	AVoaiVq9cIt+4pt1jGwN5Li/ow7YI3a40Chv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wrHn5vGa0laP8GdhgiCyF2MltYucvJy/
	VGi9sFC/5bc+stInxKc0dhBd2rWa15wEoauWfv7csB4cAUEMeLH3rYxkFmJ1sQIA
	anlyCq7Dfv2rmM5SKaRZrU6trIrXWhpw2jnv/2eZYZ3q9OnpPp/Mv8TnGNZZld1U
	MX8O+iGbBGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3A679C0F;
	Tue,  1 Apr 2014 15:46:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 806B879C0C;
	Tue,  1 Apr 2014 15:46:46 -0400 (EDT)
In-Reply-To: <1395683820-17304-22-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BD47256-B9D6-11E3-AB86-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245641>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It has been superseded by reference transactions.  This also means
> that struct ref_update can become private.

Good.
