From: "Lars Hjemli" <lh@elementstorage.no>
Subject: [ANNOUNCE] cgit v0.4
Date: Mon, 14 May 2007 00:24:28 +0200
Message-ID: <8c5c35580705131524s15e78d4y807879c64edd5de1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 14 00:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnMUW-00027f-9X
	for gcvg-git@gmane.org; Mon, 14 May 2007 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXEMWYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 18:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbXEMWYa
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 18:24:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:47853 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXEMWY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 18:24:29 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1623367nzf
        for <git@vger.kernel.org>; Sun, 13 May 2007 15:24:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=koSk1g2WqUYYkGqZn0zkJfEno/4Krlyg6QCHXsO/1HFDV43BHiUF/XjnI7LHR+m0m38viP4YcFzYPLTBeQ6IgxdBBad3N+Q4e5qqC5iyglpPGWUGJTjA0RcyvW/OG0GaV8H3x7bsMf9U51NSG/fJnWHjfDSL469mYUiuP9PW6pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=rZdWWqYNc2ihUcPme3p9Ol3KT+NPK/tcjKmB85Two+u+KdwL1bZLWr32I8ZXOZQXwtLgilRgsO5bk9jYE6Eq2LbU5in9/8gsIRJhJ7P5hnQYim/k1qcL9AKDkWJJSYdHr3sLD/TMVzljymdCNmk9n3kXUxVp859ZeR7AUPjE4Dc=
Received: by 10.114.106.1 with SMTP id e1mr739268wac.1179095068337;
        Sun, 13 May 2007 15:24:28 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 13 May 2007 15:24:28 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 4a0aee8afd59672d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47185>

I've just tagged and pushed v0.4 of cgit. Notable changes since 0.3
include graphical diffstat for commit, full commitdiff against each
parent, number of changed files/lines per commit in log view and
support for shortcuts to tarballs etc. on the repo summary page (using
refs/archives namespace).

The release is now running on http://hjemli.net/git/cgit/ and can be
cloned from git://hjemli.net/pub/git/cgit

---

Shortlog since v0.3:

Lars Hjemli (13):
      Makefile: add support for building w.o. preinstalled git
      Add links to enable downloading of tagged blobs
      css: fix bad rendering in Internet Explorer
      Add shared diff-handling functions
      Use standard tree-diff function when showing diffstat for single commit
      Show number of changed files in log view
      Add standard interface for file diff functions
      Simplify ui-diff.c using the new file-level diff interface
      Show number of changed lines in log view
      Add max-commit-count parameter to cgitrc
      Add graphical diffstat to commit view
      Add commitdiff between commit and each of it's parent
      cgit v0.4

-- 
larsh
