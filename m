From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v2] git-remote-mediawiki: fixes, optimizations, and
 progress report
Date: Mon, 16 Jul 2012 12:56:04 -0700
Message-ID: <7v1ukb1nvv.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrOz-00083k-0l
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab2GPT4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:56:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab2GPT4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:56:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 264D0842B;
	Mon, 16 Jul 2012 15:56:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuCdN3R1d0NT1d/yQow+jCmg1TM=; b=ipVZP8
	lcQfeH+trdCxTRFEIzas4zZ9iw3wygnZpbkKdzgow2rCSL62q1EbGHJ0Lk2+GIFB
	6HrFCA7AV335xzNGIQVFeWjBKosDmyFgCNjNv0dtVE5fFyIRPUS+cpRmIa0s141Q
	d7k0G8VLPTbpuanQRfkamex5XfASANe4lhuWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H6WISud/4ai6uNGAEgSFlsXWYMW/Y1nK
	gJrZ75n8Vlj63qiVko6zybeyVxPlJAwmF4tynxhaVWsE4DiKbsA5Q1kHy134cS7o
	7O+N024KVMZc7lgbuh9lQHugQFb3vN5+JHXPZvO44RV1xVILsX0lOERPm0+Q2UN3
	hwePBjkaFy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 129BB842A;
	Mon, 16 Jul 2012 15:56:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 869BE8427; Mon, 16 Jul 2012
 15:56:05 -0400 (EDT)
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 16 Jul 2012 21:46:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 473A4D12-CF80-11E1-9E83-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201564>

Thanks; will replace and requeue.
