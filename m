From: Timur Tabi <timur@freescale.com>
Subject: How does format-patch determine the filename of the patch?
Date: Thu, 15 Oct 2009 11:17:09 -0500
Message-ID: <ed82fe3e0910150917u72ef189epc74411e71a9cd2d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 18:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyT2F-0002tp-6e
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761551AbZJOQRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757518AbZJOQRr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 12:17:47 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:55142 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbZJOQRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 12:17:47 -0400
Received: by qyk2 with SMTP id 2so809989qyk.21
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=M19Sj1qn4CWmsGya2yo8K2Fv2sNQnVWEK0DInKiiTVc=;
        b=UFf59ktQ/S6Q+fD4azl9YHrp67384U8PotUfVQMgrqq4svNjrh9lqgRFP2ZBNwMrrB
         CclCoYCO9EPOJqBuIT6Yw327DGJIG4Lnptgxza0dMfJk4KiIE9NgxfDp4hbyxyKcE7b2
         8WcZWd/MxgLi+v77a1eJdWSFPTEokW6v/1tsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=JYWPzHTqkg747bFhMjZzd7LraLNX2QvRMHU+aOCDK2+rO4qRjRLra60gGdwhTCdUd0
         o6d+jXSxb6qjhBmxcrsRUtVHDQMcFDfXI0/KoT2Z7AvD5LHQKJF8Fa4Qw2E4BIJ/NFc4
         B011iQKK0E78s78uo7bkQX38vfSIq9gxWisCE=
Received: by 10.239.168.221 with SMTP id l29mr22767hbe.118.1255623429641; Thu, 
	15 Oct 2009 09:17:09 -0700 (PDT)
X-Google-Sender-Auth: 314f0c766e47e18e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130398>

Hi.  I'm not familiar with the git source code, so forgive me if this
is a dumb question.  I'm trying to determine the algorithm that
git-format-patch uses to determine the name of the patch file it
creates (e.g. "0001-this-is-my-patch-without-spaces-and-trunca.patch")
 I'm looking at the function cmd_format_patch(), and I just don't see
where it creates any files.  Can someone show me where this code is?

The reason I ask is that I'm writing a script which calls
git-format-patch to create some patches for post-processing.  So I
need the name of the file that git-format-patch creates so that I can
open it and examine it.  I'd liked to see if there's a way to get the
name of the patch without actually creating the file.

-- 
Timur Tabi
Linux kernel developer at Freescale
