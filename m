From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] submodule: only preserve flags across recursive
 status/update invocations
Date: Fri, 05 Nov 2010 15:38:40 -0700
Message-ID: <7vvd4bqtu7.fsf@alter.siamese.dyndns.org>
References: <20101103053827.GD10631@burratino>
 <1288765585-80823-2-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 23:39:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEUvz-0004Vl-D9
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 23:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab0KEWiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:38:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab0KEWit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 18:38:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2D5C3536;
	Fri,  5 Nov 2010 18:38:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CZiAJUNlztlF2sJjVGGP0QVJ3oQ=; b=kPIQZpCjmHdwhjHJUOtRYAJ
	f7Og54QR6+1w0/qW/WowKr571XhQHRI4VXLPYLLXTCk9/LMytYeQQ8smBOtz3m21
	Tvx8dqy9hgkfiO3NQ4M457f2jDm4HTZKj1S8V/+R57u/DSTpisvQaQQ4JzYAeyOg
	o44iEWzj/v1rHLVVHSNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=czLGHLgPiamlLbOpMvrR5zXMC9UaDuCZXOKaXfQ9zxScTJPv/
	oZOT2MbTRctnlxykRQw5d63uwaufDy+nNR6xfwa8Wz7fDbIT5zThFlq6U4uiftWn
	OmwVvxSWfS/YE3T2zrMbQICbsu7ZaH3XiD3ncMggNe1O9nodVAUWNC6H0A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B19123535;
	Fri,  5 Nov 2010 18:38:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A53863532; Fri,  5 Nov 2010
 18:38:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7435A856-E92D-11DF-AA2F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160827>

Well done; thanks both.  Will queue.
