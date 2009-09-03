From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 08:45:49 -0400
Message-ID: <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> 
	<20090903012207.GF1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 14:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjBnI-0000Sf-En
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 14:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZICMvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZICMvy
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 08:51:54 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:64694 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZICMvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 08:51:53 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2009 08:51:53 EDT
Received: by iwn5 with SMTP id 5so698797iwn.4
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=PUQuUjerxz/h3WqvFBvBa/egFgsvasJ4xoUdGlTbr30=;
        b=Zkg34N3Y/qwngUaeBBYfDm1U65TneK9YhmAx5C/zAYcqObOkQJxA6kQXzKeN/QzDl0
         dkLyhuL6inx2R71XOOduaP4SSvDzHQxtCTfXVr3CLqFZuZi4Gr0W+TiIAzTPmhYgNQHP
         tIYx8DNyLWP3SvApQGpGEY7YfArWzP/MJLTZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PT+Pv0ZWLgtaspm2rWMQ3P9bhaLSwvhoNpAp+gA74ZU6uZWi02nKW8fYqNFTLmce+b
         bovk6dbrmTnHsDXSHfXzA+81CtJK8Kdr2mrxL+R6he/mRdzgGyyk+peBA21GDptMSBZD
         I9RZqtQ7PPn8HpZaxvjxetql2Uy2iP5hRnBYI=
Received: by 10.231.42.81 with SMTP id r17mr9120775ibe.50.1251981969125; Thu, 
	03 Sep 2009 05:46:09 -0700 (PDT)
In-Reply-To: <20090903012207.GF1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127654>

On Wed, Sep 2, 2009 at 21:22, Shawn O. Pearce<spearce@spearce.org> wrote:
> Yea, for the most part I think we use Eclipse, and you just have
> to import JGit's top level directory into Eclipse as it comes with
> Eclipse project files.  But I know some folks only use our Maven
> build (under jgit-maven/jgit) or use NetBeans.  I have no idea how
> to import the project into the latter or configure its unit tests
> to run.

NetBeans comes with very good support for Maven projects. Importing
JGit into NetBeans is just a matter of using the "Open Project" wizard
and locating jgit-maven/jgit. This will also configure the unit tests
to run.

BTW, what is your opinion of making it a bit easier to import and use
the Maven configuration by putting a pom.xml in the top-level
directory? The actual pom.xml file responsible for building the jgit
library can still live on in jgit-maven/ if that is preferable.

I am also thinking about "mavenizing" the .pgm subproject to make it
easier to browse and search the code from within NetBeans.

-- 
Jonas Fonseca
