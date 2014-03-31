From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] Documentation: Fix misuses of "nor"
Date: Mon, 31 Mar 2014 16:19:12 -0700
Message-ID: <xmqqtxae0xe7.fsf@gitster.dls.corp.google.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 01:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUlU9-0000Zh-2h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 01:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaCaXTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 19:19:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaCaXTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 19:19:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C462C795DC;
	Mon, 31 Mar 2014 19:19:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EkwD/4/jMgPJlXAyokfEzEJ9lSE=; b=Mjf+DV
	gt57K02/ur3Ze4T4PI4fAH2wDKRS7cY69coAPALukU+9WhuBwbDPpe2W0cA3756R
	sqKCkvNlf8c5Yd3n8e52psiXUeEsq/V6uiXYbvEMuelkWXzp1qBq8MAoCJopuWyq
	mI5U/o1XtdYWSndOa7bmr/gSNrIltfbTVSWlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uajFd/W1Yz3OYNccFUjmO2noPaoFNZlO
	aK3RM1XAYYFfvJsjwAcMQ21eQsahA8cWW9M8xj/qPmFw05oxrJfdnllZRNxI7ntj
	u81u5ke94qyJuUhAkJ+8dGRX1Fs+HIi+BZ31eXzA5nyVTQZ83zV83zaMEWbcIyxu
	C7z9bKykR98=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC23795DA;
	Mon, 31 Mar 2014 19:19:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3F3F795D9;
	Mon, 31 Mar 2014 19:19:13 -0400 (EDT)
In-Reply-To: <1396303907-23291-1-git-send-email-jlebar@google.com> (Justin
	Lebar's message of "Mon, 31 Mar 2014 15:11:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF76D470-B92A-11E3-83F5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245567>

Four patches queued on 'pu' as-is (but retitled).  I didn't read
everything very carefully, though.

Thanks.
