From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 18:18:50 -0500
Message-ID: <b4087cc50904241618g5f1bed21m47f0e4bd1d0ca7ff@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <20090424231436.GA15058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUgy-0007yH-Ol
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZDXXSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbZDXXSv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:18:51 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:56242 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZDXXSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:18:51 -0400
Received: by qyk16 with SMTP id 16so2737852qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=03rms8O1ARr5aiQpyUoVdjWh8zkJDl1Cc7BBHKJzg68=;
        b=A34ktOCc6GHGoy9x1i99VPyifYuLzo5qbCdv1UNfCBjMK+IJ8JgLWm024ElAIeYd1R
         zHZXyIQC0UexEbkN7xesPt0vV1ScpOP4Q4oh7gMdOLHRkDD6WkHp0+eqQdRCnd9hP4m3
         hnmJTN+IzKt53IlsbN4FPWaeSpMPUSADLYM5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wigtChh2fyEiAXV0fdl8VecyzUkrzBUhase1Acq85II/US7G4livRX4TJc+Pww9RpI
         PBNaanDVxVMfV/WVA5KAsD+B28a17/78qTcY4cbIy3GBMdj7RG/mijnYGLuegVDh4j8i
         mOcixED3awmTi8poXHhgyRLWm1Ij+JvBTsOv8=
Received: by 10.224.80.148 with SMTP id t20mr3574274qak.349.1240615130504; 
	Fri, 24 Apr 2009 16:18:50 -0700 (PDT)
In-Reply-To: <20090424231436.GA15058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117514>

On Fri, Apr 24, 2009 at 18:14, Jeff King <peff@peff.net> wrote:
> but aren't
> they generally reviled among the progrmaming populace as the most
> complex and error-prone part of learning to program?

And now you know why people struggle with git; as I said in a previous email:

    http://marc.info/?l=git&m=124022418313288&w=2

    I think that the human brain struggles with indirection.
    Consider that so many programmers have a hard time
    understanding pointers; no wonderso many people
    find git's underlying concepts boggling.

Of course, the difference here is that we're not asking people to do
memory management; we have garbage collection.
