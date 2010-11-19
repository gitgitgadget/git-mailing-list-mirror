From: Junio C Hamano <gitster@pobox.com>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 14:58:06 -0800
Message-ID: <7v62vsc45d.fsf@alter.siamese.dyndns.org>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
 <20101119175424.GA13276@sigill.intra.peff.net>
 <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
 <20101119204010.GA18342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Andi Kleen <andi@firstfloor.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 23:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJZuW-0002VJ-D1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 23:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab0KSW6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 17:58:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab0KSW6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 17:58:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A959B2BB4;
	Fri, 19 Nov 2010 17:58:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58kVzPWvTUpoeQESvZ4KOOssgbo=; b=iEueka
	yvTuf1DOLZv30mboAxtXeMwL/0e/cllYlNCUeB6zjzxO38neFz+cjkq7jUzi7I72
	Yk8P6N5Iao6DLZnlkaBOqEf2odmhgfoUmfwAt/PGwYfZ6Xs62HeDIz4Km0hdIT3D
	6pRenfTAz5GHWKOzpe996aNnc/+sMCoLxF+ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzpoN4qpkQF/o7zV7UifHPu3jHp69Tiw
	JKHoE4amgErsgEdEgXu60x9UN7nXgMjM7kwZfcX3Lz0MvbKQO4MJBYNBSMs+I3Km
	dPY7V4Lfw3mz3kvFxD8InyacFWEf9GvBQ/Tm6ojHSWpO4201+fhatJ067+cbGfrb
	bVGLWuS5obk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4ABE22BB3;
	Fri, 19 Nov 2010 17:58:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8439E2BB1; Fri, 19 Nov 2010
 17:58:19 -0500 (EST)
In-Reply-To: <20101119204010.GA18342@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 19 Nov 2010 15\:40\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8513AF66-F430-11DF-ACC1-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161796>

Jeff King <peff@peff.net> writes:

> I think the updated XSL files are what's making it work. The stock
> docbook xsl files are:
>
>   $ yum list | grep docbook-style-xsl
>   docbook-style-xsl.noarch   1.69.1-5.1 rhel-x86_64-server-5
>
> and I don't know that we can assume anyone has updated them. However, I
> don't actually build git on my RHEL machines, so I could might be wrong.
>
> All that being said, I am willing to accept RHEL5 as collateral damage
> if the new defaults Just Work for the majority of other platforms.

Thanks.  I usually am fairly cautious when changing the default, but I
think this particular one is not such a big deal.  I agree that the end of
the year release would probably be a good time to switch.

I think people on RHEL5 would also be ok; they have paid support for this
kind of thing, no ;-)?
