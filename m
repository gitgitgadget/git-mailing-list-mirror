From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Thu, 09 Jul 2009 19:29:27 -0400
Message-ID: <4A567D57.7060602@gmail.com>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org> <200907082242.51495.j6t@kdbg.org> <7vvdm26bbk.fsf@alter.siamese.dyndns.org> <20090709063735.GA22544@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP33f-00062W-GE
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbZGIX3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZGIX3g
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:29:36 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:43648 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbZGIX3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 19:29:36 -0400
Received: by gxk26 with SMTP id 26so874350gxk.13
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=y146Si43fOR8Bq82e2Gz/Rv+krj0r4xqHSDQCz41iEU=;
        b=qF/OCNx1xri+Wv4mPOBqHjBXwjQhYuTNDfWMfTW0PelC4wtrCH+fjAUrRgq7h38hiA
         dd5h2htMHd8L5xOZG0+zFB023XneoYumqHF59tVv3N/4AdZpZO4F0dhIH5CTF3XVyEhA
         UoqM/ePSGEko1mU5m36j7QgXLgQ82VEfiK6b0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=JtIZv+mEJ/YSEofyUm8AxzMh0jy8sUu2mZH74IaXNSMUF79HIbWX6eBCmnj0ehtQVQ
         GfEYCz84CdwO7RM6ueXYUi4+P9tn+atDy8tva/9RJ4Pl4tb66dSp0jm1xXzaXoo92vy4
         qEel2h0GWm6AB/7r2JM0xxFnH1BIxeeO6AXUM=
Received: by 10.90.67.6 with SMTP id p6mr1099421aga.25.1247182173686;
        Thu, 09 Jul 2009 16:29:33 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 25sm1381894aga.57.2009.07.09.16.29.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 16:29:33 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090709063735.GA22544@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123020>

Jeff King wrote:

 >
 > Signed-off-by: Jeff King <peff@peff.net>
 > ---
 >  Makefile |   14 +++++++-------
 >  1 files changed, 7 insertions(+), 7 deletions(-)
 >
 > diff --git a/Makefile b/Makefile
 > index 78cc113..311ce7d 100644
 > --- a/Makefile
 > +++ b/Makefile
 > @@ -1641,15 +1641,15 @@ ifneq (,$X)
 >  endif
 >  	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 >  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 > -	{ $(RM) "$$execdir/git-add$X" && \
 > +	{ $(RM) "$$execdir/git$X" && \
 >  		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
 > -		ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
 > -		cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
 > -	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
 > +		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
 > +		cp "$$bindir/git$X" "$$execdir/git$X"; } && \
 > +	{ for p in $(BUILT_INS); do \
 >  		$(RM) "$$execdir/$$p" && \
 > -		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
 > -		ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
 > -		cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
 > +		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
 > +		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 > +		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 >  	  done; } && \
 >  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 >

This breaks the install if ${bindir} == ${execdir}. The following is 
needed on top Peff's patch.

diff --git a/Makefile b/Makefile
index 311ce7d..ec0fddf 100644
--- a/Makefile
+++ b/Makefile
@@ -1641,10 +1641,11 @@ ifneq (,$X)
  endif
  	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
-	{ $(RM) "$$execdir/git$X" && \
-		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
-		cp "$$bindir/git$X" "$$execdir/git$X"; } && \
+	{ test "$$bindir/git$X" = "$$execdir/git$X" || \
+		{ $(RM) "$$execdir/git$X" && \
+			test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
+			ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
+			cp "$$bindir/git$X" "$$execdir/git$X"; } } && \
  	{ for p in $(BUILT_INS); do \
  		$(RM) "$$execdir/$$p" && \
  		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
