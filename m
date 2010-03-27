From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 22:16:39 -0700
Message-ID: <7vvdci2vk8.fsf@alter.siamese.dyndns.org>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
 <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org>
 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
 <20100327013443.GE10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 06:17:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvOOT-0006UB-Au
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 06:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab0C0FRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 01:17:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0C0FRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 01:17:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EAE3A53ED;
	Sat, 27 Mar 2010 01:16:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V+GL/jkH7l76ftLGNHsACpW19jY=; b=xu/nFM
	oRyGFOEMOrwiWQpI+ue1pKvZDCC/iBM9YHSbArHHmr47tbh0JPioqIPKTaTiKKLZ
	FqLZga7a1gDf8+Ap3XpahRpftk9o3BFsEoM7oOGpuhrfbBeHcVN3PdmbD0Arp6j7
	75c8ADn0YJMz9H4fqL55aPdrda73M/zBvisgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAKcz1IM4LiV/pOSg/h7bV9jDqfw3ikz
	pabOD6iZLeuSpIMnkYNBADXWKZERLA7odIuDEX0J+ylP46jxtYERHXyevFbcQ8dE
	OEdNtvGFhH57zQXh1rLpViy1F3QcOP/B+xZ3wK0c2cZjR7u8B0y36W3RCUcvhOzM
	fxpe3Q6LSFI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3D0A53EB;
	Sat, 27 Mar 2010 01:16:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07F94A53EA; Sat, 27 Mar
 2010 01:16:40 -0400 (EDT)
In-Reply-To: <20100327013443.GE10910@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 26 Mar 2010 18\:34\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2AE6DFE-395F-11DF-83FE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143316>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> But GitHub's approach here seems to be "Meh, its fine, don't worry
> about it".
>
> Its *NOT* fine.  But Avery and Junio might disagree with me.  :-)

Did I ever say it is _fine_?  I thought I said "complain loudly".

That would at least give poor jgit users who have hit such a corrupted
object a chance to get a controlled notice and ask for help (and get an
insn to recover with filter-branch that appeared in this thread).
