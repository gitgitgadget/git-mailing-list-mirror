From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: Perforce support.
Date: Thu, 12 Jul 2007 11:34:56 -0700
Message-ID: <69b0c0350707121134t61905e87xaa2fc78c30891bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 20:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93VE-00009Q-8Z
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbXGLSe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXGLSe6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:34:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:47182 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbXGLSe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:34:57 -0400
Received: by nz-out-0506.google.com with SMTP id s18so214741nze
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 11:34:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gABidcnNOl/qJG+VstkqF553+KMcDILViP2eI1nmEOaGr7AXodD6kJ/n3XCZs2+46Ob9AUplzNCL1sc5tEaFJK5T/tmuVaaRXknAcjlj7zqL83JW00NQ2k4a5wjqHg5E4ASkiSGLrLWAaUN4aLKtCr4Sa1833iB/sgKQXgE9uIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NemzxTYWo1/sTfmF60lGZjb9QSFniaEIsB6Jp8cCL82lm6e11P5rCzO9Twg4psEBX7cVen+V7dVwpSy3uZT3x+AC1Nf+IcwK87Odz4AR8wCXEJ+YYZ6BXApyryWv4T4t8z67phfsEC6UNetl88fUONsLrwCPx6HTwI9JKXdUnlA=
Received: by 10.115.15.1 with SMTP id s1mr869347wai.1184265296073;
        Thu, 12 Jul 2007 11:34:56 -0700 (PDT)
Received: by 10.114.12.2 with HTTP; Thu, 12 Jul 2007 11:34:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52314>

Hi,

I am hoping to convince my co-workers to start using a Distributed
SCM, hopefully git, and I wanted to see what people had to say about
the Perforce-git interoperability.  To make it more fun we are doing
this on Windows.

I have been playing around with git for a month or so and have started
writing, what I hope will be, a nice GUI over git that works well on
Windows (Cygwin) and offers some feeling of familiarity to our
Perforce users.  That however is only half the problem.

We need to be able to go back and forth to our main Perforce depot,
and while I understand that git-svn support is very good, I have only
seen limited support of Perforce.  I was wondering if anyone has been
using git with p4 and how well did it work.  We have very complex and
somewhat large "clients" that do a lot of mapping of directories
(which strikes me as particularly insane) and I was wondering if any
of the tools support that.

If anyone has any suggestions/guidance on how to do this I would appreciate it.

Thank You,
Govind Salinas.
