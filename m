From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] start_command: close cmd->err descriptor when fork/spawn
  fails
Date: Mon, 26 Apr 2010 16:58:24 -0700
Message-ID: <7vtyqxix5r.fsf@alter.siamese.dyndns.org>
References: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
 <4BD53749.6040708@viscovery.net>
 <z2n9f74dc2c1004260447y12b522d8if37cad56548738f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Albert Dvornik <dvornik+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 01:58:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6YCL-0004cc-Il
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 01:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0DZX6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 19:58:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0DZX6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 19:58:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3515AE359;
	Mon, 26 Apr 2010 19:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4LSDaUtmJHwkDP+S8Uk9k+YK9Ac=; b=Q5S7fk
	ggOmEJA1Ekf8TGJTpv9TNJiGXK8X6P+keI3M1s9hiT+4KZyv/DYr/XgukqZl60ko
	L9BM4BgW0LuSGfYE7F7PBJ4oFRwGDJdDuv3fndzYNLuu4ZW0HEWSAgxDDSq+dp9Y
	WoK+zRm0pTWTcRTc4k+cniFHhx2QL5Xno8ldo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phZGyL0kWg+te1VpA429QRP/J5gxK3Pv
	ILwnUCFoxoRAYahK3Z7n+Dxl2nqXxEN/ZxIMfkUUsaj2IcpPq7R/4hVhvI/gLfY0
	iKD/xagtxLPVZlJzobJ9lD7wL59/nrfG1cGmRMif4dYrLlz/2WSftLCfS74J7mws
	IfoNICVMvpM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6270DAE358;
	Mon, 26 Apr 2010 19:58:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C5EEAE354; Mon, 26 Apr
 2010 19:58:26 -0400 (EDT)
In-Reply-To: <z2n9f74dc2c1004260447y12b522d8if37cad56548738f1@mail.gmail.com>
 (Albert Dvornik's message of "Mon\, 26 Apr 2010 07\:47\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E5FA3A6-518F-11DF-A022-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145865>

Albert Dvornik <dvornik+git@gmail.com> writes:

> Junio: would you like me to resend with an updated commit message, and
> maybe the addition of Hannes's test as well?

I am out of town right now and suspect my mail reception for coming few
days would be leaky --- as Dscho seems on top of this series, I suspect
that the patch flow would be more reliable if I get your change via a pull
request from him when I return.

Thanks.
