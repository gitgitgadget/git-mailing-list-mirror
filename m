From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] t7800: "defaults" is no longer a builtin tool
 name
Date: Wed, 20 Feb 2013 20:55:03 -0800
Message-ID: <7v7gm2xo48.fsf@alter.siamese.dyndns.org>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
 <1361419428-22410-2-git-send-email-davvid@gmail.com>
 <1361419428-22410-3-git-send-email-davvid@gmail.com>
 <1361419428-22410-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 05:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8OBz-0005CI-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 05:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab3BUEzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 23:55:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab3BUEzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 23:55:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30EB6BF33;
	Wed, 20 Feb 2013 23:55:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v9h+KeIJKOEsy9VLORTuKSmVj7M=; b=n26UWo
	kb1akF9udsObTjEc3UyR8N0PR746XUS0wdWbzlJ3O2FJO9IU9Hm9ggLojGgNpd40
	KM7M0sTQfU/+L3oLAcvSWvZ7bagtK7bGszJNnOgqmoG1PSuFfr4c7Jn8yzYxyN3R
	8H2nrP/0UswOIQyphZByuGzoRE6uxeH4MqN1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hzuDuoSp4HtXnaIrD0yLJqHWTUZ4AnNA
	kGGtIPgf/lt9HHc2ZMfFutdN3HbBv0Dg+x0Kb48aaPim2bjFQhckcOwIfvciGGRI
	pUdDeZvQYcUqi+h3WPi786o6aLXXmr+ryLqQT5Wqt2/PkhVvyE7hE0VaRlZrqFic
	aQamGY75NQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269DCBF32;
	Wed, 20 Feb 2013 23:55:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92119BF31; Wed, 20 Feb 2013
 23:55:05 -0500 (EST)
In-Reply-To: <1361419428-22410-4-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Wed, 20 Feb 2013 20:03:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBDD3CC2-7BE2-11E2-9233-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216751>

Thanks; will replace and queue.
