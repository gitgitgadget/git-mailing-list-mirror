From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-cherry-pick: add keep-empty option
Date: Fri, 30 Mar 2012 13:34:23 -0700
Message-ID: <7vlimhltf4.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiWk-0007gg-QP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761374Ab2C3Ue1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964Ab2C3Ue0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 798A93F00;
	Fri, 30 Mar 2012 16:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t3iE3xvlYaFgtGvqJvon5L6xH34=; b=oxamYv
	ihrtg5tH+q/Ysq5ni9l7JYpw2PajKH8n+fBqv6hah06WK7bEGKE2ewHUEu5BaKW6
	Tbab6goHaOSVNkhJC1iPEyUhpTd+2mH5Z717gXEatGfkSLntWX3GCu+IoHuBqfzR
	P4TlHhQYp84C2jD/FQrfbEGndty3sx4LZ2VRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wYQC2u+Eu3BGdsIvpJTyWq/pkTtafDQd
	oEq5qV4DqlD/cIpz3AxJaJZyeku9HAuNLi01+QrKuCRAz28HjkGUMn2G0icHJIZz
	NygvfhxWo7tAMGD5HRMTcWiKoljiX7Zgw/PEr1pykyU6eKF3qc3v6pXu1ClMF0GZ
	HP5gZEcX7Js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 712453EFF;
	Fri, 30 Mar 2012 16:34:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8F223EFE; Fri, 30 Mar 2012
 16:34:24 -0400 (EDT)
In-Reply-To: <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Fri, 30 Mar 2012 15:48:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD2AACF2-7AA7-11E1-9ADD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194402>

It strikes me very strange why this is not called --allow-empty, but other
than that the addition look straightforward enough to me.  You would want
to add a test for this, though.
