From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 21:23:11 -0500
Message-ID: <474F740F.1000008@gmail.com>
References: <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <alpine.LFD.0.99999.0711291950590.9605@xanadu.home> <20071130010055.GB12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292013580.9605@xanadu.home> <20071130012536.GA12615@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292029420.9605@xanadu.home> <20071130015315.GA13369@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxvXV-0003zq-8o
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497AbXK3CXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbXK3CXR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:23:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:33635 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbXK3CXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:23:16 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1821684wra
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=3OuTeflFPEd4XZOjOJ3olQoPM1VPgLJse01BYg//OH0=;
        b=uvZAtXPGLaXoIE7layAkekXHweKGC8wwAvofQ626Tup0QQAo6aEIY5XrvN/mbRcspwLXAauX9nEiginPBcvmFOPyffk6yJctoLQwnkHszN6rtu+nWqCp2EE6NMP83iswqVH4XCM1302kQ1YPXKfwVNfbquzYRRVRNsxB5Is2Gnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hlMGdd8eN2GUKCNP/6/wqQ6HtJ9/m0QkQZ8a0Pwha/aVfmJYAXYjBRVrBXRvFwyfWHsaEj9rO44jX3aZJT3nYjtTeHaDyIcVJxhd/O6UMaE660NIjRgppuu6vIENImMECFCUOgBBbjt2A+QhThR5NZZHkWs/6U0mXcv/f9Ahcoo=
Received: by 10.100.171.10 with SMTP id t10mr13071785ane.1196389395775;
        Thu, 29 Nov 2007 18:23:15 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id g3sm3608099wra.2007.11.29.18.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 18:23:14 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20071130015315.GA13369@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66605>

Jeff King wrote:
> On Thu, Nov 29, 2007 at 08:33:39PM -0500, Nicolas Pitre wrote:
> 
>> So what you want is for the dashed hardlinks to exist _inside_ the 
>> libexec directory, even if most people won't "see" them due to that 
>> libexec directory not being in the shell path, right?
>>
>> If that is what you mean then I personally don't care at all.
> 
> That is exactly what I mean.

And that also works for me when I set libexec=$(bindir).
