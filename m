From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: use compat regex on IRIX 6.5
Date: Thu, 09 Sep 2010 17:10:48 -0700
Message-ID: <7v39tilapj.fsf@alter.siamese.dyndns.org>
References: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil> <aIkKF4vjSeghwDQ63eyGAvzoq81HvE3fJPXM0HchsiJm2ahDUH-dO4jBA6nOEoyKGFpRKLAY7_A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtrCw-0001O5-3t
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0IJALD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 20:11:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0IJALC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 20:11:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 217A9D4536;
	Thu,  9 Sep 2010 20:10:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VoJHcZ2551UcKuNzrAuPlrcp/vE=; b=aLGMdC
	xThOPnh8PbZkkQ8cox6SqFpQWOQ1jtyHCBQx82SDBeLMMr4miu+CbRwGyTO4Ec65
	mh2zZozrep7HdrXdw87X/NqLtiSWt2UD+aQmLy3VLyhJ8Xd2mXFHdhNaF5b160pZ
	NCL35DBUUBeqH03Fsvx6DGBUFzAUn1xJe9NX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oudnshMvQCad6e5+gmrtt6WqRyLru0Ef
	joQPInoksHONSD4rrtPj52PnzBUD0BK6GOUsMvfwxYeeA0FNZVu0AsVDBEZbk6GN
	D6VtmFh2XDt+2A8bx7gic4Cbrc4UwXRKWcOJF+KmaVNzSH1mjxwC55pXBciOC166
	J3fJ48NGhBc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D21C5D4531;
	Thu,  9 Sep 2010 20:10:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09F66D4523; Thu,  9 Sep
 2010 20:10:49 -0400 (EDT)
In-Reply-To: <aIkKF4vjSeghwDQ63eyGAvzoq81HvE3fJPXM0HchsiJm2ahDUH-dO4jBA6nOEoyKGFpRKLAY7_A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\,  9 Sep 2010 14\:15\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E11982D4-BC6F-11DF-A928-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155913>

Thanks, as always.
