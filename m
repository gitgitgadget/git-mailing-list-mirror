From: Tim Visher <tim.visher@gmail.com>
Subject: Pair Programming Workflow Suggestions
Date: Tue, 15 Sep 2009 13:43:17 -0400
Message-ID: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 19:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnc49-0004di-Mt
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 19:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbZIORng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZIORnf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 13:43:35 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:53696 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbZIORnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 13:43:35 -0400
Received: by ywh4 with SMTP id 4so6033217ywh.5
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=HLgkbBdxGH4NZJU6un99Kro6ln+NBPaApwlQ4kC5lyk=;
        b=ZAoe4Vywf1di2MhU/Y076bsI4ey40+F5UPAOl5GMuZ3B+Skzjx+f4SiMdDXC/M3oG/
         Il/KfvEqcfPLiEptQs8qiRFG6VGcgutALiLGsWDtFPGhemqRqVp+D/2DxImDsacwYnWj
         ys2bOCm4NMAlCw2U9kXU92hG69wcJ5vCPRWf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=RBS6ny8HcyqOKoDxdef3/055PEGqpVPJ1+3YPUXM+2tRyf3ft7s8YwrscXEOtxCuq4
         fmFf9IyqimWQTV6d+m99NosF9lcG7iD2+mZMiTf8e1H5xY114LDJpy4hY1fSNla4izjc
         69e/ZyuoLTNhqDwso2pe16m0izqDk1qyzQ1UM=
Received: by 10.101.95.3 with SMTP id x3mr7856384anl.112.1253036617099; Tue, 
	15 Sep 2009 10:43:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128575>

Hello Everyone,

I'm interested in hearing how people use Git for pair programming.
Specifically, how do you document that you are programming in pairs.
Typically, of course, you have a driver and a navigator.  It seems
natural to have a commit's author be the driver at the time, but that
doesn't seem to do justice to what pair programming is.  Really, both
people are normally coding, but one person is doing the typing and
most of the thinking while the other is acting as an in place code
reviewer.  There are even cases where there's a third person involved.

I did find [Brian Helmkamp's
script](http://www.brynary.com/2008/9/1/setting-the-git-commit-author-to-pair-programmers-names)
but that's not really what I'm looking for.  For instance, that would
break the nice integration we have with Hudson at this point for
displaying when a developer was last active.  It would be nicer to
have an arbitrary number of authors that can all exist separately, but
I'm fairly certain that git does not support that.

Thoughts?


-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
