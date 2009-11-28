From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] Makefile fixes
Date: Sat, 28 Nov 2009 05:25:46 -0600
Message-ID: <20091128112546.GA10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELFH-0006qz-CB
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbZK1LNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZK1LNb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:13:31 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:49380 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZK1LNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:13:31 -0500
Received: by ywh12 with SMTP id 12so2370982ywh.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=Ng7rnpb7utJV2vkuQ67lo3SgWCvSY17YWczezTYPKTs=;
        b=Jk+AYTcrxuchkMbMa37uaO9oMLJtlsihOFLM8nsh7jk+PvRjyd6NmTUtCWkQex0tYV
         lNjtlCCSbl4HiGvRHzOqlDQcoiuyZROHUhBeZ+fE+9nx4tIt6DKvRJRblvXjqYqqvzoy
         mqtEnsUr+X28ceFNnyOdnpbgLUtXQmhSo551o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=UlPjCdh0+jZJih1/NErLauzKIjgz+8iO4xM0UIRzCIC346gsc9SqkCxEpevp5uEfvW
         07FFptY33Qe14PWSgEVB9ZKTEIHBQJMYb4To3V6nKvfF1iXg7Byej8/WKFHK5Kb5nztB
         akoNk64AmE5d9FhDqrODE/6N9BXPflWbXw/IY=
Received: by 10.150.167.26 with SMTP id p26mr3403621ybe.14.1259406817410;
        Sat, 28 Nov 2009 03:13:37 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm559293gxk.1.2009.11.28.03.13.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:13:36 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133949>

Here are the aforementioned small fixes for the Makefile, intended for
maint.  I hope they are of some use.

Jonathan Nieder (4):
  Makefile: http-push.c uses the git headers
  Makefile: make ppc/sha1ppc.o depend on GIT-CFLAGS
  Makefile: fix .s pattern rule dependencies
  Makefile: stop cleaning arm directory

 Makefile |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)
