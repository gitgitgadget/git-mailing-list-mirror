From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Add library for string-specific memory pool
Date: Fri, 11 Jun 2010 12:33:42 -0700
Message-ID: <7vk4q5ictl.fsf@alter.siamese.dyndns.org>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
 <1276175389-6185-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 21:34:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON9zV-0006AS-Av
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 21:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760374Ab0FKTd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 15:33:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970Ab0FKTd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 15:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD563BBE4A;
	Fri, 11 Jun 2010 15:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bcc4JrOZkq0XPFt1REJEUiHWd68=; b=oqMpslVmBlRuDWKkSbR1ENs
	R7QyOXCMZgJInYHgdzEc0y2X373V26sREvP+Ux4lQsBWW5dwlfNOnW/s99y9m+X/
	NwDZoMMZGN2E0tfPTu0OGBFWdmK2rWyatGxaRfhpu7MoSF7QqxPnzPyKDHniWuFd
	Sp+0zrF8vnd7dHvnMCFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RmEZiLGVjWHoF+o33ac18kzV/xP2WenzhtUzengR9+pLCeYPG
	WUBotCiOcw29UgrxCQRSwjTff+Z1huyl/FE2O4QquUwiwUp99ZYJVDObaCX5i5XC
	0r3jDg87Hb7WdG5mio9PYQPWe2aqbobRlA7CnMv2PJL3LNWCqla0Oz/yVk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66A20BBE49;
	Fri, 11 Jun 2010 15:33:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62E37BBE42; Fri, 11 Jun
 2010 15:33:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42FB27C2-7590-11DF-8E96-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148966>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
> new file mode 100644
> index 0000000..a69d165
> --- /dev/null
> +++ b/vcs-svn/string_pool.h
> @@ -0,1 +1,15 @@

How did you manage to get "-0,1" here?  This is supposed to be a new file.
PATCH 4/6 throws the same puzzlement at me.
