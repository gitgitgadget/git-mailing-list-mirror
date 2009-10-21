From: Patrick Schoenfeld <schoenfeld@debian.org>
Subject: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 15:37:03 +0200
Message-ID: <20091021133702.GA470@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 15:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bTX-0002Tu-BL
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZJUNn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbZJUNn2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:43:28 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47366 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZJUNn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:43:27 -0400
Received: by fxm18 with SMTP id 18so7766182fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=WHOdBOojrLOaCFux5bOYdMTitf8fP3Xvd0CooU7R7G0=;
        b=ov1p/EPFiWZAOs1+Hd+QKpvcP5JQAHCXnBF4BqOW8XTDTugzPMJb9et4255xEaXN+F
         5W7b1igzeFrxSP9Rj14LVB743Ol4GaWDWQvRY2+yVAwBRf+ThL2g1NkdrRMzLLRnbhCK
         6OOjCOnd4n3iRyQ8gfGF3IO+5xRsA+LtQgWfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=s1QI9wolQ0aTFaCMyYcypdXvaJh/wuWjXhendovsW5Omn5slKmgiSNTonm3Hr0i2fL
         eqop8iCks75Yk5mbJC1aDKA61nq+VrzRdofUT/CWC1kKj8LWyUQi6k6P2rGCnvIeQhlY
         OvfvLCI6hiEG92AVIQMwz/8WUHM7Icr+H5Tl0=
Received: by 10.204.148.69 with SMTP id o5mr8038725bkv.99.1256132229814;
        Wed, 21 Oct 2009 06:37:09 -0700 (PDT)
Received: from lisa (exit.credativ.com [87.139.82.80])
        by mx.google.com with ESMTPS id 13sm289089bwz.10.2009.10.21.06.37.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 06:37:09 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130917>

Hi,

I regulary work with various branches, that I call by the number
of an associated bug tracking / support tracking number. That
makes it clear to which ticket a given branch belongs.
In this case I would find it very useful, if I could associate
short comments with a branch, which would be shown when
doing a 'git branch'. This way I could see what this branch
about, without looking up the ticket information.

Obvious the workaround is to name the branches different,
but this is sometimes not convenient and may result in quiet
long branch names.

What do others think about this? Would this be useful
for others, too?

Best Regards,
Patrick
