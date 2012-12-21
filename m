From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Avoid username prompt for certifcate credentials
Date: Fri, 21 Dec 2012 10:19:55 -0800
Message-ID: <7vehij1d4k.fsf@alter.siamese.dyndns.org>
References: <1356107479-6668-1-git-send-email-git@unrelated.de>
 <20121221170927.GA23574@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Bredlau <git@unrelated.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:20:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7Cl-0003jJ-Es
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2LUSUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:20:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab2LUSUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:20:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933C0A2E2;
	Fri, 21 Dec 2012 13:19:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=xvUHmQ
	UXT4GmwB+ZGJ3NsjMXmzLDPm+m6pkd82qpNdhxByVm0K5477rLyrpMaZOSuEwm2c
	ndVx4JEHo6nonv1KEJRjRMJSc+WetNu6Qe5orHHVphl7+5sau+1aogZUJ+j4U5jV
	S2uCQM6bozKpcF8MuEreBoiHLnVU765lh/hUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QsYbSCq/AECYUXtbRenLLJegBWK8KKVb
	QQVOhB0HYhQyRgx7rcmBuHyerbhNHSI1AfT43Xp+GIjCRGJ18HgHHfzDU9WbI2nk
	lTu3H+IHUX3OyWsIXorOB7NWsOm3Wi71vdkEB2qjMht92sNwtGC1RPOSL2celrJJ
	+YDu5ih+VHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66193A2E1;
	Fri, 21 Dec 2012 13:19:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0D45A2D9; Fri, 21 Dec 2012
 13:19:57 -0500 (EST)
In-Reply-To: <20121221170927.GA23574@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 21 Dec 2012 12:09:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06B8496E-4B9B-11E2-B6E3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211998>

Thanks, both.
