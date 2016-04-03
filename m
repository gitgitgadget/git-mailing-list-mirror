From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/34] t4001-diff-rename: wrap file creations in a test
Date: Sun, 03 Apr 2016 10:26:00 -0700
Message-ID: <xmqqk2kefvtj.fsf@gitster.mtv.corp.google.com>
References: <1459704240-28792-1-git-send-email-gitster@pobox.com>
	<1459704240-28792-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 19:26:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amlms-0007Zg-1i
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 19:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbcDCR0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 13:26:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752687AbcDCR0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 13:26:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15BC550FD8;
	Sun,  3 Apr 2016 13:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dfgCh5hf2rw8DkZb6R6sl8pGBV8=; b=MHu1Nj
	jNnn6j1pxEKV6rCpF62+jr65WZ7w+hGUwsqhW5zCS188y/qejp4RQm4QtKsD7TD2
	+3PGJJNoe/LMRyH0HFElAJ1F2+HXEOIvUaLB6amLOF1tiMYBQGdTvas8bl+WKIzN
	u9nVSZKTycLW3m3NjmRC20pjsY66cg+aG0K/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fc4uU2CT8YoeQDkubDGBxGEj388wjAV7
	l9fdr1llp4jX+ajlJa+aHfXk4TMmWTlILVZd6sDHhYbnFrhCgNWIr85zcizbRzdN
	wJ27mkH5J9uZMXD6+HU4qv+fGEgX0jfr3vEQkDxxmKia1T6jtSmKPZegNeyQBUI6
	ufBxXgD/Q0Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03EB250FD7;
	Sun,  3 Apr 2016 13:26:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4750E50FD2;
	Sun,  3 Apr 2016 13:26:02 -0400 (EDT)
In-Reply-To: <1459704240-28792-2-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sun, 3 Apr 2016 10:23:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 236DFC7A-F9C1-11E5-BE0F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290643>

Sorry, please ignore (I had two similarly named scripts, one drives
git-send-email, the other drives something entirely different, and
mistakenly invoked the former when I meant to run the latter).
