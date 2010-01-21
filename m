From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Thu, 21 Jan 2010 09:58:33 -0800
Message-ID: <7vmy07s5km.fsf@alter.siamese.dyndns.org>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <4B584DDD.7060701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1J1-0001MG-0Y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab0AUR6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951Ab0AUR6v
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:58:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab0AUR6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:58:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4068693F93;
	Thu, 21 Jan 2010 12:58:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PkaXiKNCBo6wCDm/d9GccimW2L4=; b=YxeRuN
	/jOUSHLxCtyynOW0eezv07Ajr5GvwLiSy8VdxOJtuIrkV3y2hbYgKTrCqtEouqsL
	YWcSFm6lQRXvvZxEskH5s4PZ68azAjTc12ZbXDsYmFJFYtwtAFhvcMjmwthuDeU6
	AfXDSkRPA6wBqz9/P2ZlZFAooNhHypPQWYZY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eOqAZbZidAmCvIL15xyQkDa+H9ILJXlN
	4n9bxnR0PZfjMfnf9K3IlWi8xOgEvnxMrGhsSmNNAJ2h8fijn0YRfu1TFNMLN8nJ
	XOgaOQLnu2a3Ez98ksu+cLyMVaZh+RtW0oFbDDQmb/RNamx6AU8aj7avNs6l2I5Z
	wYxturvLUeE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1092A93F92;
	Thu, 21 Jan 2010 12:58:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53C2793F89; Thu, 21 Jan
 2010 12:58:40 -0500 (EST)
In-Reply-To: <4B584DDD.7060701@viscovery.net> (Johannes Sixt's message of
 "Thu\, 21 Jan 2010 13\:51\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D7BA06C-06B6-11DF-88D2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137679>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Works for me, thank you very much!
>
> Junio, kindly squash in these speeling fixes in both patches:
>
> sed -i 's/impiled/implied/g' `git diff HEAD^ --name-only Documentation/`

Thanks; I've already pushed out what I was preparing before going to bed,
so these fixes need to happen in-tree as incremental changes.
