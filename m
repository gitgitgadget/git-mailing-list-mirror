From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format_commit_message(): simplify calls to
 logmsg_reencode()
Date: Fri, 11 Jan 2013 14:15:30 -0800
Message-ID: <7v38y7bc3h.fsf@alter.siamese.dyndns.org>
References: <1357942509-21431-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 23:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtmtF-0007nO-9c
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 23:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3AKWPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 17:15:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539Ab3AKWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 17:15:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD198B253;
	Fri, 11 Jan 2013 17:15:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgso1T1CPGR0H/LsImaOOiys4qo=; b=slugGr
	q9z5X38cG7hT/6QxpDDUOn4imNr3IznW1R7tmuLR8o9lPXhJuX8Qm8/58PWGjejY
	2DlzdHfft6fo4ICCYxSBcXXHPvbAXE98xqnc9Y9sCj9cqJAuUN3r7uXJplr2Ja5a
	fBSvSDcSlxUB9j43WJo4fOtDCMaShSSNvuVBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cmiCmtwnCmXX8fruy57RDZk5RoDvuVtz
	pkav9oObUaFYg4pRaqxOhGbULZPhsWAmWydSx6jBhBAsdWLIKNPiLweWsVW4W8gz
	EVEJUr4ua+L/sLcpoRwuWZ4iEJlpxRE44RPvbKIogTseZjXl0dYWae4mAMpRwkdA
	PS3q8V55ySQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17E6B252;
	Fri, 11 Jan 2013 17:15:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E1F8B251; Fri, 11 Jan 2013
 17:15:32 -0500 (EST)
In-Reply-To: <1357942509-21431-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Fri, 11 Jan 2013 14:15:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A090AEC-5C3C-11E2-BCA7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213249>

Please disregard this...
