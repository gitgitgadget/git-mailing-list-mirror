From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 19:59:41 -0400
Message-ID: <9e4733910708021659y6e9bb7ddk58817b4de3df26a0@mail.gmail.com>
References: <46AFCF3E.5010805@alum.mit.edu>
	 <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
	 <46B2132D.7090304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGka1-0005zN-Ko
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbXHBX7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756856AbXHBX7n
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:59:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:33154 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319AbXHBX7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:59:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so538035rvb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:59:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NzxtlYz26MWNhJ7uuZlAj0krB3I4nfm4h2xZrZuA40D15DrcDtMVrAArR9obqU/249RmRKALo1LO3nl+8cBwKp5+Sd9ccpD7+viWET0fSXF/6n29Tqgksa1iwGv4Hi8jDj2pRXWKFqm2mNZv1wy7CReG0jLOTA05nPxVC1x2Xos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odFgohpdQKYNfEljZq2YSeVLOkNRsGOmDgVMUPwi1rV4r5FP8GdSf/ixdELvPCmkn1ZbYowYkS8wakGsJy4DDqo99VlcHMcWC09Hqh6mFkZkDDykOGNyk6JxGh2cVF3Cp7JNTyEO+83IYf4tIH2AFRC3FeEWkC2r/h0xMZpmfVw=
Received: by 10.115.75.1 with SMTP id c1mr2366482wal.1186099181748;
        Thu, 02 Aug 2007 16:59:41 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 2 Aug 2007 16:59:41 -0700 (PDT)
In-Reply-To: <46B2132D.7090304@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54650>

On 8/2/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Branches with names like "unlabeled-1.1.1" come from CVS branches for
> which the revisions are still contained in the RCS files but for which
> the branch name has been deleted.  These wreak havoc on cvs2svn's
> attempt to find simple branch sources and cause a proliferation of
> basically useless branches.  The main problem is that cvs2svn does not
> attempt to figure out that "unlabeled-1.2.4" in one file might be the
> same as "unlabeled-1.2.6" in another etc.

I seem to recall discussing an algorithm  to fix this on the cvs2svn
mailing list. There was a somewhat simple way to correlate the
"unlabeled-1.2.4" in one file might be the same as "unlabeled-1.2.6"
problem.

-- 
Jon Smirl
jonsmirl@gmail.com
