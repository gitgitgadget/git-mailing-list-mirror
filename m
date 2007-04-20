From: "Aubrey Li" <aubreylee@gmail.com>
Subject: git clone problem through HTTP
Date: Fri, 20 Apr 2007 15:15:46 +0800
Message-ID: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 09:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HenLS-0005uk-PK
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 09:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbXDTHPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXDTHPr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 03:15:47 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:17945 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422997AbXDTHPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 03:15:47 -0400
Received: by nz-out-0506.google.com with SMTP id s1so674274nze
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 00:15:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fGAKWggir8Rk7rJnuNrlt6O5HZwkH4c/Eh8TWvNwl1g+mc2Pwbad1NucfKrv1aJeY3Fl+D++wDdi/ZFFH4BV7ZJQDeSayYrVxobzuomw8T3J8xJSv2XeUoCuxa6q4xppR3cRC6Tb+1dWleFyBbLBXJjMGs3LmIrujo8XaX6bLeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qgMhxKanvFRQFur0A1ryujjCz9ydBKAKihnytAvuZLpPe/JCS1n2TGzsZXrnD/wJnb2JAbMz4Bj+f8PhZrIIhtg3jPmyAMmAEHbMPbKwXxKeJALSkXJs9fGbtQFtwDgTJWyTx/W5k+R1DYDccJbL6mu7P82scURn9DZ6IF1/diU=
Received: by 10.114.133.1 with SMTP id g1mr1135883wad.1177053346210;
        Fri, 20 Apr 2007 00:15:46 -0700 (PDT)
Received: by 10.114.146.20 with HTTP; Fri, 20 Apr 2007 00:15:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45069>

I'm behind of a firewall on which the git port is not permitted, so I
can only use http protocol. Unfortunately, I can't clone linus' git
tree at all. I've tried

git version 1.4.4.2
git version 1.4.4.4
git version 1.5.0.1
git version 1.5.0.4
git version 1.5.0.6
git version 1.5.1.1,

none of them work. The following is the error.
===================================
aubrey@Debian:~/upstream-kernel$ git --version
git version 1.5.1.1

aubrey@Debian:~/upstream-kernel$ git-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6
----snip----
walk b188ffe876382ecc009ceb4fe033fd6ec7ba4ede
walk 0964ce24d091a1d3dc7f667e1b107ab77d4325e6
walk c264852726dde251a0c09ec22f61a9be8b0db68b
walk 69903d6500c73af8329a5fba7153b0d50748981c
walk b59a9504cb93db7fae31e60760725d48652a1fc3
error: Couldn't get
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/tags/v2.6.11
for tags/v2.6.11
The requested URL returned error: 404
error: Could not interpret tags/v2.6.11 as something to pull
==================================

I also tried other mirrors like www1.kernel.org, www2.kernel.org, they
don't work, either.
I really appreciate any help, thanks!

-Aubrey
