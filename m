From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Fri, 04 Dec 2009 09:10:18 -0800
Message-ID: <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org> <m2r5rb9hes.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbfz-0007Aa-0r
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbZLDRK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbZLDRK1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:10:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZLDRK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:10:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 786DA85AF1;
	Fri,  4 Dec 2009 12:10:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1wV3EQeWikv5LKwLOHDUfXbRYEI=; b=hyJBQ0
	FTb4WaedJ4Ui+uJ8rgDIiYZ1KHcWEdPLGIi7dkoIBdjeR5ex5DaaZWZ90uZ6qUhv
	ttnLpgx/IoVb6Xe+GhPY8PIkpFeC1NBjRbzyfGBFldiVutsWiICc3sqIWg1qzLGx
	DeW1kSlwzJQslgNaQJQEFDXqrLkY5mVg29GP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Egk1Sl04yICCJyd7Ue/wHP1YXTp8fC7Z
	wc+0xuWhrUSTvbWTXSocYrwXuy+Rb+EDtYveL49APsXQE2ZS65mwYmWb0AZblY0Q
	eLZVTp0j0xpsqmteO8a28gNeR/5yJqVNTXb4D4cjsxEjwkv8Z6joHQiaw/sYLiQt
	UOdgxPFT2kY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22E3B85AF0;
	Fri,  4 Dec 2009 12:10:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41DD485AEB; Fri,  4 Dec
 2009 12:10:20 -0500 (EST)
In-Reply-To: <m2r5rb9hes.fsf@igel.home> (Andreas Schwab's message of "Fri\,
 04 Dec 2009 11\:12\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EAF47394-E0F7-11DE-B9EC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134549>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think it depends on the likelihood that a distro has xmlto so old that
>> it does not understand --stringparam yet it uses stylesheet so new that
>> setting the parameter makes a positive difference (either it gives the
>> full URL or at least squelches the "You should define the parameter"
>> noise) in the output.
>
> openSUSE 11.2, for example.  Its xmlto has a non-standard --xsltopts
> option that passes its argument down to xsltproc.

Ok, as I said that I've been wrong before in this area ;-)

I don't think I will have much time for git today, and it would be
appreciated if somebody can work on this and send a tested patch that
applies cleanly on top of 'maint' to implement the @@MAN_BASE_URL@@
replacement from manpage-base.xsl.in to manpage-base.xsl as Todd suggested
earlier.
