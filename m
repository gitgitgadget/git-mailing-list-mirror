From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v5] git-tag: introduce --cleanup option
Date: Fri, 09 Dec 2011 10:04:41 -0800
Message-ID: <7viplpebnm.fsf@alter.siamese.dyndns.org>
References: <1323226905-31418-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6zt-0001GN-Hc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab1LIUYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1LIUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6C0665C;
	Fri,  9 Dec 2011 15:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=uxOGgOvLOdqJp604SLHfzarNOmk=; b=l2jn0AEg3D+A8+kMfdO4
	kj1wesDy5IR7+liWqMaDczkRY4lekwdNdy3PDW5lq6CR/CT12o5RykSztN+IPPtx
	E5YKCB+4JQI9nrBmXNHRpeNWYs2/u++dZNvmA6qvP4erz05ftlHSRyIDKRtBFHdA
	7qG1SYSwmntmuIE7Ihmwh6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uj5VDlTSJQC8LNXcLTcBkGJJGliRqSJJdGOu0WQQjVLFlR
	Aka0L+85HdMiYSXB+uDKDL01aj01Q/ISs9aOlncIFSbz0wOjqsZclHunNPJx6OG2
	I7w3IYXeA/8wV7cUaYZdbwmSF9ES9CobvGrFp34pJqpV1DPmX0m8g3q8xtfIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A29D5665B;
	Fri,  9 Dec 2011 15:24:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2867E665A; Fri,  9 Dec 2011
 15:24:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCF9E5BE-22A3-11E1-89DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186684>

Looks sane; thanks, will queue.
