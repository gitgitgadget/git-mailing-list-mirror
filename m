From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: git-p4 question
Date: Thu, 9 Aug 2007 21:53:37 -0500
Message-ID: <69b0c0350708091953wdc9c22vd2b17b1edd1c5cd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 04:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJKeC-0004iy-2D
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 04:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163AbXHJCyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 22:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbXHJCxp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 22:53:45 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:54105 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbXHJCxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 22:53:38 -0400
Received: by an-out-0708.google.com with SMTP id d31so130770and
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 19:53:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=USLF3pL/IBJXBh5phuqKmb/U7eMZ9NLP3OAkLiBmHq0RB7D6Jx5X+V2NFLRRnb10rOvdWZLwTGCJXpLoSAOGXhhwjuYoxgcHCOmQNp2/almYM42fzEQex1cFI/J66YmsOJQT5Gq3h59m2Zpd0AB2OUV0HYbDN2i0K42P/UXlo7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UwwsvlJ6pBY0MGljaxYPEFB/R/eRxk+DF4sGF3usnsCJ1igLPcrsVIW+yBYvDNfEMBIJNSOiZ0P8iFQJ9BjHp63loSH1S9/R9JiprCrHw6fIRaLisFnij04BzYzxCkiMp+r8PdQbERPxm1sz8vp5zu7XhNxtogKV51YqsxNIbH4=
Received: by 10.100.190.8 with SMTP id n8mr2899965anf.1186714417662;
        Thu, 09 Aug 2007 19:53:37 -0700 (PDT)
Received: by 10.100.119.8 with HTTP; Thu, 9 Aug 2007 19:53:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55500>

Hi All,

Me again with more dumb git-perforce questions.

I have been toying with git-p4 and I think it does everything I want
except the crazy client map support.  I figure I don't really need
this.  My client is something like this:

//depot/sane/... //clientroot/crazy/...
//depot/stuff/... //clientroot/dumb/...
//depot/otherstuff/... //clientroot/dumb/...
//depot/my/product/... //clientroot/src/realworkhere/...

My "working directory" looks something like this:

c:\path\crazy\xyz_from_perforce
c:\path\crazy\abc_from_huge_binary_fileshare_notinp4
c:\path\dumb\...
c:\path\src\realworkhere\...

If I can just sync from p4 and then sync my binary share and THEN tell
git-p4 that //depot/my/product/... maps to c:\path\src\realworkhere,
get it to import history etc,  then I would be set.

Is this at all possible to do with git-p4?

If not, what sort of work would be necessary to add that (considering
that I am a git noob).

Thanks for the help.

-Govind
