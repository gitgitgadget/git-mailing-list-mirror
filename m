From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Revert "compat: add strtok_r()"
Date: Tue, 26 Feb 2013 09:18:47 -0800
Message-ID: <7vobf7m1s8.fsf@alter.siamese.dyndns.org>
References: <1361897918-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, b@rr-dav.id.au
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:19:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAOBW-00034i-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 18:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab3BZRSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 12:18:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab3BZRSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 12:18:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1AEA670;
	Tue, 26 Feb 2013 12:18:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=o3LmnW
	CiHCoiiBmDHCeg3DbsqErLlCTR7LsE9n+HO+5vuyUFrNWSE6+odatu4qOyzOvwt8
	hRfxeYJLAbOKfTvIxi26AqsAIuc59ahzpj6HcFPAZ8TCoCY/vIWNeJa/47umJefE
	2rJTHKBm7s0A12oF0NNx4M0fOrW9CQ1x+LUcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oXcRsAV7DQKLBsUerM1JABX5Oqr1EfjP
	4E3RiqJ5fLGLCWUm6VihG7wGQ/obhKJgZHvaAMz49soE0NltS14M59B7drEDqP8T
	QaD7hclEwxk09CBhBZ2GfQ2DsQoBIxzU903utx3Kb9WA3vfKvf9sZSAoyzDL1iPm
	XTAB8VXpEXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F899A66F;
	Tue, 26 Feb 2013 12:18:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B228FA66A; Tue, 26 Feb 2013
 12:18:48 -0500 (EST)
In-Reply-To: <1361897918-8824-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue, 26 Feb 2013 17:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 956381CA-8038-11E2-8722-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217150>

Thanks.
