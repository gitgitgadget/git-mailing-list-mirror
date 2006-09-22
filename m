From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git commands that only work correctly at top directory
Date: Fri, 22 Sep 2006 16:21:09 +0700
Message-ID: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 22 11:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQhDf-00015F-BY
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 11:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWIVJVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWIVJVL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 05:21:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:65513 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751101AbWIVJVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 05:21:10 -0400
Received: by wx-out-0506.google.com with SMTP id s14so963597wxc
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 02:21:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eeyl63JmQDQm6RJKRUw+a+zKN/7u9yf6uMiDag6CVntevF37n+fhKUyDN1X9TZlNHPrIDN8cTcpWH/mgtgH/hMfewgEHv4PmtGdnxxBteels62NA5WPpJbtoPQSr4CjJcbcZL5P9Io03n7QjGz05+R2yc/EP4YoeDcPm5WJ0iV8=
Received: by 10.70.117.1 with SMTP id p1mr636349wxc;
        Fri, 22 Sep 2006 02:21:09 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Fri, 22 Sep 2006 02:21:09 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27524>

Here is the list (checks are done in with 1.4.2.rc4):
count-objects (always 0 objects, 0 kilobytes)
bisect (fatal: Not a git repository: '.git'. Bad HEAD - I need a symbolic ref)
describe (fatal: Not a valid object name HEAD)
repack (line 42: cd: .git/objects/pack: No such file or directory. And
it creates a new .git directory in current directory)
git format-patch in subdir generates files in topdir instead of
current dir as documented in its man page

BTW, either git blame or git annotate should be available in git help's listing.
git format-patch with no argument shows nothing. It should show help
usage instead.
I might miss some commands because I only tested commands I'm familiar with.
-- 
Duy
