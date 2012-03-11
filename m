From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/(3/4)] test: does pre-commit-hook learn authorship?
Date: Sun, 11 Mar 2012 14:09:34 -0700
Message-ID: <7vehsyx2sx.fsf@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
 <7v1uozz97f.fsf_-_@alter.siamese.dyndns.org> <4F5D0B50.20803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6q1O-0007Eg-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 22:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2CKVJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 17:09:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab2CKVJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 17:09:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 460507A72;
	Sun, 11 Mar 2012 17:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ri3ioOGkU7/A3nFAmcE3nhTaf3g=; b=ilHNhQ
	8plH7yvjo8t3lmOxt9CGhxKdfJC+UPXrJwKGYBI6nqE6j9HjWo+brMj0hBSH/NEU
	ZqRFwm9QAzfQGrvmBufeW6sNWzdWzh0CtjOhSu2XcdOb/sSapnqm2hVf0r7uFwrq
	YqGa/zMTmRxgP+8W/x2jJRI5rd1l8820j7Jcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HCQ6iY5SViTKp8cHeqhHzw/958phfwFN
	y5HpHJ80yaCCw+pMyJmFNBxoT3hxBXfDO/LyPPIwH/TLpELLPCLKa8cIyKkwf9IA
	/se8FLcnebVeH7BoVH71M1WqSSyK4MaIzrAftu82+FDXjwpoC1mJYJFxM0Nk5Itf
	t7gxeJ7l4fY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB5E7A71;
	Sun, 11 Mar 2012 17:09:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9A107A70; Sun, 11 Mar 2012
 17:09:35 -0400 (EDT)
In-Reply-To: <4F5D0B50.20803@kdbg.org> (Johannes Sixt's message of "Sun, 11
 Mar 2012 21:30:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 817F13C0-6BBE-11E1-973D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192829>

Thanks; I should have just used write_script() for this.
