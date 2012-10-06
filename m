From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sat, 06 Oct 2012 11:22:50 -0700
Message-ID: <7vvcenqx39.fsf@alter.siamese.dyndns.org>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer> <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZ1m-0005wH-F1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab2JFSW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:22:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab2JFSWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:22:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F368E8FB4;
	Sat,  6 Oct 2012 14:22:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UdxdJKIETU0OWr2QiF02BfvTL6w=; b=HoirMG
	FeKaGDVNcXlB1Duhbv8OEYUVy9eFPnewHvXtAxDyV/Z/vdGBzrlDaoaLxhdUoqWf
	VuUZ/rZ0NZozR4Lqg/d+3Lkk2CzkANrKNclkQSLPzJKwE47Rc70z6GUYKidVJc1L
	oE4Iu6M99bVjQV86SXEmCO8A6AhY+U6LFLCGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cRsowTdXjs3Ga8+zwaNpHyljN4yIi1EC
	A54+AsrdEX9u1UkCQIa0YYkDOBFoen/WEtPa8P6696rPg9SjYBJYZ2TnJtNlStRA
	BCW9Sj0EOR/dxhJju1A6mMDBCHXc9PAZBC0hSh4aR80g4m3mToTtuCNRag3+EdSr
	9gWXQBF3jHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BCA8FB3;
	Sat,  6 Oct 2012 14:22:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 609A08FB1; Sat,  6 Oct 2012
 14:22:54 -0400 (EDT)
In-Reply-To: <20121006131200.GB11712@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 6 Oct 2012 09:12:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8834448-0FE2-11E2-95F8-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207159>

Jeff King <peff@peff.net> writes:

> Another option is to leave it with "-i" semantics in the meantime, which
> are at least easy to explain: it is simply a shorthand for running "git
> add -p && git commit". That may be inconsistent with other aspects of
> commit, but people have (apparently) been happy with it, and there has
> not been a rash of complaints.

Yeah, that would be the safest and possibly the sanest way forward.
Did the documentation update patch by Conrad on the other subthread
look sane to you?  I haven't read it very carefully yet.
