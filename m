From: Junio C Hamano <gitster@pobox.com>
Subject: Re: core.autocrlf considered half-assed
Date: Tue, 09 Mar 2010 09:11:15 -0800
Message-ID: <7vlje1zah8.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
 <20100307092701.GC31105@dpotapov.dyndns.org>
 <alpine.LFD.2.00.1003071538350.30214@localhost.localdomain>
 <20100308185719.GQ2480@ece.pdx.edu>
 <alpine.DEB.1.00.1003082011440.14277@intel-tinevez-2-302>
 <7v6356r1w9.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1003091026060.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 09 18:16:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np2xy-000446-PO
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab0CIRL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 12:11:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0CIRL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 12:11:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F0CA0AAC;
	Tue,  9 Mar 2010 12:11:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zL8O/QyIovYsrK3EP5aDm8THQTw=; b=F2Kj5SbgZNzzKXqKvRTnEF5
	hl4EnLe/EMGtCesNRB8Jis+jenpgwfIJo+ThStovO0kk0q8DxmFHrPtsXNJPrea7
	VYpeiqrWKQvg05/04eQ9tyOne/Tz23Pq+u+7CwGBOrJEtovwhHAOiH/JZxhFSpKY
	yju5fcuNhUKuwxoUy828=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Yj7K/EGfmaA6VUzlfBPk4ne5MaGOTRiEi2xSP93hTxDLtsiUy
	lsUA/MGTiVo3ZHOa/DZfAq8gzV0/uatngws92wu6WQ1apIlg7MJKX29UxHLKjiWB
	5oiS9XwoFFIsfAtQ7tDb1hgaqzPT70erR09lweo+vSDS71FJAnKSGNnmkE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C4B1A0AAA;
	Tue,  9 Mar 2010 12:11:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95292A0A92; Tue,  9 Mar
 2010 12:11:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C93D2484-2B9E-11DF-AD08-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141834>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Nevertheless, I agree with you that if a similar situation happened by 
>> mistake and your project does want to enforce core.autocrlf, it would be 
>> nicer if there is an easy-to-use one-time clean-up procedure.  It hasn't 
>> been my itch, and I suspect it wasn't Linus's itch either.
>
> The problem is that the whole thing was not your itch, but your 
> implementation. You never used it, so you never caught the obvious flaws 
> in the design.
>
> Sorry to be so direct, but it seems that my more subtle attempts to 
> explain the situation failed.

No, being direct is good---it shows the thought behind what you say more
clearly.

Think what "your implementation" means in the open source setting.  It is
what you were given for free, you could try to improve upon it if you so
desire, and you should be thankful for it.  It also means that you know
the people to ask for help as it is "their" implementation and they are
probably more familiar with it than others.  If you happen to be in the
position where you can see shortcomings in the implementation better than
they do, that's good; they and you can complement what each is good at,
and make progress collectively.

What it does _not_ mean is that you can _demand_ anything out of them,
though.  An attempt to shaming them into doing something amounts to the
same thing.  Having seen the way you have behaved on the msysgit list and
its tracker for a while, I thought you understood all that.
