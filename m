From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] rebase -i: For pure fixups, do not start log
 message editor
Date: Thu, 14 Jan 2010 01:17:14 -0800
Message-ID: <7v6375hwpx.fsf@alter.siamese.dyndns.org>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLpd-00030R-Jz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 10:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621Ab0ANJR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 04:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756611Ab0ANJR2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 04:17:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab0ANJR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 04:17:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4FE90E67;
	Thu, 14 Jan 2010 04:17:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gOzYGKMBHg1xJeu4I7qjbgyaIWY=; b=GCwLKG
	5IkJiK3yy4LPAH6y/D4TByStN/owUu56payhc3HA+N2DtjAiVprWXN0+m4s5Pmrp
	qrT1Gp1udfhUyu+M/Fk9N7yXb5a5J0aqxFApBeYIAUSpBVv1GxQiz2n526wKfuTX
	LIxTMIHiE05uBWPO07oDq83G9/E38SqwbJaJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CaolMHUAdfKsfxtT2UqVT842XxQ6ZbR9
	XtYTyb0KST6noh/dHV6LgsgLRzPY/qCSVbTRhRDi1uuuw/53ieRHz0r/mJf4Pt5Z
	N3PHOr/zeMJDqDXOfdWTw6GCchBl/G7F0FwdF7nPQCBlo3/oZ+XcWCF/1SMcJZkw
	Mpz8BhWZFqk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72BED90E63;
	Thu, 14 Jan 2010 04:17:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B07B590E61; Thu, 14 Jan
 2010 04:17:15 -0500 (EST)
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu> (Michael Haggerty's
 message of "Thu\, 14 Jan 2010 06\:54\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D84F8B6-00ED-11DF-8868-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136977>

Very nicely done and the series was a pleasure to read, even though I
didn't read some of them very deeply and might have missed some subtle
details outside the context of the patch.

Thanks.
