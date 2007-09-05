From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 11:26:28 +0400
Message-ID: <20070905072628.GB4911@moonlight.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpZE-00058r-Vn
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXIEHot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbXIEHot
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:44:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1518 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbXIEHos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:44:48 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1655110nfh
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 00:44:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=miSj18i9jsghgjsLMJreyIBTv1iIXqc9Nho6fMSzj4InubBOjF0aKLJCCJDzWwsGMLJu50bZ49Dw04Xss1khUcmlEuC7f+JQJ67+rZ2DIm/1JkdNfvPnVnMj1MR4jT2BPlMlct++tuujKDC0h3bUrKlY4eaV9tzYf9/rW9+1XSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TD7bl20ESGIZ3s4GMaKqgSaziV3DEqI+d69rku3m6XEvYiObvfFXGxaWGETk/HNlUlgkmlDUW/R0bwHVSEpzjuDqMl7yf/spifflbSm0WgM4kcBBctvkeDUJ1HpCj6HgstDGT9sbpMY5XCgdGWWhZ/G9+SO4Cz/hOf68ngPg5Dc=
Received: by 10.78.176.20 with SMTP id y20mr4898107hue.1188978286075;
        Wed, 05 Sep 2007 00:44:46 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTPS id p30sm2206216hub.2007.09.05.00.44.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2007 00:44:42 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 875A53A8BD;
	Wed,  5 Sep 2007 11:26:35 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l857QSAX007494;
	Wed, 5 Sep 2007 11:26:28 +0400
Content-Disposition: inline
In-Reply-To: <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57678>

Hi!

On Wed, Sep 05, 2007 at 00:30:35 -0700, Junio C Hamano wrote:
> Perhaps _exiting_ "git-commit" and "git-fetch" before doing
> anything, when the repository has more than 5000 loose objects
> with a LOUD bang that instructs an immediate repack would be
> good?

This may break automation.  I run git-gc monthly via cron, but that
doesn't guarantee I won't get 5000 loose objects before that.  And I
agree that automatic run is annoying.  Perhaps simple BIG FAT WARNING
is the best after all.


-- 
   Tomash Brechko
