From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-hash.c: always initialize dir_next pointer
Date: Tue, 01 Nov 2011 15:31:34 -0700
Message-ID: <7vbosvlbjt.fsf@alter.siamese.dyndns.org>
References: <4EB070D2.4040709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLMru-0007ls-A7
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab1KAWbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 18:31:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab1KAWbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 18:31:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B516406;
	Tue,  1 Nov 2011 18:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=jxwIcP
	rMSFAqSMhP5XNStDyPA1gENgYR5f0UFznoDo3hUdXCtTvOHy9Cf7mqqBVthMr7Q2
	8/PPWbnBzYLVGwZnm+kO0KjjRtfy/1hC8gCXBBlIH3OCxa5z/Vz30u4otFawQ5wF
	rskI+DX5u++eYokHRF2Xnv8icsz6RGQNlOVTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W6DInaCwJGLXxMZH434/RvVujLZ+zco6
	VnCyukJF5qjWF7foBq2xNXrONzmKosGargNhptoxT6WdbSTxXaVSeJY4ApBKEZNU
	hPmPJBQhP0u27/xVdmpGzUt0IG+BGIPWtOOvOLsW4a0Ie3wmgJADKTyFEstNH8Zz
	z1aNEUtFccY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C6EE6405;
	Tue,  1 Nov 2011 18:31:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05C0E6401; Tue,  1 Nov 2011
 18:31:35 -0400 (EDT)
In-Reply-To: <4EB070D2.4040709@kdbg.org> (Johannes Sixt's message of "Tue, 01
 Nov 2011 23:21:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 420C47B8-04D9-11E1-8240-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184600>

Thanks.
