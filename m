From: git@drmicha.warpmail.net
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Thu, 25 Nov 2010 09:13:13 +0100
Message-ID: <4CEE1A99.8020001@drmicha.warpmail.net>
References: <m2oc9hkurl.fsf@gmail.com> <1290458128.29678.23.camel@drew-northup.unet.maine.edu> <m2k4k5ks0b.fsf@gmail.com> <1290461070.5468.5.camel@drew-northup.unet.maine.edu> <m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net> <1290517990.10366.17.camel@drew-northup.unet.maine.edu> <4CEBC8C9.4010905@drmicha.warpmail.net> <m2d3pwj8th.fsf@gmail.com> <1290532016.10892.40.camel@drew-northup.unet.maine.edu> <m2fwur7olt.fsf@gmail.com> <7v7hg2ttty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Francis Moreau <francis.moro@gmail.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLWzG-0005G1-87
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab0KYIPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:15:20 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56244 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241Ab0KYIPT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 03:15:19 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 23251693;
	Thu, 25 Nov 2010 03:15:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 25 Nov 2010 03:15:18 -0500
X-Sasl-enc: eiPi4zIXtxe2SRNtaC0MHFHFsq/myttt2FPxL/YOqvB5 1290672917
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 65FAD404CC2;
	Thu, 25 Nov 2010 03:15:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7v7hg2ttty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162106>

Junio C Hamano venit, vidit, dixit 24.11.2010 20:17:
> Francis Moreau <francis.moro@gmail.com> writes:
> 
>> Ok, I fixed the problem by reinstalling the following packages:
>>
>>     - docbook-style-xsl
>>     - docbook-dtds
>>
>> I suspect something went wrong during Fedora major updates, at least
>> that's the one I'm going to blame for now ;)
> 
> I vaguely recall that I saw a similar breakage due to broken xml catalog
> on the system when k.org updated a few years ago (not the recent move to
> FC13 but two updates before that one to FC9) and asked the sysadmin to
> reinstall docbook-dtds.
> 
> Is it still CANTFIX [*1*], I wonder?
> 
> [Reference]
> 
> *1* https://bugzilla.redhat.com/show_bug.cgi?id=454097
> 1

I've marked it NEXTRELEASE now since the fix is in the F10 package (the
report was against rawhide leading up to F10).

In that bug, the catalog ended up being empty for certain reasons, and
that effect has been fixed.

Here, it ended up being broken (half-written it seems), so it's similar
but different.

Francis: If you can reproduce this in any way then please file a Fedora
bug, or describe the procedure and I'll file a bug on your behalf.

Michael
