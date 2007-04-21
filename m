From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible bug in --short option of git-rev-list
Date: Sat, 21 Apr 2007 11:32:14 +0200
Message-ID: <e5bfff550704210232v7a214aa7jc5f55fe26edbf8e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamamo" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfBxN-0006Ag-3J
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbXDUJcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 05:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXDUJcQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:32:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:7141 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbXDUJcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 05:32:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1248481wxd
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 02:32:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s3MRjISY4wudVJ5oZfd1WmbYmY9aM2WTy+haZYbYv4qDZbgdRz/LnFzkjb+1yqxOGXuaUR9SEayybJb6IKhPR7DR6i5VCv27xfrvEy2S9ccOy7wuJ24uCK+NjEwOrT/8S/IgmqS4Yc7axGzNErVYNVaifu+IHWeRQCHZw3PstEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lZl0LIdgjJ0aw77bHnLF3Vh0Z5s6Qt38gi/guMBC7VAlPbPih/LfUQEpgra6aJ6KlDBpEm3z0uOZtfZLoK6BYz4/5NEWPFyvwe6poRbkXPjwQNwffOSkWX7t81h++IxGPFwlOa0B7noEZbUBjJ85xEnqjM36g4KnR0YHDlwE2Ac=
Received: by 10.114.13.1 with SMTP id 1mr1612404wam.1177147934722;
        Sat, 21 Apr 2007 02:32:14 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 02:32:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45156>

>From git tree

$ git rev-parse v1.5.1.1 HEAD
c5ec6d00eb063f547e314fdf8a1d8cf09472da6b
744747ef1d75c85fb3a1785cb08d36497128d3d3
$ git rev-parse --short v1.5.1.1 HEAD
c5ec6d0
744747e
fatal: Needed a single revision
$

Output is correct, but at the end an (bogus?) error is reported an
git-rev-parse command exits with error code.

Marco
