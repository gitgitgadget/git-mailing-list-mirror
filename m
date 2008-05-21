From: "Ian Katz" <ifreecarve@gmail.com>
Subject: git tutorial
Date: Wed, 21 May 2008 12:42:33 -0400
Message-ID: <dc5b80bf0805210942l388c4439g84b8a6b02346ebe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 18:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyrPR-00011z-UQ
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 18:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbYEUQmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 12:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbYEUQmf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 12:42:35 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:54710 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYEUQme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 12:42:34 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2424182hsl.5
        for <git@vger.kernel.org>; Wed, 21 May 2008 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=v2Hf1UdZF5YRQuHFhUmB8Q+UbvMVJo5Ir1T8s2thXLI=;
        b=qpiofvA4xjKBka1nJZmjWYMjpdQAxUOa+q+zhCASBwKX5qo31R/57x8BenrLmvIb7/Vs4EGSQjo0+FrgstJs+oVWnWEPEaftOX/QOi6h8iuAWVxsRhDro+xBsxQCcVl3RCc5ioHf3xuehqWuT93k/HKBY5A07sVRjEJ2KkNy08I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sXERXGRNdTGBmbZ2rMPRxgoSq87VxWPiQL4TusmPJ4VgA7R3Nt/JCYpQudpWpJbRRfozGztPhM75+1YMjwsVyhcEuR7+jr1WtMj1AZUQPGg2X6u4ep8RZCz67Q+VMES1nVGZESs1AhjRT6HAdXE9IcY5E9rWzaJ9IFnjgSYNEWQ=
Received: by 10.90.114.19 with SMTP id m19mr513907agc.91.1211388153473;
        Wed, 21 May 2008 09:42:33 -0700 (PDT)
Received: by 10.100.107.1 with HTTP; Wed, 21 May 2008 09:42:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82556>

Hi Guys-

I have a suggestion/request for the git documentation (tutorial),
currently accessible from:
http://www.kernel.org/pub/software/scm/git/docs/tutorial.html

It would be much easier to understand the "Using git for
collaboration" section if you put the username (bob or alice) as a
prefix to each of the example command prompts, as is common in most
linux distributions.  This would make it easier to see at a glance who
is doing what.

In other words, it would change from this:
$ git clone /home/alice/project myrepo
$ git pull /home/bob/myrepo master

to this:
bob$ git clone /home/alice/project myrepo
alice$ git pull /home/bob/myrepo master

In the tutorial's current form, I spent so much time looking back into
the paragraph text to find out who was typing each command that I
eventually printed it out so I could scribble their names on each one.

I hope this change isn't a big deal.

Thanks,
-Ian
