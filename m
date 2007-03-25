From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Question regarding: git pull --no-commit origin
Date: Mon, 26 Mar 2007 09:02:05 +0930
Message-ID: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 01:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcC7-0007Yk-Nu
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbXCYXcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbXCYXcJ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:32:09 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:61536 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbXCYXcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:32:06 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2580512muf
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 16:32:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nv1+t4g0voF/J8szoOY8UR6u6Pn8XpbJm5zlTHKcDArYn0fP87S+skhKLj9yl1codtuZe8w2AcDUEXsw3lz39e1lAUTo/vFCHeHMPu0qjA3GjIRVU6kBNRPLl5OXc5kIkb27+5nxolVKJvng2xQnjaVWTamGoTcyNjXXNZ+ENB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LUePXyAkmVVKs8a5z71hJpVHOF9keEaMp8jju1hGBrXAfhpzqs8Zlzi4CeS7xee8LKf3d9yPUfb6ln6VAd4CNQeAsJhjIsqvJm7Up51dAyEXRmmATilF+X0V+5l393RWt9UYHerOmEO9Gd1jQeHgMTyLdPEV44YCoM8AxBH7nCE=
Received: by 10.82.148.7 with SMTP id v7mr12403069bud.1174865525053;
        Sun, 25 Mar 2007 16:32:05 -0700 (PDT)
Received: by 10.82.111.16 with HTTP; Sun, 25 Mar 2007 16:32:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43091>

Hi,

I'm using version 1.5.0.5

I do: git pull --no-commit origin

Receive messages ending in:

        ...
       Updating 6a29cdd..b7ba33d
       Fast forward
       interface/testfile |    1 +
       1 files changed, 1 insertions(+), 0 deletions(-)
       create mode 100644 interface/testfile

My working directory is correctly updated. I assume that I can make further mods
and then commit.

However when I do: git commit -a

I'm told: nothing to commit (working directory clean)

Am I misunderstanding something?

Cheers,
Geoff Russell
