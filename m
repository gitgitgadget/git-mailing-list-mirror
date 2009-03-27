From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 09:20:47 -0700
Message-ID: <7vvdpvdjj4.fsf@gitster.siamese.dyndns.org>
References: <1238157134-27558-1-git-send-email-Niels@Basjes.nl>
 <m3k56b2hy2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Niels Basjes <Niels@Basjes.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnEp6-0004TF-Je
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbZC0QU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757665AbZC0QU5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:20:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbZC0QU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:20:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B769E9FBC;
	Fri, 27 Mar 2009 12:20:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0E37E9FBA; Fri,
 27 Mar 2009 12:20:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DFE7BD0-1AEB-11DE-BEBA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114908>

Jakub Narebski <jnareb@gmail.com> writes:

> Niels Basjes <Niels@Basjes.nl> writes:
>
>> Two RPM building improvements:
>
> Two _unrelated_ RPM building improvements squashed in one commit.
>
>>   - Building the RPMs can now be done by a non-root user.
>
> It was always possible, you only have to configure rpm / rpmbuild,
> namely put path to where you want your RPM_BUILDING directory in
> ~/.rpmmacros as %_topdir, for example:
>
>   $ cat ~/.rpmmacros
>   %_topdir        /home/local/builddir
>
> Please RTFM first, before going to solve non-problem in (ugh) fairly
> complicated way.

That might be a bit too harsh to somebody who genuinely wished to share
his improvement with others.

Being RPM novice, the first thing I asked around immediately after taking
the maintainership over was the ~/.rpmmacros trick.  We really should
mention it in _our_ documentation, even just a sentence or two would be
sufficient.
