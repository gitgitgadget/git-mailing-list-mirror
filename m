From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: use compat regex on Solaris
Date: Wed, 17 Jun 2009 14:55:40 +0100
Message-ID: <e2b179460906170655t6ae0f188t88a01cc14bc79135@mail.gmail.com>
References: <20090616190550.GA22905@coredump.intra.peff.net>
	 <20090616190821.GB23197@coredump.intra.peff.net>
	 <e2b179460906170615u46a71241wf012d98020ef91e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGvcN-0001a1-34
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214AbZFQNzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbZFQNzk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:55:40 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34211 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbZFQNzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 09:55:39 -0400
Received: by bwz9 with SMTP id 9so341067bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a+KCiiwjtugy8c+qQ0NFJTrTi5bZVByqEIzVnQGDg9Y=;
        b=pyEmenrReeOfsIVLqAzBg8KWunKwye0xgliD9Cpaq5MIYP2Cfu48mzbdZQOgzvp1zI
         x1Dp0Sx1xNpwrX5nA9GigmbQ9PK5ipid1N4ftsGeJMjY/H9gtHoD3xbp93khkyqv1Mj1
         nC10NOpGAvFaC+DziKa+SXFC61BCR9Mg4GLBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=egCEBo71AyPkxbxSLwpaHblY4P5TxxD0J+ZMySvGciSEdFvfRUEcoPwIwluwGmsJ0k
         t6E9Q5DB4EBIqpPlf/j7n7ITmYcVZGBU3rfLJt6yXEmtvf0kd0/GFjtdu6aA0yo8zpSL
         RNGVmrHHJ8g+j8q+29FZnPD3QI9q/hx6rGdxY=
Received: by 10.223.105.72 with SMTP id s8mr297383fao.9.1245246940088; Wed, 17 
	Jun 2009 06:55:40 -0700 (PDT)
In-Reply-To: <e2b179460906170615u46a71241wf012d98020ef91e0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121746>

2009/6/17 Mike Ralphson <mike.ralphson@gmail.com>:
> Also required on AIX (5.3).

Scratch that, sorry - I hadn't seen the related thread (git diff looping?)

Paolo's fix is the only one required for AIX.

Sorry for the noise.

Mike
