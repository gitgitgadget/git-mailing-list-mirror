From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] Support non-WIN32 systems lacking poll()
Date: Mon, 17 Sep 2012 14:03:59 -0700
Message-ID: <7v392gtl8g.fsf@alter.siamese.dyndns.org>
References: <k36h3i$ihb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiUO-0002Zu-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab2IQVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:04:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2IQVEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:04:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7451D89E3;
	Mon, 17 Sep 2012 17:04:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2qbyOJPiWOsIs0Avo9DfMbP9F1w=; b=SSAcj5
	1zmQht0ohuiGJdXxjhVe9ax31Pp+cBi3RncsBiZWJtaWrbLK+Bh/oSc/NLi4qmXl
	Y0WhvXow6qtlJNzW9ItSvz68WPPicC6Wldbgz6o1HnGsmWk+/jBzCVBIfDXQDGYh
	DDXPVmNIP9yPidc0HEgQ7y+DefhXaNEWvneBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOMfa8qSF5Fnu6XnKMr5/YwKhGOB48lx
	PyVCTJZIavvtZTjy72OEUuop0EfW9yOwUPE/SH83B+Gx1/SZjpV2NWmY5E+VUUou
	jxGqQ8PmCmvT4UEs0kYuTIbA/wXy9QlmkC4ESaCjCjWMfyKFLxcyCuW6LwvWSPcl
	2yiezd4Qjn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FF1389E2;
	Mon, 17 Sep 2012 17:04:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89DE989E1; Mon, 17 Sep 2012
 17:04:00 -0400 (EDT)
In-Reply-To: <k36h3i$ihb$1@ger.gmane.org> (Joachim Schmitz's message of "Mon,
 17 Sep 2012 08:48:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34264840-010B-11E2-8FD8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205747>

I really wanted to take a look at this series, but with the broken
patches I cannot.

Try again, please, perhaps first sending patches to yourself and
make sure they come out without losing leading SP for context lines
and such.

Thanks.
