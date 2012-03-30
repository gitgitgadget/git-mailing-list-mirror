From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/3] gitweb: refactor If-Modified-Since handling
Date: Fri, 30 Mar 2012 09:11:55 -0700
Message-ID: <7vzkaym5kk.fsf@alter.siamese.dyndns.org>
References: <201203282328.08876.jnareb@gmail.com>
 <cover.1333024238.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeRD-0000nf-4T
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934305Ab2C3QMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:12:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934278Ab2C3QL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:11:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 585495210;
	Fri, 30 Mar 2012 12:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tpEZ7UzVp5B3SgNVSvkd7k8TKw=; b=RwUamc
	IapgQUJmxophbH8PLfSx+n4/OgsiBev5G6FDPApWR9F4WxI7+fIyHA2tJx7x3qy7
	d+pgzGrRDl5vzHMuQaxHV1DD9Cz8rETMeAnO7TtgQj8V8sC71eNW6mHs1YPger3V
	XwCyRnJT5tHSCcJ/dkwamjNv9ZdFGep4t+3AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RlOTPOkbA6Td6wrCLLt9BACb4zw73fiH
	RRNZD0HMr23NxDOm4YA/HnFcdeHckTC+H91ISPhunbdBUD2nDetqSv01OXzPMRei
	o9KQkmgCYEFNraRiz96zn9JwXsFc69tMiY51CoXPpeWszkJi3k4ok3N3BnjVuaH2
	yy86Ngz+vic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8BD520F;
	Fri, 30 Mar 2012 12:11:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAAF7520E; Fri, 30 Mar 2012
 12:11:56 -0400 (EDT)
In-Reply-To: <cover.1333024238.git.wking@drexel.edu> (W. Trevor King's
 message of "Thu, 29 Mar 2012 08:45:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1297BFBA-7A83-11E1-91F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194371>

Thanks, both.  Looking good.  Will queue.
