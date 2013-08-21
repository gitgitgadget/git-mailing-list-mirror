From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/2] Fix IO >= 2GB on Mac, fixed typo
Date: Wed, 21 Aug 2013 08:58:04 -0700
Message-ID: <xmqq8uzvujcj.fsf@gitster.dls.corp.google.com>
References: <1376981035-23284-1-git-send-email-prohaska@zib.de>
	<1377092782-11924-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 21 17:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCAnW-0008Dn-3T
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 17:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab3HUP6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 11:58:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab3HUP6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 11:58:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D84E3A3CD;
	Wed, 21 Aug 2013 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lcXCSsTAAa+UjJKH+i/NAg//830=; b=W2BVxU
	V2fTGmdB8EcEffVzZTEbPmudPzxrYrudJn7Q3vdRe1BCre6pQ0FU0xQEQmLLAsgT
	benKOV1F4ncJS8+fXfhE2p4HcEBGtvAUWrlkYwkgY8/gFHV9rHJYlduNEkTV3fzo
	3kWvuVj2kVxBhaVqbPw2PxkhNzfHyjYH1R9PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V1gLvKWDx8Q8sQgDrRoHZj0tdgqWhtex
	ArJcFmSOgq2/1kJBEYJ4jGNwMMhOIbXgflSVAJPi9twknQPqwBbUn73pskST4AF2
	byxI5A2b03phG6OtytVUuVP+C3eJDNvzAR7zPz/89Pw6B9+1BrH3dx4Guwnmo0Dv
	JLj0VGoNu7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 818F53A3CA;
	Wed, 21 Aug 2013 15:58:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0F6B3A3C6;
	Wed, 21 Aug 2013 15:58:06 +0000 (UTC)
In-Reply-To: <1377092782-11924-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Wed, 21 Aug 2013 15:46:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78262BC2-0A7A-11E3-B770-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232706>

Steffen Prohaska <prohaska@zib.de> writes:

> Fixed typo in comment.

Thanks, and sorry for not being clear that I'll locally tweak before
queuing when I commented on v5 yesterday.
