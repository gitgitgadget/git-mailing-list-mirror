From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation
 section
Date: Fri, 09 Apr 2010 21:59:17 -0700
Message-ID: <7v7hofzyvu.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 <20100407224942.GA20239@progeny.tock>
 <7vzl1eamss.fsf@alter.siamese.dyndns.org>
 <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com>
 <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
 <4BBE8BA1.1080101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 07:00:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0SnX-000385-Ju
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081Ab0DJE7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:59:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0DJE7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:59:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64793A947E;
	Sat, 10 Apr 2010 00:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6SxAn6JH9JwBAy2nXQbMs/0AzFs=; b=ie9WFI
	Wx+aQezgWBeGC2qnLgTu8Ho0QBSMM/BhefQer2vxqzsbhIeJ+PRMBr5Zyb4Xd5Mg
	Q6JDLA36uJrbhtyymDaUrCUqIWDLJi8EeJWTkEmaf5Dy1PJEZdgICkoxY97aoURk
	QuDT5M7yPCGaUzVq38B5jHU94Z2hqm3Si6HJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AF9LBwYq1THzjkt8fikGuG8LPCCzvujH
	GMcL8vNW7xI5yC9eiVQcmuw7DsGPTwBaJtjroZ/B8UrFx2X2EluBB/9ac7Bf0U8b
	x/s+txr9/KZBVKb+Re6ZQ/RU2gwQSF15TVawWdjDaR28dNlNwx1+odfnIu7cLHuk
	K3TqO4Lwl3s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B683A947A;
	Sat, 10 Apr 2010 00:59:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43DE0A9478; Sat, 10 Apr
 2010 00:59:19 -0400 (EDT)
In-Reply-To: <4BBE8BA1.1080101@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 09 Apr 2010 10\:06\:25 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8878470-445D-11DF-8E3B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144506>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm wondering how necessary that flipping of to and cc is. It means one
> has to switch one's send-email config between RFCs and actual patches.

This was my thinko.  "An ideal patch flow" says the final submission still
goes to the list with maintainer on the Cc: line, and that is fine with
me.

> It also means I should send fewer patches to you (Junio) directly (in
> addition to cc'ing the list), which is probably the intention :)

That, and more importantly, less uncooked patches hitting my mailbox with
me as an addressee, was an important goal.  I need to deal with patch
e-mails in three different ways:

 (0) just read as a bystander without much interesting input from my side;
 (1) read and comment for improvement; or
 (2) act on it by applying.

I was hoping if we can have some way for me to sift (2) from others
without adding extra burden on the contributors.

One way to reduce (1) I've been experimenting with is not to comment on
too many threads.  The theory is that the initial rfc patch hopefully does
not have my address on To/Cc, but once I comment on a patch, follow-up
patches will be posted with address of everybody involved in the
discussion Cc:ed to the thread (which by the way is a good practice and I
do not want people to break it), and my "grep for patch messages with my
address on it" trick to find the finalized patches will not work well.

But that strategy does not work very well for another reason: we lose one
reviewer if I try to comment on patches as little as possible, and we do
not have enough people who read other's patches and help polishing to
afford that.
