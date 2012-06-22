From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git credential fill: output the whole 'struct
 credential'
Date: Fri, 22 Jun 2012 13:26:27 -0700
Message-ID: <7vvcijnle4.fsf@alter.siamese.dyndns.org>
References: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340381231-9522-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Javier.Roucher-Iglesias@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAR8-0007bH-5p
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab2FVU0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 16:26:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807Ab2FVU03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 16:26:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 821D37C4E;
	Fri, 22 Jun 2012 16:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WIMVOjJs4IhYVLnLEZD1lSR4bjc=; b=FrRnoy
	Ycc0YkMGCKK9ysENKFZ7v4x/VDTiaPeEyXvWvW3Kdn3+Tc/IpgrWkM1WOuZQJO7r
	PKc3K96R4YS/mPHtpj1Lbr/OYEtLJLV399yu4o61vFa44z9R88eOFDvOmawOSR2P
	C1Gn+yS6rF/ZlFcGmq27hzpCiohDqvwsZpNIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rtFCh670K2JE5fDuG0Nn2VdTt37pQOiA
	ZSqWZS31VG7UkPGqU+1Hx9PFR1h6SCHHDvRlYT4zkMCBSEdz4cUq9DfEzH5mlfoJ
	QezMhGdl5xv3krh4gz5FC59eu8zBduErlbLcdd/C+qknXWmiWZThn2dMjqOJAUYF
	rjYZN/tOeFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C8C7C4D;
	Fri, 22 Jun 2012 16:26:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECE547C4A; Fri, 22 Jun 2012
 16:26:28 -0400 (EDT)
In-Reply-To: <1340381231-9522-3-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 22 Jun 2012 18:07:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C286872-BCA8-11E1-B975-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200468>

Looks very straightforward and clean.  Thanks.
