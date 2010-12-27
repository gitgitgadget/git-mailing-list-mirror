From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Mon, 27 Dec 2010 16:38:43 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012271630560.788@debian>
References: <20101211005144.GA6634@burratino> <20101227212515.GA32352@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 22:38:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXKlW-00065y-6p
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 22:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0L0Vh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 16:37:56 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64586 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0L0Vh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 16:37:56 -0500
Received: by qwa26 with SMTP id 26so8828144qwa.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=VbzYiT2cH0SI4A68/7Dndcycr20JTFO+Qp5djxWey2U=;
        b=uwvTSNz1IrYt9opLKKyVW6qH/OV6428SHn4Bj3ajwqb9RqyhFOButFZn46ZM1J1ZpK
         xkFmTUSFqAtf0TBmYx4EG7vwc92uEEqPJMhcpohIRhWmgCTQDoheTlft005zpx2lujBE
         u+xjANkk0xFrATPNBg3gFGBhsDVH9xuS1nVUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=dBvZXkpekYBjv5YoWdRO+5aD/ed6Vxbi0vJg7ewUT1AX9A4mA7YDjspe+j9CCrynxk
         VmEV3OFxD7AtvCma1S+smZEw3vkjl7g5WjVMFlJMTHXMIFT2+BeZo/rwDWE+ol4ZIv4P
         tXIQFWzasUEBxsde1FiyYPtdmBe1SC3+cdrj4=
Received: by 10.229.241.196 with SMTP id lf4mr11032439qcb.284.1293485875382;
        Mon, 27 Dec 2010 13:37:55 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e29sm7217797qck.39.2010.12.27.13.37.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 13:37:54 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20101227212515.GA32352@burratino>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164225>

On Mon, 27 Dec 2010, Jonathan Nieder wrote:

> Jonathan Nieder wrote:
> 
> > For example, this would allow cherry-picking or reverting patches from
> > a piece of history with a different end-of-line style, like so:
> > 
> > 	$ git revert -Xrenormalize old-problematic-commit
> > 
> > Currently that is possible with manual use of merge-recursive but the
> > cherry-pick/revert porcelain does not expose the functionality.
> > 
> > While at it, document the existing support for --strategy.
> > 
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
> > Thoughts?
> 
> Ping?  I use this with -Xpatience fairly often.  Am I the only one who
> has wanted such a thing?

FWIW, I have wanted it for the end-of-line scenario you describe
above.

/Martin
