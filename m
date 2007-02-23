From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.12.1
Date: Fri, 23 Feb 2007 23:13:40 +0000
Message-ID: <b0943d9e0702231513w1c42d017q9091b0fc3a16978a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "GIT list" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 00:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKjbo-0007uK-RO
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 00:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249AbXBWXNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 18:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbXBWXNo
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 18:13:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:59719 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933249AbXBWXNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 18:13:43 -0500
Received: by wr-out-0506.google.com with SMTP id i31so719439wra
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 15:13:43 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bKOM36JtKeXKpC4Jb7RHIu4xLxFEIhCjbmEGm+XUx0rZFsaqq3jToKizXWj5eFDOh3Vl/l8TrehalrgqQokxA5ALlMYAX+MzaZxxnKJGPruyGNkcUuPN1Yxc3ep2pJcaA6NR+g/weqbdk82CkvNXOHijIUuR2/pwwA9eG6pd2AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ofMkIavSrZsoDVPfHi+f87tXwX1x/8UWw2Vjbarz9iMaeeV0uS7pHYBrW1W0dQi/i/uEjGiMOC7qUuS+FASMr9LGqWmawU+fIK28A8hqdPmvSga4T6zbea8NndYRWvc/G+Ccvz0nErTEnonBx7w2cH/mFiwuqWAGkBCiRTO6rGg=
Received: by 10.114.58.1 with SMTP id g1mr72568waa.1172272421257;
        Fri, 23 Feb 2007 15:13:41 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 23 Feb 2007 15:13:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40473>

Stacked GIT 0.12.1 release is available from http://www.procode.org/stgit/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

    * Allow StGIT to run when there is no user information configured
    * Use 'git-pull' rather than 'git-fetch' by default
    * Fix the 'mail' command to parse multiple-lines address headers
    * Fix the alias check in the 'stg mail --bcc' command
    * Add '--merged' option to rebase
    * Add '--url' option to 'import' to import a file directly from the network
    * Add '--author' option to 'series'

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas (10):
      Make StGIT aware of the STGIT_DEBUG_LEVEL environment variable
      Fix the behaviour when there is no user information configured
      Allow importing mbox files from stdin
      Add --author option to series
      Fix import to allow --name and --strip for most import types
      Display whether the patch is empty after refresh
      Fix the alias check in the mail --bcc command
      Fix the mail command to parse longer address headers
      Use 'git-pull' rather than 'git-fetch' by default
      Release 0.12.1

Yann Dirson (7):
      Add --merged option to rebase.
      Use canonical command name in help message.
      Support for pre-1.5 git in stgit tests.
      Factorize rebasing behaviour.
      Move stack-base querying into Series class.
      Various cleanups for clarity.
      Keep track of safe base changes.

Clark Williams (1):
      URL import for stgit

Sam Vilain (1):
      Some minor debian packaging fixes

-- 
Catalin
