From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git describe --first-parent
Date: Tue, 11 Sep 2012 09:10:28 -0700
Message-ID: <7vwr00ilqj.fsf@alter.siamese.dyndns.org>
References: <cover.1347370970.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBT2u-0003gA-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab2IKQKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:10:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab2IKQKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:10:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0F56D3F;
	Tue, 11 Sep 2012 12:10:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzuM6NmVCkrGJitYdSVPkrGeR00=; b=HqZ4HE
	KTUWsuUs5P4u4AkrIpzlYB7gO8mA+tRLBxTwZVydQdwhJWt0IYxbIFRZh1VYN5Sw
	irIOXBfGJhkDeTaDxfVdNaY4+exZJRSPr+MdiZ56LIRDlbiq1wm1qVGFMB2Gjyrj
	yGdrEmNugW3egDWil9DwCYUtTlsyYjoUNiv9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eFZYtVgWPFG/hSJ7zNJh5J30pL3YO/T5
	twJ+bq6GhtilsjdcUAttjIy28T03RyadShhTM3jdnugh2Jvy0FiE1Ib2ciXWSHKv
	8DgJjlHYeOIMYGwv/G0HX9ctmTTRXpkJNcpYAbiwEy/x3hV1esm2HBf9XgQujMIb
	6oCKydDmN/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B276D3E;
	Tue, 11 Sep 2012 12:10:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC6EF6D3C; Tue, 11 Sep 2012
 12:10:29 -0400 (EDT)
In-Reply-To: <cover.1347370970.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Tue, 11 Sep 2012 15:51:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34F0189E-FC2B-11E1-92D9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205244>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> While "git describe" behaves as documented, the notion of "most recent tag"
> is not really easy to grab, and it's not always the way you want to describe
> a commit.
>
> "--first-parent" is the option which answers the question: Which is the
> most recent tag on this branch which can be reached from this commit?
> ("This branch" being defined as "--first-parent" walk.)

I see a confused message here.  If it is "the" option which answers,
what is the question?  If the "question" is the only question people
would ask, you wouldn't make this an option, but update the default
to do this, but you obviously did not want to do so, so there must
be cases where using this option is inappropirate and is not "the"
option to answer the question the user wants to ask.

Also, how would this interact with "--contains"?  Should it and if
so why?  If it shouldn't, why?
