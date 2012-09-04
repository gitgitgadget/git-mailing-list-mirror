From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 09:49:03 -0700
Message-ID: <7v4nndd98g.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
 <CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com>
 <CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
 <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:49:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8wJR-0000dZ-0h
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab2IDQtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 12:49:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932389Ab2IDQtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 12:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEE94973B;
	Tue,  4 Sep 2012 12:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y9S5QtSCI/UdkrfEhyzuAspxAz0=; b=hjfgCQ
	3gkNtojR5vXKyuVBbiXQrcUB6WcPqnyg55QvWDYwGsVPGgWv2VNBIRSoQAoTMXvq
	MsT1waNGNi6Z4gkm1LS3ihJZvEGaKREY29GWMsTVLZ23n+t0a4XHTYrLpgkRB8X1
	Ap8q6oXxfYU+sITTEQLUhUxVIFgMgVtemwRQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPzcFdbouVBiCAZ/2y56h7FBfVTEdI6l
	/uv1O2a0dZkCGP1dVBAhEcX8SBsiYkI8vcf0Sbo4x/pGN9N58pNW+u2cl9bSt5Bc
	0wy/odpEXCMOKL5jMh/1arNEzcasnIsFPxfROPiUbHcB62CqL7L2xGgtp/Lmj9vY
	70x7ixqZdIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4CB973A;
	Tue,  4 Sep 2012 12:49:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F12E19739; Tue,  4 Sep 2012
 12:49:04 -0400 (EDT)
In-Reply-To: <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com> (Angelo
 Borsotti's message of "Tue, 4 Sep 2012 15:24:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FE7A5E6-F6B0-11E1-B5A9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204751>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> That of "git checkout -- *" is the problem when the directory is empty.
> Note that this happens with the shell that is shipped with git (in the
> windows distro). A note in the documentation could help the user
> to understand this.

Passing unmatched glob intact to the program has always been the
standard behaviour of shells for decades, and is not specific to
"the shell that is shipped with msysgit", no?

I would imagine that msysgit could be shipped with man pages for
bash, but I doubt anybody would consult it when hitting this "I
typed * in an empty directory" situation.  In any case, what to
include in the package is something msysgit folks to decide.
