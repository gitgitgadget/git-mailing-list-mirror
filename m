From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] log -L overlapping ranges
Date: Fri, 05 Apr 2013 10:39:45 -0700
Message-ID: <7vzjxcc1we.fsf@alter.siamese.dyndns.org>
References: <cover.1365172322.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWM2-0002u6-UG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162217Ab3DERjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 13:39:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162184Ab3DERjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 13:39:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 066B6135C4;
	Fri,  5 Apr 2013 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dpB1r3pH+hiBPmi5LqdmaNQDwVc=; b=DWgFCX
	uNF9S/62xTpVg8jPK2uR2HP5DdlMGIVNHdu2SaqYyEhYNSKVXzOSBvMCjtGkqNN9
	fcywidEzUfSgZdVVVyxB2f3VAt442bgHhVi2EYc9faOnRX5YiZQ7gSZBQ6LwIZ3p
	E6mEMLGonLcI99KJuy3+EKTRp7bNKIVhZOnkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xseRk8y3v8uZ1m5bv3PMmOiqzK7cR/4D
	vR7kpXPq5lYwgv0FW5G3SipbOXU9bDjRR4PmgvhPuLxTwpCw58w0/AEC68fl31iD
	ZtmOzaixTo+jL1FkWQ9rKv2Y9u+6XIirA/rmSmW89wQ/wQ3ZRm74Q/6SBots34qM
	2Zuk6pwpfXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F3E135C3;
	Fri,  5 Apr 2013 17:39:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7190C135C2; Fri,  5 Apr
 2013 17:39:46 +0000 (UTC)
In-Reply-To: <cover.1365172322.git.trast@inf.ethz.ch> (Thomas Rast's message
 of "Fri, 5 Apr 2013 16:34:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEC156A2-9E17-11E2-AD32-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220185>

Thomas Rast <trast@inf.ethz.ch> writes:

> I noticed that it doesn't like getting multiple overlapping ranges
> from the user.  This fixes it.

Both look sensible.  Will queue on top of tr/line-log.

Thanks.
