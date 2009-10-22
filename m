From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Thu, 22 Oct 2009 14:42:55 -0700
Message-ID: <7viqe7f6lc.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <m3ljj3es02.fsf@localhost.localdomain>
 <fcaeb9bf0910220415v69c22ed9o4ab85b8858fbf187@mail.gmail.com>
 <2729632a0910220831x4b67021eg772abc8b751ef7e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 22 23:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N15RE-00079V-2e
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbZJVVnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbZJVVnE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:43:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbZJVVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 17:43:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A626329B;
	Thu, 22 Oct 2009 17:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rMb0IJULakLsuWhLzgbIO5ABMMg=; b=NjO8nOtcFaDxC8ET5z98gB8
	LTkCkjXv4vRQSJjcdfdRazCdcm9mMH+dJCDNWO/f7szzzslBoCboxrQZZC0DjmiY
	vAWwJ8qYnQ4rKFFdixCD8rn1Aql/RCJFc1XZ67+n3dg+GdJpSdarAiW10cLJO0Gs
	9i2soH22mkK80dCa5z+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RVZID3WrPt3ZrRXRplZiqu1eN9Qi6F2wYq4UEnLAmd/GvXJ2l
	zdm0sSvS6681RkNDRIBlI38tgNPrf1CEZFCzD/Yao20PwkpZz5kfaNBdBXlsRKqY
	WwhLXP/DqmvceX6AzZuGB1rFJpbOIMQV4SU0qiWK1QNEmBvUh1rO8KvdIU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC5216329A;
	Thu, 22 Oct 2009 17:43:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0ECA63299; Thu, 22 Oct
 2009 17:42:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFF19352-BF53-11DE-9ADF-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131068>

skillzero@gmail.com writes:

> Just an FYI, but I've been using this series for a while. I'm actually
> relying on sparse support in our internal build system (via my private
> build with this series) so I hope it doesn't go away :) I haven't
> really noticed any problems (I thought the index state got out of sync
> once, but I couldn't reproduce the problem later). Here's some
> feedback though:
> ...
> That said, the current level of sparse support provided by this series
> is good enough for me because I can build my own scripts like this on
> top of it to automate things.

Thanks for sharing.  It is the best approach to start by adding minimum
core level support and then to let people (like you) with real-world needs
to experiment with custom wrapper scripts, to figure out what user-level
concepts and workflows work and useful (and what don't and aren't), and
what additional core level features is helpful to support them.  Over
time, successful custom wrappers will become the best-current-practice and
can be folded back into the mainline, and everybody will benefit.
