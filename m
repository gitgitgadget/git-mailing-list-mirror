From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 20:50:49 -0700
Message-ID: <7vbou4uhuu.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org> <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
 <20110929015919.GL19250@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Olsen\, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 05:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R97eC-000213-TB
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 05:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab1I2Duw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 23:50:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab1I2Duw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 23:50:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 932715ECE;
	Wed, 28 Sep 2011 23:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+M9SyOc1zYf5D+KyVEvS89uQYtI=; b=xp0d6W
	AFcDLU1iTNKN2iV1TMRXMpb1YMvadzh2FTh6zq7miqRp0FVPZp5SnOiQSZziJqa8
	x/107+glXAyGgYssVNpJsrRnVdGIWzLxIGRsKS49XK98DR35fIpW0Sz9a3NmW9/W
	F0xUMXtd0ppR1oSJQGlNFTWLnfQKrhTVzEgkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PcRea+fuB/Dy1LUhbc51XzMu7zPvV1nw
	NrbxkWYRc3nF22gFlEsbdJZhmE0Owlnbb7X2LcX49jNLwcAY9eZ5ki9n/Qjgj3yz
	9FmZpcJ1nV6ztpcke7NiswN91GkPX3FL9bsx+RrFqXxxb4nq4bCd4AEPtvIs1rlj
	i7u3BTufOro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85F8C5ECD;
	Wed, 28 Sep 2011 23:50:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB4DE5ECC; Wed, 28 Sep 2011
 23:50:50 -0400 (EDT)
In-Reply-To: <20110929015919.GL19250@thunk.org> (Ted Ts'o's message of "Wed,
 28 Sep 2011 21:59:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 392CB42A-EA4E-11E0-81E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182385>

Ted Ts'o <tytso@mit.edu> writes:

>> That would improve the situation (I suspect that there
>> were some people who misunderstood that these GPG signature were to
>> protect against break-in at the master machine), but at the same time, it
>> may create the chicken-and-egg bootstrapping problem if public keys of too
>> many people need to be published securely.
>
> We are in the process of bootstrapping a GPG web of trust.  Linus has
> generated a new GPG key which has been signed by Peter Anvin, Dirk,
> and myself.  We'll get a much richer set of cross signatures at the
> Kernel Summit in Prague in a few months.

I was actually more worried about helping consumers convince themselves
that thusly signed keys indeed belong to producers like Linus, Peter,
etc. There are those who worry that DNS record to code.google.com/ for
them may point at an evil place to give them rogue download material.
"Here are the keys you can verify our trees with" message on the mailing
list, even with the message is signed with GPG, would not be satisfactory
to them.
