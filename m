From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 12:39:02 -0700
Message-ID: <7vvdcsje3t.fsf@alter.siamese.dyndns.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
 <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
 <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>
 <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>
 <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
 <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
 <alpine.LFD.2.00.1003181256310.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsi2S-0003G0-G8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab0CSTjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:39:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0CSTjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:39:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35295A31DD;
	Fri, 19 Mar 2010 15:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Lb5Ay1C5n6jxfFjkzRbROPkgQtg=; b=KABZ+VdrFmAqao7JZXkzYKC
	IyRFy7eermp8GR/UQZWsvDH/KQolEu7sL7Xwd+YvLLhTf27kRr9OeSoSQ+yLtbLs
	Whyzxk5SBnIL3oT00dT1o/Yf6SYiEs3SE5mmgbUAkxpyzU+k4ZFaYxqshYuEXM2X
	28Kw9l8SfJ9nWizoQKr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DHn9DAQ24w5JowhnCBjX0kqZWCy4GAhpt6jTvoKAjKMw4mdA0
	VDCvVyCIv3AO6pNm1TscFiDFOkx9o+G+k/njknFSifQW1MAYVxGMIadmUYEwSlt/
	asNV3fDXVcH3uUQr/1R1g8ZVbmoyHu8PuC/xT+tvLi4o6QU+AXn79pNLtY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4DDCA31DC;
	Fri, 19 Mar 2010 15:39:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F14CA31D8; Fri, 19 Mar
 2010 15:39:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1621FBCE-338F-11DF-8711-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142641>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (And yes, it does say that git should probably have errored out way more 
> aggressively about badly set up host/domain names in the "guess at email 
> address" code. My bad. Maybe it's still worth fixing for the future)

We made a small step in that direction in 49ff9a7 (commit: show
interesting ident information in summary, 2010-01-13).  I think what it
does is sufficiently loud (but not annoying).
