From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: pre-commit hook
Date: Sun, 22 Feb 2009 12:17:53 +0100
Message-ID: <fabb9a1e0902220317m3f241bf4y118c5dee4cf0c06b@mail.gmail.com>
References: <20090220091127.GA7415@b2j>
	 <7v63j5t6r3.fsf@gitster.siamese.dyndns.org>
	 <20090221035748.GC7409@b2j> <499FE579.1050700@drmicha.warpmail.net>
	 <20090222105838.GB8029@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 12:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbCMl-0000AX-T2
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 12:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZBVLR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 06:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZBVLRz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 06:17:55 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:64984 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZBVLRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 06:17:55 -0500
Received: by fxm11 with SMTP id 11so919284fxm.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1iBaz2KBzwa10A3urTtOqMeb61sWYKsLvKqPXzOFZX4=;
        b=SCmNisa/SFEslcRW1g10om6Z3P1hemEfdXP3PpORwbUfDRk3D1MsPkEOqGGuNaaF7e
         w6X9gp+j9itnxOCV6t2fg/3ukEMKLEKDNoGkBHFbB8ScR1dL5iBVwBqDm1o6NX7UJMRA
         pk6Zk7rWudUrZ1StYqSDHUV1l0Xr8e36OqUEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=CStdEAYOsG2dTVGEOMJXpJrnJ5KBp/jQmVQAJs1ok88fhJXHrzR+Z5qu/MWtg0ltSW
         Cr7ofvbw4g/DFPba2+RAC0a2eDqfaSbvQ36I+9jbhlp4sbGhWKf+CzxcXK93cE5cyQkk
         8aegr1KheGBw8v/fxO+40p56EyzStebwL+VwA=
Received: by 10.103.244.19 with SMTP id w19mr2749768mur.134.1235301473546; 
	Sun, 22 Feb 2009 03:17:53 -0800 (PST)
In-Reply-To: <20090222105838.GB8029@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110997>

2009/2/22 bill lam <cbill.lam@gmail.com>:
> I make and install with prefix=/usr/bin , however I can only find git
> inside /usr/bin; other git-???? are missing although they are built.
> "which git-rev-parse" return nothing but "git rev-parse" can work.
> Where are these git commands stored and how does the git locate them ?

Have a look at the output of `git --exec-path`.

-- 
Cheers,

Sverre Rabbelier
