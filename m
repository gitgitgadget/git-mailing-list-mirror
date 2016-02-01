From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Mon, 01 Feb 2016 13:42:02 -0800
Message-ID: <xmqq4mdsumz9.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9ihnveu.fsf@gitster.mtv.corp.google.com>
	<1454198761-27357-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:42:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMEd-0002PI-2C
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbcBAVmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:42:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753678AbcBAVmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:42:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B62241576;
	Mon,  1 Feb 2016 16:42:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=aE32Il
	5B+QgJWkZzMu89JYEUcgrgF6FNNttkayFfouELVGIx/H0zuj1TckDCj+999lVth1
	yK+KSUHsUOQnwqiW+7gswL421nczMGYmTuiDSzR+CvzxAd9ybujn3Ba5ZVEMm0lc
	oY5GTAR9Tg3xuwPVY8HP1QVrWNnezvXrUo98k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQFJ/PBU1Tu57MVpKs6ksoPfRx8a2360
	3hM5S18OotdkPMT38gnBjTKIbx4RcExNDAmmUYHDllEb7mPDaKCkzBuwC70mhccy
	SCq6yJ0uGSxP4plvd+dUPOXddcffVUo0vDiTlKqlOiWihn3cHutwCoPQI//HWFmn
	yqsMSbHjxt4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 828A541575;
	Mon,  1 Feb 2016 16:42:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AED674156E;
	Mon,  1 Feb 2016 16:42:03 -0500 (EST)
In-Reply-To: <1454198761-27357-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Sat, 30 Jan 2016 17:06:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1F090AA-C92C-11E5-A82E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285218>

Thanks.
