From: Eric Frederich <eric.frederich@gmail.com>
Subject: cvs importing a forked project
Date: Fri, 1 Oct 2010 13:38:56 -0400
Message-ID: <AANLkTimvaH4UYzmL9eS1Yq7WNaS+jPRfkajKPP=hjZWV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 19:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jZX-0005oT-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab0JARi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 13:38:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51149 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0JARi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 13:38:57 -0400
Received: by wwj40 with SMTP id 40so1649423wwj.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Mup4OGXHrtKaGNHRX6mMWJXMPt1mV/FykvAJdmxYJOk=;
        b=CeauCmP0h1n62wMJJTy4xB/wfZsy7HwRJFiR362B7SIFu1pomUeoFRz1taf2CRc+yJ
         djBlinr99UFnKW/VOKentZvAeNM1NkFflpy2i/vpEWaLY/MBCRvkkaw9+axYFBB4b9ax
         LDQ4+xbg4tDrpxGSgL0tztstLixqrOWp7l8dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=U0FsNtSl3o0Tu/HO0OxF/3IVZT0y1zP0qiRFAdFPzWZDI4hJtde4iI18iJlHqe2gyC
         N4Uk5EMM1Tz8Rq9f9YzXHnJnR9JPJJ+kLilpc5+9RYpGQKa/ilVykqkajNkl/mXvAus/
         9i88KqC8ceLByvMGXp7kiNPHtxgz4+6UZER8s=
Received: by 10.216.231.97 with SMTP id k75mr4799673weq.4.1285954736595; Fri,
 01 Oct 2010 10:38:56 -0700 (PDT)
Received: by 10.216.80.144 with HTTP; Fri, 1 Oct 2010 10:38:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157763>

Hello,

I have a project (several actually) where development was done in cvs
for 10 years.  Then, about 5 years ago, a copy of the latest was made
and development continued in a new project.
Development in the old project stopped for the most part.

Is there any way where I can combine these two projects in git?
Basically, take the newer project's first commit and make its parent
the the last commit of the older project.
Development was pretty linear.

Thanks,
~Eric
