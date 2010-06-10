From: Eric Raible <raible@gmail.com>
Subject: [RFH] specifying rebase options when branch.<name>.rebase = true
Date: Thu, 10 Jun 2010 12:01:34 -0700
Message-ID: <AANLkTimbBZVWk2EzXIngSV6Kblap1k8mPbfEa8OOGxUh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:01:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMn0a-0006VA-8S
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759627Ab0FJTBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 15:01:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42060 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759600Ab0FJTBh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 15:01:37 -0400
Received: by gye5 with SMTP id 5so206387gye.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=AV22xxfwa/c8jxm51iYqUtb1lJD2aGz6mm/DYFitleU=;
        b=Ja9zLxSvjLMOXOGJ6qxOFKw8NY1QbLj9j4gHy9iXhyRqL4BxDC/ThvGUQusQ9Culvu
         iBzXM3o/mxrxyEPfCxElVki/yMxQalwAJsAWILf6qBx7MssOKYiAeZCIaoylY1J7txzH
         XEfGBqo7Qi8QeSZmbohgFy7AxbHjm5AmKTpvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bQcQucG0qjfP3MVqYesQ82JGx0VWsP0KJssHdi+bH2YGtA6b6HuSL3JMTtMaB4VM/3
         cMfzu/g7mtXGmzWuQTnw/n8dgZvsA1Vv51tDOA7DPf53Y/pPcW1P8LYPJvYDhVk6uaEz
         TbKYTGR8FIFu1uj7TnwPLiH4W2smmeOHL/6Ac=
Received: by 10.224.53.80 with SMTP id l16mr592656qag.308.1276196496384; Thu, 
	10 Jun 2010 12:01:36 -0700 (PDT)
Received: by 10.220.86.137 with HTTP; Thu, 10 Jun 2010 12:01:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148911>

In setting up our rebase-based workflow I'd like people
to simply use "git pull".  But "branch.<name>.rebase=true"
gets me only halfway there.

The problem is that I'd like to rebase local merges as well,
but have not seen a was to specify the --preserve-merges flag.

Am I missing something obvious?
