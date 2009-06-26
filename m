From: Rustom Mody <rustompmody@gmail.com>
Subject: git.el problems
Date: Fri, 26 Jun 2009 18:21:23 +0530
Message-ID: <f46c52560906260551m7a95dc9brebbcc1e017995089@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 14:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKAuQ-000433-1Z
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 14:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbZFZMvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 08:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759525AbZFZMvU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 08:51:20 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:59788 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221AbZFZMvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 08:51:20 -0400
Received: by pxi28 with SMTP id 28so1665129pxi.33
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=IfIa7E4ANfV9EDVnP0dsYky1eziFSLxhuzpP5E/hH1E=;
        b=a8Gp5KyAN0n0Ez8mTAnMpx5AON6cvZeKPS95NZyYDBpGpBv5SI2rm3JVUAIm91iC9K
         6w8R51/iqIxSyUGDNOl9Y4ztluAL4gqN62Myn9p33OjjZ4tR9awXr91T4fL4AJFkroLl
         EyfS5tGmWci8c2TFCtxlUBRykYYxRSsLzfzaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Ibl3wu8mX9uoXPxUJTdcdFKjc/I3YpxT5oxbzcORoxSCx4aIjjK5PspAMj49jdxuwV
         PRgeEwFXrocX7+8IrKttthM2Q5dqav7bweHLcRXgmgCTxljs12UO80QQg6+oV9CfekTj
         nz/1Oryqb1v0ZMbPSCv+fYWXbH1iZqL5BKsmc=
Received: by 10.115.48.12 with SMTP id a12mr1624315wak.20.1246020683208; Fri, 
	26 Jun 2009 05:51:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122295>

Ive been trying to use git.el in emacs

I mentioned earlier problems that seem to be between emacs and git;
viz that with a detached head I get
Branch:     fatal: ref HEAD is not a symbolic ref

Poking around a little further I find that the git.el code is probably
problematic independent of git

eg. When I give add-a-file (a) in the git-status buffer, I get

Wrong type argument: arrayp, nil

I gather this is happening in the ewoc library -- most likely ewoc-locate

So...
Surely somebody must using git with emacs (under windows)? What are they using?
