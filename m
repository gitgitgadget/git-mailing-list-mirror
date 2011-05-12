From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Wed, 11 May 2011 17:54:20 -0700
Message-ID: <7v7h9weo1v.fsf@alter.siamese.dyndns.org>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <7vfwoker7i.fsf@alter.siamese.dyndns.org>
 <7vboz8epbp.fsf@alter.siamese.dyndns.org>
 <30791C70-81D4-44D7-B2E7-814D001F3E12@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: David Pisoni <dpisoni@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:54:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKKAi-0000fe-RH
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 02:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1ELAy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 20:54:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1ELAy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 20:54:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E8FB5173;
	Wed, 11 May 2011 20:56:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sCo/u9Iv2BjVkf0EcLPGpPtUJK4=; b=O5p2bS
	gHKiRVqgdAVSsLvduUqKlnFe6Bn090mskuqJptr+QEEe3IBc3IhPeccuKwYGaAJz
	yPnF8UQHXLHEggRahVfpwUdDZXUA6l6CrQfnbQ4cDSMDFKJWTekO6j2ux49OK0Ya
	eGoILcNGnqiEjrKsl6Re8GVUJOk3UH933oI3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mqs+V1xiVTUQtiz9wZaG9RlOfgxXelW/
	pYgW0K8eFQjHGlaSx2t8NedLEe+m2KswiIQtZvn8E0HxPxB+AlvwWj/Y+9Jru6Vp
	BVpGgJxLCbXqLatiKcFi+Q+ferFDUu/wpVxmw7LJkFynstH4gXSOPQIz9+IDQr7x
	8VAbgVfzhvU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B3DB5172;
	Wed, 11 May 2011 20:56:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 432E25171; Wed, 11 May 2011
 20:56:27 -0400 (EDT)
In-Reply-To: <30791C70-81D4-44D7-B2E7-814D001F3E12@gmail.com> (David Pisoni's
 message of "Wed, 11 May 2011 17:48:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC30EBA6-7C32-11E0-9312-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173437>

David Pisoni <dpisoni@gmail.com> writes:

> I agree.  I like your change, also.
> Does this feature make sense to you overall?

I am very much in favor of --no-index in the sense that I would prefer to
have it in the system than not having it.

I am neutral to the configuration variable in the sense that I wouldn't
miss it if we don't have it and I wouldn't spend too much of my own
brain-cycle to add such a variable, but I wouldn't be disturbed too much
by it if we had it in the system.
