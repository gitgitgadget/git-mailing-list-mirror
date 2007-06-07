From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: git-log fatal error in empty repo
Date: Thu, 7 Jun 2007 08:34:20 -0500
Message-ID: <588192970706070634s4c25ae45g68be32c06a30d043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 15:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwI8V-0000B1-Vh
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 15:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbXFGNeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 09:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbXFGNeV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 09:34:21 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:56439 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbXFGNeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 09:34:20 -0400
Received: by an-out-0708.google.com with SMTP id d31so129392and
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 06:34:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DJTN8R0NfILqVlg321Tcj7Wc05VhMNfKL3/zNP8BdkDfoDi0xvCFNMGmQaRY7kHV1K62yMvPNBfkLWz4WIv9yuqxQ+VSZG+A8gQcgY1YUBKdY/J7Zq58ONSFMjBWkNWtllzZzYv9UXo7UIM8kvM1pgR9dJhs1jYBsZbRaRj1HSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lzrsHHtUEp/e26a3QYFPHzJ2yxDXDa6rWdFq+vvc6xMfND7syBbBbomxW/o7QT2KzlXWdHHGAMezEGUzj3FlvHyytxU6rpR4jbF+1XJr+4mTA3VfiuuKeIFKOlQnlajh2IVlExu0q9ULZ1WYGuw2ydBq9xPpCVXUmmcxp5yJH4U=
Received: by 10.100.251.9 with SMTP id y9mr1027790anh.1181223260342;
        Thu, 07 Jun 2007 06:34:20 -0700 (PDT)
Received: by 10.100.120.2 with HTTP; Thu, 7 Jun 2007 06:34:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49367>

git-log will return a fatal error for an empty repo, like so:

$ git --version
git version 1.5.2.73.g18bece
$ mkdir mytest
$ cd mytest
$ git-init
Initialized empty Git repository in .git/
$ git-log
fatal: bad default revision 'HEAD'

It would be nice if git-log was quiet or returned a "no log" message
instead of the fatal error.

Steve
