From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 13:16:24 -0700
Message-ID: <7vk4sxo6zr.fsf@alter.siamese.dyndns.org>
References: <20100326230537.GC10910@spearce.org>
 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
 <20100327013443.GE10910@spearce.org>
 <alpine.LFD.2.00.1003262142121.694@xanadu.home>
 <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com>
 <alpine.LFD.2.00.1003270959110.694@xanadu.home>
 <20100327191405.GF10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 21:16:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvcR5-00025D-U8
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 21:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab0C0UQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 16:16:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0C0UQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 16:16:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CAFA5E45;
	Sat, 27 Mar 2010 16:16:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x0R2LWrZICGU6xkgNWipkJXi6wI=; b=rZcBk1
	k8mqcIS0o7qqvG25WRltSLYfrXYWNXQBZwSUk+g+Vnzt8y9gpNBo9WP7wBLj77z/
	wtvWmlPnrYw+G3qaUS78ncOOn4h17PPKJRGwU3sDZKWV+Kk9kyhu2JGzShPWfMvy
	N0RHO6bm+0aQ744eJ9W11Gx+wqkLYf04HPF9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MHTjAnYMQX0ZczI2p4pSgVNlCKlTAQkK
	NxxHHKd1yPK3rMzWmrOqTGgW4QAnjOB059k8HVOSYS57fmfmotOPRB0GmkBDU/cg
	ftFVMCXuV3AR3wXpyuUikv4QxzCu1vl49BqzeWSaf+rRQzX+x0MRPlcWvGvX6KTl
	TfC7To/Sthc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E87CA5E3F;
	Sat, 27 Mar 2010 16:16:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49176A5E3C; Sat, 27 Mar
 2010 16:16:25 -0400 (EDT)
In-Reply-To: <20100327191405.GF10910@spearce.org> (Shawn O. Pearce's message
 of "Sat\, 27 Mar 2010 12\:14\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A344C398-39DD-11DF-83B2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143355>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Sat, 27 Mar 2010, Scott Chacon wrote:
>> > > My stance has always been that the C Git is authoritative with regards to
>> > > formats and protocols. ??It's up to Github to fix their screw-up.
>> > 
>> > It is fixed and will be deployed soon, but really, there is no reason
>> > to be snippy.  It is a simple and minor mistake effecting very few
>> > repositories (maybe 100 out of 730k)
>
> What is the C Git stance on these 100 repositories then?  Are they
> now considered corrupt?  Or is 100 enough in the wild that we have
> to accept the problem, just like we accept the 10664 mode issue from
> "ancient" Linux?
>
> I would love to say "those are corrupt, sorry, fix your repository".

This is why I first asked how widespread the copies of the implementation
of that broken tool are.  If it is only 100 and all breakages are confined
to objects created at GitHub installation, and the owners of these 100
repositories are not locally creating corrupt objects with copies of
broken reimplementation of git they have, I would say that we tell them to
fix it, and GitHub can hopefully help them as their hosting site.
