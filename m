From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sun, 31 Jan 2010 11:18:14 -0800
Message-ID: <7vsk9mdqx5.fsf@alter.siamese.dyndns.org>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
 <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
 <20100130194746.GN29188@inocybe.localdomain>
 <7vd40rjks4.fsf@alter.siamese.dyndns.org>
 <20100131041236.GP29188@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:18:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfJd-0007oS-Hx
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0AaTS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 14:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091Ab0AaTS0
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:18:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0AaTS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 14:18:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD32A952F8;
	Sun, 31 Jan 2010 14:18:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PTQDCz7iM+q5PuR+RnB996xP/oo=; b=Nz79Si
	zSvRtp61TFcbtBw9C7QNjq9mbm2+1ns1PpK5tIvDpc5UDqlUR3HDLVjn1fqpTM4I
	V6kLx7p9WnDNw0rqWvTQmlg86wTGsTy2fPrdymhqNwNv0g2h7ipiSXL+dJPFQxbB
	Qzwsm/2GRvn/aaFgZApnhJW2IVpG/81SxvwPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSFCYtAG7hvO/uCzI6W3/zmlrruf0kTn
	7bIURaZ26sGckKMB18hKkUPlTkKKbh/XdoUIZVHbjiaMYcqfTdjNrpoHMSYwbosu
	4XgyMK975cxz1WNJA8m0JxOMLRAZmlo7Rr/MCG2nCnufqMlrGWI79rO4aN6akjTw
	pNffIqkf/O4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A435952F7;
	Sun, 31 Jan 2010 14:18:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB7AE952EE; Sun, 31 Jan
 2010 14:18:15 -0500 (EST)
In-Reply-To: <20100131041236.GP29188@inocybe.localdomain> (Todd Zullinger's
 message of "Sat\, 30 Jan 2010 23\:12\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64AB9050-0E9D-11DF-ACA7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138549>

Todd Zullinger <tmz@pobox.com> writes:

> It is probably better to use %global rather than %define here.

Thanks; will fix.
