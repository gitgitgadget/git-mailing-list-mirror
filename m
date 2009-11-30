From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git merge" merges too much!
Date: Mon, 30 Nov 2009 12:50:21 -0800
Message-ID: <7vy6lnivoy.fsf@alter.siamese.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com>
 <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDCc-0007sT-SY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbZK3UuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZK3UuW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:50:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZK3UuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 15:50:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 339AE84157;
	Mon, 30 Nov 2009 15:50:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bzhw/F1CaQuw/SFkqQmHwh73sio=; b=tTeVVu
	TfAK26xCgmFCVuWKEE9DUiKcwWDtN+LsnZzFwukORzDBRZ3D9qncgxY4pU1E2L+o
	CqBZcEGntdsX5i77Eb8fQ4xb/ZevSHT/JDb5xy0GGi3m8C8azKhMy5Hu4S7+Z3gT
	BWmikkoMoBQzsMuz4oBt6RAypj2h+HgSDLCc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7AkuDu0lEK32JqvIFHe0cZ/iPRG6RlG
	D63/HwBY4bO9mX2rpmQt/0B3zpTAt/xn3EI7juQm8WMVJjsQ3PASqNAqcttR1y14
	bdWch7AI0KGvKwKOlY7fAjz0sesrzMO4KpiGKRzzdOsOOXeCoWlyiK0FycnwuBRH
	TPhLcscNezQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2122184155;
	Mon, 30 Nov 2009 15:50:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D115084150; Mon, 30 Nov
 2009 15:50:22 -0500 (EST)
In-Reply-To: <m1NFBAx-000kmgC@most.weird.com> (Greg A. Woods's message of
 "Mon\, 30 Nov 2009 13\:40\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC834300-DDF1-11DE-92A0-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134138>

"Greg A. Woods" <woods@planix.com> writes:

> ....  This isn't really a Git problem I suppose, except
> for the fact that it means the lack of easy support for multiple working
> directories that track different branches makes this kind of development
> somewhat more difficult to do with Git than with, say, CVS.

You want to google for git-new-workdir then; it is found in
contrib/workdir and fairly widely used.
