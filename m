From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 12:29:02 -0700
Message-ID: <7vboo1sjnl.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312164812.GC12405@1wt.eu>
 <7v4nttu2gf.fsf@alter.siamese.dyndns.org> <20120312184549.GG12405@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 20:29:29 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7Avv-0001PZ-GE
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 20:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab2CLT3K (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 15:29:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891Ab2CLT3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 15:29:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46F57D12;
	Mon, 12 Mar 2012 15:29:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eX/pyjlt0xNKUwkn0DvE9Zi9YKs=; b=eVKju1
	2Nud+luyzygpBP+tuhLlPKJ4+lHJeN+20g9TxnIBtwKmQOBmR0CJS5rl4TuwKXjs
	xPTA00h4Btn45qW/4tL9+zv7Q8mlskMnVjoj8n/BUDhWWjlsv/oJEDavwr7yn8OM
	wYFitXDFv6V/9gX3irdKVN/y8559NqOBbzz60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utzjTBrt21Iupkyi+/8J9QslfzKnEqOS
	BHjQp+rsue5gc3p16fDpEWyQ9BhDe8tY4zhh0pbMV+j+rI7DXKgmPmA8AotCokkM
	t1oOZSegeHLxdDTZ1KJz0vqjWT53iJS3Y1sVOaEMTLxFhKW5IOeWSOdMLqxWUNNP
	hUBP4tqZ1TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB1BB7D11;
	Mon, 12 Mar 2012 15:29:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BFCE7D10; Mon, 12 Mar 2012
 15:29:04 -0400 (EDT)
In-Reply-To: <20120312184549.GG12405@1wt.eu> (Willy Tarreau's message of
 "Mon, 12 Mar 2012 19:45:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0DD4DAC-6C79-11E1-A2AE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192930>

Willy Tarreau <w@1wt.eu> writes:

> Rest assured that I don't feel comfortable on 1.7.9 either, that's a big
> jump for me but I know that most often it works quite well :-)

It being a big jump is not a problem I can solve, as it is up to you
to deliberately stay behind until you decide to make a big jump.

I can indirectly solve it by not backporting as many fixes to the
maintenance tracks, but I am too nice to be playing that nasty ;-).
