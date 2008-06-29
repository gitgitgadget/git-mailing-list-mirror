From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and add strbuf_initf()
Date: Sun, 29 Jun 2008 22:30:11 +0200
Message-ID: <bd6139dc0806291330xcb910beo757e447702ccc668@mail.gmail.com>
References: <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
	 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
	 <cover.1214581610.git.vmiklos@frugalware.org>
	 <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
	 <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0806281832510.9925@racer>
	 <7vskuwek9w.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0806291436520.9925@racer>
	 <20080629201757.GA27370@steel.home>
	 <7vvdzs7zwx.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	"Olivier Marin" <dkr@freesurf.fr>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3YE-00056w-PE
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759889AbYF2UaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759631AbYF2UaN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:30:13 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:1824 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbYF2UaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:30:12 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1226341wfd.4
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VRLeTpT0DdeoXgEAiA/b7lO6TDML32KfoXjcKb8WeL8=;
        b=UOfGQGpgP9EvsSX/V+sC5bhQk0UB1xbAwAtx6cI5eF7t6PHfxKppZGvP/TydzBjPI1
         7nHzHmEZ+83hsE/I5Rqqf9D71k9oRAnOBSj3vyPslIaAWjIuAAfj/3aKxAJkPzMDXDrr
         TUXfJScBsCh67cC8JTYebvhxdhtesvfw2y2d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=GSrT5/SqGKv19nVqy9jlnUQyRoHulRjw0Dv88cC698QI7fI+bWPSpNDNvfc7PYLM3O
         XSSd862yzkASnT3mY2rXqnXKqyNqUnw/xWqMsaHYOhS6VRWEUEgBlmhRqNzNToInum1g
         nH39o2tyWmDdHz+OFoLK91bkA8Lr3uQVyrAuo=
Received: by 10.142.72.4 with SMTP id u4mr1517276wfa.269.1214771411571;
        Sun, 29 Jun 2008 13:30:11 -0700 (PDT)
Received: by 10.143.29.11 with HTTP; Sun, 29 Jun 2008 13:30:11 -0700 (PDT)
In-Reply-To: <7vvdzs7zwx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86830>

On Sun, Jun 29, 2008 at 10:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Heh, he hasn't _yet_.  I said "next time" didn't I?

Now you sound like the bad guy from "Inspector Gadget" :P. "Next time
Dscho, next time!!!"

-- 
Cheers,

Sverre Rabbelier
