From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 20:09:58 +0200
Message-ID: <20071011180958.GA2804@steel.home>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig2U9-0005e6-Cn
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 20:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbXJKSKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 14:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXJKSKB
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 14:10:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:45619 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbXJKSKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 14:10:00 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo13) (RZmta 13.4)
	with ESMTP id y00b7cj9BHMmi0 ; Thu, 11 Oct 2007 20:09:58 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 592C9277AE;
	Thu, 11 Oct 2007 20:09:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id EED81C50A; Thu, 11 Oct 2007 20:09:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60620>

Oliver Kullmann, Thu, Oct 11, 2007 17:59:56 +0200:
> Better than just the date, it would be greatest to be able to put also
> the SHA1-ID of the commit into the file, alas this is a bit complicated,

actually, it is quite simple: just (re)generate a file which you can
compile and link to your executable. That is how gits version work:

    $ git version
    git version 1.5.3.4.229.ga321c1

this ga321c1 is the commit (no one knows what the "g" stands for, but
the rest is plain value of HEAD at the moment of compilation).

Put the generated string in your image in a greppable/identable form
and you are set: the commit identifies uniquely the whole build tree
(assuming your build tree _can_ be identified. It not given for most
commercial projects I am familiar with).
