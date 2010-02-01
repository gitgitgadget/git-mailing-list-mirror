From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-p4: Fix sync errors due to new server version
Date: Mon, 01 Feb 2010 12:47:44 -0800
Message-ID: <7vvdegvg27.fsf@alter.siamese.dyndns.org>
References: <20100201193851.GA6134@gmail.com>
 <alpine.LFD.2.00.1002011455440.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, simon@lst.de,
	git@vger.kernel.org, pal_engstad@naughtydog.com
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 21:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc3Bk-0005uL-EG
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 21:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0BAUr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 15:47:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab0BAUr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 15:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46E1C962C7;
	Mon,  1 Feb 2010 15:47:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3myKJXg/ISTRNxpN/1k4seA64c=; b=X8vkZA
	S5WNhTdoJv4mnM5ocvHp+iP4Y5ZO7IozpO4GDOWiY6ysYuEeMMwUME1CCvJ+C3JW
	jWtkERfgwCcrHi3pSE2uEMAx9Pyqn373Kc2bh29TMdN1/GN+6U5+c1S7Blvilqsv
	Twmjim7Nqwhhm8OTiogxpk+T2jgLPY1Ytl6o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NOuw9YLHj5ud1rO2USRMihI4G4z7KXb+
	j6yOHT4CJbNtHbCLWm3iYfir0YK6lbLJ0JrcsrKaizd/+5bnfr8BTuODsJtxSq/P
	LB3t5AWey0W8DzTFU88IueyDyAtPjywJlbQYUQbFllNgaSfY1LTHf3rrxPid/2ro
	464mDtOevrA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A8B962C4;
	Mon,  1 Feb 2010 15:47:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07501962C3; Mon,  1 Feb
 2010 15:47:45 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002011455440.1681@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 01 Feb 2010 14\:57\:36 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10A2A7F6-0F73-11DF-AA28-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138646>

Thanks; will queue it to 'master'.
