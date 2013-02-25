From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATH/RFC] Revert "compat: add strtok_r()"
Date: Sun, 24 Feb 2013 22:55:08 -0800
Message-ID: <7v7glw288j.fsf@alter.siamese.dyndns.org>
References: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
 <20130201204927.GG12368@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9ryN-0003xr-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3BYGzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:55:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283Ab3BYGzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:55:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8AE49A17;
	Mon, 25 Feb 2013 01:55:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=XWrD2P/Lz/OQI4aEgV/2mo0YNNA=; b=q0DNKc+JZDOyZEmhTkSZ
	cGADwASXx47hnGQMqaJRudOI8OUT9U853ijKtZJCgc+C9fvUNXToTrJ8viaIW67T
	5GxMyci11bZ91CQvFRRKQRUiYW2b9EE59TVCJsBTYTU4PMWpvDMOcjjziGnSMBxW
	Iy+aXHsb+h3U5QfveR1a6QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=E9aD2r8eZWqYl+H7qI1sJ1P6OA/V9ZoqxKsPb7u5ePFqLS
	EQz0Ntsk8VDhU3cLLSI5Cdrg/oo6M+CXnVDqY3a0+jUbuYP/Le1ZGDmUCodmliYm
	GROdiF2aX4oQEj/J8SF7qw4NXJqSZfdWCiXGPlwvhn465qB00rMfXd+HKxy8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B3F9A16;
	Mon, 25 Feb 2013 01:55:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B62B9A06; Mon, 25 Feb 2013
 01:55:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BDF3F60-7F18-11E2-A571-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217043>

Care to tie the loose end on this one, with a sign-off?
