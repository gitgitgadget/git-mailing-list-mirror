From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure: allow user to prevent $PATH "sanitization" on
 Solaris
Date: Fri, 09 Mar 2012 08:29:31 -0800
Message-ID: <7vboo57n6c.fsf@alter.siamese.dyndns.org>
References: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
 <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 17:29:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S62hG-0002a4-QI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 17:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab2CIQ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 11:29:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2CIQ3d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 11:29:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF1259BA;
	Fri,  9 Mar 2012 11:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SkI0u0TLsxeMvuAeTlYEUP3DAYk=; b=S1asON
	4DLBlqlmFHf8KFMos0dzbRGADL8azv9Aqzz6l1QePT28eemqDo+QOiiY09aghADO
	Pfrqh1wRcL27VtnvxXvenfAqndFu4Cru/MiinkRbRI2MtR6QU6Wm0yhbyAJ2qB4w
	c/5W38U+TwmA6h6+8BMNW295y7+HqyZ0TcJfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ki5P36lbTjgEVfCs4QJKdraHeq2xU0rw
	3+8buEx9RDAmn1hp+6Ij2KGSd6UhkUm+PwtNNMlwCW1Xo7cv0A8Ul+Uw3Ct4ko6d
	Ykd702OyTei9uYTfrl9rkG7KNV9nzm04v/lL76M6c6a0ljtSYkkG6Us6IvctTE9X
	ui8LxqQh9VY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B1759B9;
	Fri,  9 Mar 2012 11:29:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E5E359B8; Fri,  9 Mar 2012
 11:29:32 -0500 (EST)
In-Reply-To: <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 9 Mar 2012 13:43:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D31FD58-6A05-11E1-BD1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192727>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>  Hi Junio, sorry for the delay.

Thanks for not forgetting.

The contributors are used as "tracking system" around here, and they
won't get "what happened to your stalled patch? Any progress?" from
anybody (unless there are others who are deeply interested in the
topic).  Delay is not a problem.
