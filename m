From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 11:55:54 -0800
Message-ID: <7v1v37kb3p.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
 <20110216100622.GA12971@sigill.intra.peff.net>
 <7vpqqrke30.fsf@alter.siamese.dyndns.org>
 <20110216193643.GB22045@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:56:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnTz-0002qc-Lx
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab1BPT4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 14:56:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1BPT4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 14:56:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1EAD53892;
	Wed, 16 Feb 2011 14:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OvG1wL3R16KOEkJSDc3eeo+BJE4=; b=F6hic+
	dQCdjHlCtL2SSUtxJm7LHejkzstGMGYB/4al8Y2tb4CEoRhNQEvpYdxFgNo/raMK
	Dv6cQIm3KjGCOXtxpCNLyJm+FNxW+3uISaO0SdBQLwA/3lWprU94DxZ8TXfXyqor
	O7BYAIDy6eW4ygnk0VBXM4YgQynQjAeP97bI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UXnW/f/fuGkYmA1cdeAef1dFD5YR9r1M
	8cEIpr4pmxaCIkT8UqpluTIFZATLVNUjU+5a+nHG6jZdrD7oqveJVNQaeRMZG5iS
	07WUkaobuFOMGZ19TcKf1TBTvqphhwkrsP1uHrEGeR6X4lsStzv280+DFLYO/b9b
	aqrB/UjMI/w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C34073891;
	Wed, 16 Feb 2011 14:57:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C9946388D; Wed, 16 Feb 2011
 14:57:01 -0500 (EST)
In-Reply-To: <20110216193643.GB22045@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 16 Feb 2011 14\:36\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFBDD226-3A06-11E0-8673-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166995>

Jeff King <peff@peff.net> writes:

> But as I said, I am not against a config option if it is such a common
> problem. I certainly would not turn it on. And I don't think it should
> be on by default.

I think we are pretty much on the same page, except that I am not very
interested in the index-log either.
