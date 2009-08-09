From: Ryan Flynn <parseerror@gmail.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sun, 9 Aug 2009 19:16:38 -0400
Message-ID: <a3f15ee60908091616v3ce41374x873a0cf473d0bd3@mail.gmail.com>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
	 <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 01:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaHdC-0003bF-KE
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 01:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbZHIXQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbZHIXQi
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 19:16:38 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:64248 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZHIXQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 19:16:38 -0400
Received: by vws2 with SMTP id 2so2402314vws.4
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AfUOaPHVwuLdSq2xzmgFc8wvV+vPpD1SH1uU5POxZMk=;
        b=dEIu7yoW3x1qjw9+luauu5WS4pWjdDp7EwGgkYOcl/ce+zlggVccwLHOFISDTh4G8t
         3zk8apmrg0DgWmuw8HuInQj5X5PlhdsHMq/hzfjdS4byowZo8gtI4RBPKLWlbBO+C2Tb
         ubMZPNFQO+MC7D4p+epF33ticVg7JzSdPm4A0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FfEcHZBVgAFnnYfELvZuMCjovCK5jdkmKnHnhEbaNSoOcpZAHQ7x2GFB8fbo30s53Q
         IofocdbHRaKQ9xmwuvXOPQsEGbQSmqwd3kM5TExLce/Wnj9eLrWCxiLOIgwzlVUvVC6K
         x9Q4MpWZp2s7OgiM3lXO+EoYCB1Um4gx1+msU=
Received: by 10.220.91.213 with SMTP id o21mr3858463vcm.59.1249859798480; Sun, 
	09 Aug 2009 16:16:38 -0700 (PDT)
In-Reply-To: <7vy6pta4rd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125391>

> Perhaps we should get rid of this function altogether?

I was thinking of something like that, but figured i'd start small and
fix the bug first.
