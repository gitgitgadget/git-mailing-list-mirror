From: rupert THURNER <rupert.thurner@gmail.com>
Subject: git-svn: branch trunk/project/code to branches/project-1.0/code
Date: Sun, 24 Mar 2013 20:45:03 +0100
Message-ID: <CAJs9aZ8NgOUcYkYZbpd_7dTPbnNnram_6VUHOPBr8rjyMO6ATg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 20:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqsB-0007V9-CT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab3CXTpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:45:40 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:61872 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab3CXTpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:45:24 -0400
Received: by mail-qe0-f49.google.com with SMTP id 1so3014753qec.22
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=kFCM0nqC6McKzwWTiHKWAWZstV64J4hbT44GAOii9lg=;
        b=PN6cr3EnxkjV6icJIVdgsd2jvL3NJaCYRiCva8KTkh03LOPozy+Pxq2DXCbIZeZsfC
         ZivjyFhin+c8vWUnh3J+KCCJX3Rp2ujL7jV7CJlipj0lAC2pP1L0M9YF3CioaVSnlwX9
         ArNV3mdU97dKR+Ec0nysHBOm8QXyK74mDN2skpt1OYCpViEE030RauK/yRqcAgYUWpjJ
         qc+tyii+alTWcXnT6rdmbnqZiARo260pJFVkTWmddfvh1D57k0z0KycYdap2bRYjePv4
         sKCLNtDksTSRS+ZGkExJbU65E89jnfR8tS4BZOxGhGrwGq9pXlf2G58kd4zrdWH15qtO
         LJVg==
X-Received: by 10.224.78.196 with SMTP id m4mr2397784qak.67.1364154323779;
 Sun, 24 Mar 2013 12:45:23 -0700 (PDT)
Received: by 10.49.106.228 with HTTP; Sun, 24 Mar 2013 12:45:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218972>

our subversion repository contains various things, which are in
dedicated subdirectories:
trunk/project/code
trunk/project/doc
trunk/project/...

the same is then valid for the branches:
branches/project-1.0/code
branches/project-1.0/doc
branches/project-1.0/...

as there are many folders with big items i tried to only track the
code part, but with branches. i though one can just have something
like:

[svn-remote "svn"]
        url = url-of-svn-repository
        fetch = trunk/project/code:refs/remotes/trunk
        branches = branches/project-*/code:refs/remotes/project-*

but this is not correct. how could one support such branches?

 rupert
