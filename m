From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT-0.8.3.4
Date: Mon, 27 Sep 2010 08:46:39 +0200
Message-ID: <AANLkTi=zx=g7hOzY749TP-Z+UpgiRGOLXzof=2xiUtn1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 08:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07U6-00049a-M1
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 08:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758680Ab0I0Gqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 02:46:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61935 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591Ab0I0Gql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 02:46:41 -0400
Received: by qwh6 with SMTP id 6so3219446qwh.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=/s+ZgM3lT6zpYnP9QVAMn1SHNzPvgHyPH+tyakXUKJA=;
        b=lPzuCwD8JwvTZ7EwsYKkzLhghcIwVnJpjCYT1KYBxHhW3twMUJC1aw3B7HIOveqSVt
         GE+XXdM3wJPQsmyH7NpPqa1YYhK2siEQvqEBaT/fwpiovGJ9QlD1O+98Ze+zoPWtPrje
         /TJwOpPngCqEg1UlGJ8uMJV58pJ5LrdnUVf9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fsUhO8G+O0VRJchED+/j1bfQwSRD66OljpxrhG0xOx2Q1/6hGa7l23aSGJIJKE0Z+u
         YMxzgyg3kb373zYU/EZH1iesI7vbS5Z6B5Ewlkjv236Xgn6P8Xsdb4y47YlxbXnQOJre
         IFjKynxoJa0RMHVmYd1SkgkjXRpS43gkvATxw=
Received: by 10.229.189.140 with SMTP id de12mr5280114qcb.5.1285569999270;
 Sun, 26 Sep 2010 23:46:39 -0700 (PDT)
Received: by 10.229.62.92 with HTTP; Sun, 26 Sep 2010 23:46:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157305>

A bugfix-release of cgit (a web interface for git repositories) is now
available at http://hjemli.net/git/cgit.

This release links with GIT-1.7.3 to avoid the gitfile vulnerability
described in http://seclists.org/oss-sec/2010/q3/93 (due to self), and
a few other fixes.

$ git shortlog --no-merges v0.8.3.3..v0.8.3.4
Aaron Griffin (1):
      RSS items should always use UTC times

Lars Hjemli (3):
      ui-snapshot: actually compress zip archives
      Use GIT-1.7.3
      CGIT 0.8.3.4

Mark Lodato (2):
      t0108-patch: add 'tests_done' to end
      html: fix strcpy bug in convert_query_hexchar

-- 
larsh
