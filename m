From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 0/2] Re: cosmetic improvements for "git show tag"
Date: Sat, 18 Jul 2009 03:10:06 +0200
Message-ID: <20090718011006.GB12968@vidovic>
References: <20090717231622.GA13511@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 03:10:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRyRP-0005u1-QI
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 03:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbZGRBKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 21:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbZGRBKM
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 21:10:12 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:38897 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbZGRBKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 21:10:11 -0400
Received: by ewy26 with SMTP id 26so1247145ewy.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/XSSvV2nXbnHjBkY+YKMH411vVQs8BJKSFKUVlUuh/s=;
        b=NETU+yzQ23jwQ8VN3NJ6t0AofTK7WqjXrGRSiytjV164wPQ4cYwVM/1fT08fpJwGFR
         QrEjBlkDwi2q6gSsrQvMDeakY+T3XoUmYcAIPxeOchnq142xx+wIS2bw2DSu6AsEcECa
         cCwq9at4LIrArEDqBF3iYhaeRUBGLn593oeO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XIqPIsaxJTPofFwNnO+yFYJT0r8BQlxiD99ncABd5akIqv+zMiBpZylSWEB8N8DRG0
         /b3iWoEt5XvhZ0G+aMD9l054WIy/7wXygHlEy8B1VSYBC3SKsvpvBLM3oI1IXYqzXVmc
         c5jBrWdWC2Gx0ZRDQ/UzK7OQmx2jtp7R5GnEQ=
Received: by 10.210.63.2 with SMTP id l2mr2133465eba.20.1247879409943;
        Fri, 17 Jul 2009 18:10:09 -0700 (PDT)
Received: from @ (91-164-145-221.rev.libertysurf.net [91.164.145.221])
        by mx.google.com with ESMTPS id 24sm4370441eyx.53.2009.07.17.18.10.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 18:10:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090717231622.GA13511@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123500>

The 17/07/09, Jeff King wrote:

>                                   These two one-liner patches improve
> the output to:
> 
>     tag foo
>     Tagger: Jeff King <peff@peff.net>
>     Date:   Fri Jul 17 19:10:54 2009 -0400
> 
>     annotated tag message
> 
>     commit 88c17f18d7f3091508218b36a17cdf0dfd56ae65
>     Author: Jeff King <peff@peff.net>
>     Date:   Fri Jul 17 19:10:50 2009 -0400
> 
>         commit message
> 
>     diff ...
> 
> which I find much more readable. 

Nice. What about adding an extra newline between tags?

  $ git tag v1.6.1 v1.6.2

	<snip>

  +  link:RelNotes-1.6.1.txt[1.6.1].
  +
   * link:v1.6.0.6/git.html[documentation for release 1.6.0.6]
   
   * release notes for
  tag v1.6.2
  Tagger: Junio C Hamano <gitster@pobox.com>
  Date:   Tue Mar 3 23:37:25 2009 -0800

  <snip>

IOW, between " * release notes for" and "tag v1.6.2" here.

-- 
Nicolas Sebrecht
