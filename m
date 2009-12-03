From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 14:30:41 -0800
Message-ID: <7vbpif4rn2.fsf@alter.siamese.dyndns.org>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 23:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGKCc-00069A-6a
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 23:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbZLCWav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 17:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbZLCWav
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 17:30:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZLCWat (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 17:30:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C6A0A3D29;
	Thu,  3 Dec 2009 17:30:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+UlWvew28rCu/zIgRGfqPnl8+Q=; b=jhzMAY
	MK7y/Soj8ky4J5nfOStbNiD97SGDEPO+HK6oxf+PxeWbzDgg4WAx1LBJvTqK37rS
	w8aKTM4whWEoCB5Ygf54dxwnzRvzfd5tb9AV2YCOHimayeWMrjUKMu6DKFyp48NM
	6ThSGQpgyWAOhK7K/c/01EZF2eWjcjy3maSQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EcrvjDno/Ig0uj7dQkqXk+S3tbu81fg7
	EzONs52+pS4vTA3pQH6WUM6oVxHtI9NdZQRRbtNPwSOo1376K3YuqFFOg+qoPNzS
	K8iSwP8rSdUWIPc1+FhrchlUpL8cWQZYu5E7vW5MndaDr6oQDH7QO0GFpMc2wedq
	SZ7WF9iR7FY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C55EA3D28;
	Thu,  3 Dec 2009 17:30:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7104AA3D27; Thu,  3 Dec 2009
 17:30:43 -0500 (EST)
In-Reply-To: <20091203220020.GS23717@inocybe.localdomain> (Todd Zullinger's
 message of "Thu\, 3 Dec 2009 17\:00\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81AEEE38-E05B-11DE-AD0E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134480>

Todd Zullinger <tmz@pobox.com> writes:

> I tested with this in Documentation/manpage-base.xsl on a CentOS 5 box
> and it builds fine, leaving no cruft in the man pages regarding the
> man.base.url...
>
> <!-- set a base URL for relative links -->
> <xsl:param name="man.base.url.for.relative.links"
>        >/path/to/git/docs</xsl:param>
>
> Of course, the relative links looked just like they did in older
> docbook releases:
>
>        1. Everyday Git
>           everyday.html
>
> Is it worth the effort to have @@MAN_BASE_URL@@ in
> Documentation/manpage-base.xsl or similar and replace it at build
> time?

I think it depends on the likelihood that a distro has xmlto so old that
it does not understand --stringparam yet it uses stylesheet so new that
setting the parameter makes a positive difference (either it gives the
full URL or at least squelches the "You should define the parameter"
noise) in the output.

I am guessing that the answer would be that is a very unlikely combination
and not worth worrying about it, but I've been wrong before in this exact
area ;-)
