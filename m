From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add option --is-well-formed-git-dir
 [path]
Date: Sun, 14 Aug 2011 14:42:05 -0700
Message-ID: <7v7h6fn00i.fsf@alter.siamese.dyndns.org>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
 <1313178913-25617-2-git-send-email-iveqy@iveqy.com>
 <CACsJy8D7W54w3ji6foXySCuvNLLBu=FY70z8+kB5hmJT_-3yCg@mail.gmail.com>
 <20110813061342.GA459@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Aug 14 23:42:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsiRm-0007R6-Al
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 23:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab1HNVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 17:42:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838Ab1HNVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 17:42:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E422F4D48;
	Sun, 14 Aug 2011 17:42:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/w+xGJFyy4vVMDkS+eO4MDDF9wA=; b=Wd0G4E
	pyfRzLA4iHA+dN5vu1oXTGrV1ScDVRpAuBZr99/ocRaA/Pu3iB+TzRvmsBrT5sOS
	mv1q5l8jGZzuaAuCDd9d25J/JAITqpFw+IOswdDTSZaoUp7LyqkE8VlRYA+3ffw8
	sZAwWVfGLmqNxWQaMF5jyudwQrcMWGg1tw6po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HNUzMhWdo7cOJDm8u9w9BtalyQMoTu6F
	Dx3TmR+Yf7g9NT6wqJfNgTF5mYdAa/Xxqjl8njDi+4p8y+9JUwzEFdi6T6hjOl05
	7rzLZcGjj83bfU7OAo94DDfRs8gyP2EnW50t8s+GFbvup2V6AzKApkw+UaKoC5oR
	chaXGkoDoEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D989B4D47;
	Sun, 14 Aug 2011 17:42:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B6934D46; Sun, 14 Aug 2011
 17:42:06 -0400 (EDT)
In-Reply-To: <20110813061342.GA459@book.hvoigt.net> (Heiko Voigt's message of
 "Sat, 13 Aug 2011 08:13:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4167C1BA-C6BE-11E0-86ED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179349>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> While we are talking about names how about:
>
> 	--resolve-git-dir
>
> ? Since we had this information already the option prints out the found
> resolved git directory and could be used for that.

I think we have a winner in the bikeshedding contest.
