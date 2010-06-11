From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Ask for in-reply message ID even if from and
 to is already known
Date: Fri, 11 Jun 2010 12:06:53 -0700
Message-ID: <7vtyp9ie2a.fsf@alter.siamese.dyndns.org>
References: <vpqtypmn4bm.fsf@bauges.imag.fr>
 <1275415730-15360-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
 <201006101908.19578.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
X-From: git-owner@vger.kernel.org Fri Jun 11 21:07:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON9ZX-00020b-4R
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab0FKTHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 15:07:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab0FKTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 15:07:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 610B4BBAA1;
	Fri, 11 Jun 2010 15:06:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYjK6xv9nNXu8WucCXfEkA/Zkjc=; b=NNkpUJ
	0eMEZgCOdgrf6fUFcu8wytvX4+rv6o1tzECV3U9zU81zew2VDxVY7JfWMwacSMQK
	IM4Mh+5EBqB3Rwne8/rsDpdhuaA85xxuSp/jWTJrCy3pq9y6NYF+YwQdHBVCD9oR
	/lpTeHxJozHOAw8HKuW+vViHlgqe8CkAj54ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVONiwg3Q9WwoBT/Apt7LmpHIxZa85LW
	rfFNlb5jpsgdUHT+K0Wr8j38PZh03PjJedeHp/kjswVUA6FLZGcbCO74zV80nbQz
	MWnMqPP6ujv/RzZVUQjEJvaemxzoikdzpMqg7LUT+lM/Ses0pwUOwlVoXbnlcA9+
	UtqabuanrCU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3968DBBA9F;
	Fri, 11 Jun 2010 15:06:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98AF7BBA9C; Fri, 11 Jun
 2010 15:06:54 -0400 (EDT)
In-Reply-To: <201006101908.19578.alexander.stein@informatik.tu-chemnitz.de>
 (Alexander Stein's message of "Thu\, 10 Jun 2010 19\:08\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81725358-758C-11DF-8AE2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148965>

Alexander Stein <alexander.stein@informatik.tu-chemnitz.de> writes:

> Did get this patch overlooked?

Did you run the existing test suite unattended and make sure everything
still passes?
