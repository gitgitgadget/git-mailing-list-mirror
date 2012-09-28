From: Jon Seymour <jon.seymour@gmail.com>
Subject: Stopping git-svn pulling a particular branch
Date: Fri, 28 Sep 2012 14:58:37 +1000
Message-ID: <CAH3Anro6EOq0Qh6R6-YXpMW+9h0xtZcBR3KY0kRgWT-4mGf1xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THSf3-0007Ch-8b
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 06:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145Ab2I1E6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 00:58:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52501 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab2I1E6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 00:58:39 -0400
Received: by bkcjk13 with SMTP id jk13so2836093bkc.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BNTfQ61qbZT2Ipje418dA5jtglAeZd+EBuIZVa0tKas=;
        b=XWzTLhRSdj3Uphr/zUq4eQng0OX93DqDVCBE4h7sP3BXtiOFebuTmjwExVh3djT3Tl
         zJNspG4c0ML/RAxqhzEp50DgAnxnDFs8n7ImiNzsCme/xA3t/FeT9D1I/aYClVpMrhki
         1M/1c4K37nPI/aRirpYzUOsoyg2uKrIDZWPIHut8IzvfwpzyWM8IXcrfyn38M95Vcdzl
         PsoZNqfBeJnAAEOXpp/O2VK8uRvxuoUR5Ol29UPpMln6CCoQlcMMyvx1aCMLi+Yl5Ikv
         AGB8dXzsuKRn4COFZHn3Un0eI8ZFzOklpwzd0fRFm72modAPiSF7EPx2pX4Igmxlwl3N
         Qo+A==
Received: by 10.112.28.167 with SMTP id c7mr2311159lbh.102.1348808317691; Thu,
 27 Sep 2012 21:58:37 -0700 (PDT)
Received: by 10.112.28.8 with HTTP; Thu, 27 Sep 2012 21:58:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206538>

G'day

An svn developer created a branch from a subdirectory of the trunk
rather than by copying trunk itself.

I want to avoid pulling this branch into my git repo with git svn
fetch because the re-rooting pulls in too much history and content
that I don't want.

Is there any easy way to achieve this? I tried used the --ignore-paths
option, but this doesn't seem suited to the purpose.

I can delete the SVN branch if that will help, but past experience
suggests that it won't.

jon.
