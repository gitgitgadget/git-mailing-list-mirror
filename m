From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Wed, 2 May 2007 00:27:41 +0200
Message-ID: <200705020027.41316.jnareb@gmail.com>
References: <200704300120.42576.jnareb@gmail.com> <alpine.LFD.0.98.0705010829180.3808@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 02 00:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0ks-0002iD-8S
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbXEAWX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXEAWX1
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:23:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:33748 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXEAWX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:23:26 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2045910wra
        for <git@vger.kernel.org>; Tue, 01 May 2007 15:23:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DxeiDjf1LC6GZZL8Kd07nIe63UuuGNjNgEqg26LvJBpIodP/WsgzZFmtmoHySIARKJp6WZDlkhymlpEktJaWDqiW2rABIwDiCs4aKGghsT/jo7tcAgfWKPS41wKq1rLaA7neNuY6RbBN5YL6FWLqx9KEo1OInjh1W2+CrQ47hbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pQAwBNSU9jknQvk7A35ADjmhOjoJr9Q+h6q/Dj4A8k0HN37uUy5yS65dx7BBhQE+bZYKRqvSAhCeyibX56dz2916czz59cpJ+CcuVgk4EClm9snQZ23cLDJo+bzHY0rVXIyo24+QuEaR/DeydppHIidKqv2mjXaf4WBX+TWsR58=
Received: by 10.78.183.8 with SMTP id g8mr1323207huf.1178058205217;
        Tue, 01 May 2007 15:23:25 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y1sm36930uge.2007.05.01.15.23.23;
        Tue, 01 May 2007 15:23:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.98.0705010829180.3808@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45986>

Linus Torvalds wrote:

> And the nice thing about this is that if some subsystem needs to make 
> trivial changes to another subsystem, they don't need to ask for 
> permission. They just do them, AND THEN THEY EXPLAIN THEM! And if they 
> really were trivial and obvious (and that's almost always the case), they 
> just get pulled normally. No special dispensation.

Actually Karl Fogel wrote in "Producting Open Source Software" that he
recommends and uses 'soft' partial commit access; it means that committing
is restricted to a part of project for some by a guideline, but is not
enforced by the tool (by SCM).

P.S. I recommend actually reading the book (at http://producingoss.com)
instead of relying on my understanding of it.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
