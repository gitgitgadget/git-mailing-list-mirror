From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] smart-http: Really never use Expect: 100-continue
Date: Mon, 14 Mar 2011 12:34:24 -0700
Message-ID: <7vtyf5cx8f.fsf@alter.siamese.dyndns.org>
References: <1300127297-8025-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDXK-0007vB-Fa
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab1CNTee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:34:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1CNTed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:34:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D650443B;
	Mon, 14 Mar 2011 15:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=x4c7Hx
	cDEZNCpzRaGNRP671nc9fP5vppZeACnyQn4Oco+Iizo1UI+K489B2ftqCZSKlpAH
	pypJesSvO9fX9qFVlY2fDEtrqgSOKHhuQXeuDaBf6GSAXRa1D5oQivHd/iKQErIh
	b0TAMPKpqQN5iB2EMsB5rClIUf+ptKeOkd/Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rr1r0wBzdVDHx55nHzS87qcIGzKE8tkk
	dMEQaAluP6Zu2W8m/61ojm9eVZbjFaFW/j+YXFbFEf9U4hIKNF5ssLl8NKWtOqUO
	jNp9NhjBjZf1uJBFTfiaADqpioEug5OrEl0xMhU/yaJ0p1wg1AKPYAAVvbgIMynP
	36uNQiY7aJU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 619C24439;
	Mon, 14 Mar 2011 15:35:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 894C54437; Mon, 14 Mar 2011
 15:35:56 -0400 (EDT)
In-Reply-To: <1300127297-8025-1-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Mon, 14 Mar 2011 11:28:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49D619CE-4E72-11E0-942C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169016>

Thanks; will queue.
