From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 12:24:13 -0700
Message-ID: <xmqqsilp5jj6.fsf@gitster.dls.corp.google.com>
References: <xmqq1tt96yyh.fsf@gitster.dls.corp.google.com>
	<1406315496-10237-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:24:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAl6R-0007OP-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaGYTYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:24:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61075 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbaGYTYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:24:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D92D2A51E;
	Fri, 25 Jul 2014 15:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=30E4JzzK0e0hMJQfJNqJDO+SMcQ=; b=Us09kR
	Wbi+b15J4dSHQiKa7e7NPigSdHBcGXuW0h0dhMKT20YQ07gxnAmaiqnz35DFwxFS
	Wm6q2Zuk1/Un2G0dXiKujl8HnxQKe71uFwyuSRRjAWVw+02ysxuFX9rNWurKA9KE
	EBGuY27OtyKiLCDzSqCG6oxGAG/JMx+5C3twI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuYCrrnD9sadYg8AmHxHzIxOE/RNrDf7
	oaO8JCvEQQodmxjbnEUwU21C/nlgQ0sBTWzBWQD5xk7p7MF2A7byL6noryW6rId5
	5VGMjZ9fok7mFc90wlqTFf9kF4x5uK4Npg78E5wMpAFW6sTxlMXxnZaYBDdmFtqA
	hiig0bzUUEQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 318402A51C;
	Fri, 25 Jul 2014 15:24:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39D902A508;
	Fri, 25 Jul 2014 15:24:15 -0400 (EDT)
In-Reply-To: <1406315496-10237-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 25 Jul 2014 21:11:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43DD0F9A-1431-11E4-99CA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254262>

Thanks; will queue the patches from this iteration.
