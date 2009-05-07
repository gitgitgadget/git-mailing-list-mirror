From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 7 May 2009 11:02:58 +0200
Message-ID: <20090507090258.GC13123@vidovic>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de> <7vws8te2ht.fsf@alter.siamese.dyndns.org> <op.utjw1pa71e62zd@merlin.emma.line.org> <20090507085419.GB13123@vidovic> <op.utjxrofj1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 11:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zVb-0005cj-Ab
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbZEGJDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZEGJDF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:03:05 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:57823 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZEGJDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 05:03:03 -0400
Received: by ewy24 with SMTP id 24so875846ewy.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RuqX2Ojw5Jh0S+7KrYUtvhv/G1Fp5Ya+9kqIe40doaQ=;
        b=JeBwrJM4VYf8o16K6uQOLDJk+ctfXDJII0OfGBFyxnKs0XUIG8ywo4Ep7vyQZs27BC
         5p93SY7cwGorVS9ilxl4Zb6JbBaCngWL6IUO2RyC/PsEJiCQBS+4QIDY0ohIoKuil9wE
         45wy+2HT+G6Gdk3EmqKWuhuk6NRUmGVvi0rwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DhOwIMo+D/0DBhk9SfVCigIXhPSUjmOhtY2Q5KH6FFLvNI9PYq6EV7VjznKagUm1uT
         vuyvamjOeTbZ2uMZP2hT4qDHYD12xKsvtmtsfpgdRuwjjQ7NJm8oqEQPuQj9XhAvJKqJ
         OXBtxdmH+rn48vPb8pFXriGsdVYdcmiJw5Fmw=
Received: by 10.216.1.81 with SMTP id 59mr1075550wec.155.1241686982411;
        Thu, 07 May 2009 02:03:02 -0700 (PDT)
Received: from @ (88-121-119-92.rev.libertysurf.net [88.121.119.92])
        by mx.google.com with ESMTPS id t2sm5998057gve.12.2009.05.07.02.03.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 02:03:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <op.utjxrofj1e62zd@merlin.emma.line.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118453>

The 07/05/09, Matthias Andree wrote:
> Am 07.05.2009, 10:54 Uhr, schrieb Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:
>
> > This is a configuration option that the sysadmin has to set (see
> > env_keep in man sudoers (5) or http://linux.die.net/man/5/sudoers).
>
> Salut Nicolas,
>
> I'm aware of that.
>
> > I don't see any good reason to bypass this behaviour since it is what
> > sysadmins expect.
>
> Are you agreeing or objecting?

Objecting. By "this behaviour" I meant "the fact that sudo strips
environment variables".

-- 
Nicolas Sebrecht
