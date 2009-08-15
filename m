From: John Tapsell <johnflux@gmail.com>
Subject: Re: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 21:12:58 +0100
Message-ID: <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
References: <4A85F270.20703@draigBrady.com>
	 <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPch-00034F-HT
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbZHOUM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZHOUM6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:12:58 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:35711 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZHOUM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 16:12:57 -0400
Received: by yxe5 with SMTP id 5so2727033yxe.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E/8uKXsVSGT5LWJYfjs0uDDHVz6onl4t9xpfO6TkJXI=;
        b=RpUvSmHhgOsYK7BKDV3pjibKSNhkjfYPpf0HjNJF0V+Ze+J11qb7OEBCYDNRczZvQu
         0exopyrar4xgFhlajFu9GXArRT9yQQehXnLHN7qdTeOtDfBWa707E7YlcPt2BKghQ0Nz
         Mz0wJaPdRorZ6st4wFL4RspWsh7DHKg7ab65c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AmNBq2YwdAzybJt9J9RsnO7kfedxy8b9LoqCMmuxkALiTXYTCQ2FVbwhkgM0DWT3Qp
         +smyrza/lr6q81jgvVOC7ZsbxO5aZHL+fHwzcnfTTYX96ejn7B4nxijGi4pseJVDtB1R
         NsL7WFrxmg2zYMm1MfNkj0KuePEn+PaaZ+304=
Received: by 10.151.92.9 with SMTP id u9mr3804687ybl.158.1250367178607; Sat, 
	15 Aug 2009 13:12:58 -0700 (PDT)
In-Reply-To: <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126023>

2009/8/15 Bryan Donlan <bdonlan@gmail.com>:
> coreutils is licensed under GPLv3, and git under GPLv2 (only), so
> you'd need permission from all contributors to the implementation in
> order to relicense under GPLv3. A quick grep of the history suggests
> these contributors to be:


X11 also requires a fast SHA1 implementation.  It uses this to check
if two pixmaps are the same.  So it would be really nice to relicense
under a liberal enough license that xorg can use it.

John
