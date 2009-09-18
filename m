From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: add option --repo-all
Date: Fri, 18 Sep 2009 09:42:49 -0700
Message-ID: <7v8wgcb3w6.fsf@alter.siamese.dyndns.org>
References: <1253258222-11475-1-git-send-email-catap@catap.ru>
 <m3r5u43a8h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 18:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MogY6-0007nl-0A
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 18:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbZIRQm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbZIRQm4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 12:42:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbZIRQmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 12:42:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52E4337D3E;
	Fri, 18 Sep 2009 12:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nfj6uk9qitEhyrbafqmjQwpFJeI=; b=Fv7JFe
	WvVDWep+lFwOghYMgli36wHLRZCGbxC0uEV+gsthMpm2XCwFGvdCoSLzCCvXDHOX
	PC8hnbokgxa+N9yJZW7CV3X5WH30/sfq4gzQ9OZcUGW5J/PAdANNomlyUDbXzP5l
	u762+NUWPWOmHA5VyttobivBNTkodvPxroyXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMGcLToHi0+TroIYA8am/rDGnWfD6yq9
	e+Vlu8GvXMJq8z6HvHH9DYF/sJlHGyvnP3ttwdXtsyefrsDfzyuyn+RvR2W0KMvv
	SXsc2KHaAU/iBjV6Y2vZ5Zk04SKIL7Np5jx3zxmCretk58DEr2fB4qiB2zfpKQwp
	Gj7DOHypKCc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 296AC37D3C;
	Fri, 18 Sep 2009 12:42:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A8BD37D3B; Fri, 18 Sep
 2009 12:42:51 -0400 (EDT)
In-Reply-To: <m3r5u43a8h.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 18 Sep 2009 01\:52\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 507D847A-A472-11DE-8BE5-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128801>

Jakub Narebski <jnareb@gmail.com> writes:

> I have created 'pushall' *alias* for that purpose, but I think that
> such functionality would be better added to "git remote" rather than
> to "git push".

Also Linus added a mystery feature that you can have more than one pushURL
to a [remote "there"] section to push to multiple places quite a while
ago, so use of it is another possibile solution for what Kirill wants to
solve.

I do not think it is such a useful command line option that can be used to
only say "everything"; your suggestion to hook into the grouping mechanism
"git remote" has sounds much nicer.

Thanks.
