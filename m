From: Junio C Hamano <gitster@pobox.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR 
 invocation?
Date: Fri, 08 Jan 2010 08:02:11 -0800
Message-ID: <7vskagh9fg.fsf@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHIS-0008Gs-EV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab0AHQCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455Ab0AHQCT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:02:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0AHQCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:02:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD428F009;
	Fri,  8 Jan 2010 11:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eorG+A/WB+0RdBkDZG2jW9iSB8s=; b=tW+lbc
	hmiWk2cVCMN32sOKpDXV5FGBKXNOJiM9rKtpi5I27wIOS5PAUb2vfYwjqSKuE8w5
	XGvJl0ck5YnJJVeMPiaqbjhkh2fG+CXSKgRZpvjaYfk+ClIt7eV9P1Zww7kBJT74
	G+bIIbMyyNZJlcSxEftHtkJX0+X2xrBcVaKLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tljeBiXUSDJ3vNgpVmpL6psLhFClNkSE
	QhkYtSgRBs002pNbonvhUKZYoICbXc6xk4sZUXWn6qIjuZIb0VGKIKAf0LJiDacx
	t/He/pJOOL7MpbAcPq5NpwLNlaIHEQcMzX5ak8+tzCuHG/WtPNIaeLQQ1vbuLQdq
	5FXXb9HcWJU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C68CA8F007;
	Fri,  8 Jan 2010 11:02:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 344028F006; Fri,  8 Jan
 2010 11:02:13 -0500 (EST)
In-Reply-To: <xuu28wc9xd42.fsf@nowhere.com> (Adam Megacz's message of "Fri\,
 08 Jan 2010 07\:35\:57 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30CA857E-FC6F-11DE-9D4B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136448>

Adam Megacz <adam@megacz.com> writes:

> I propose instead that "git commit -e" cause the metadata headers to be
> provided to $EDITOR.  People who care about the metadata can simply get
> in the habit of always passing that option when invoking "git commit".

That is already done by bb1ae3f (commit: Show committer if automatic,
2008-05-04), so there is no need to propose anything.

I see a bit of room for tightening logic in that ancient commit, though.
