X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 16:59:25 -0500
Message-ID: <456CB13D.6090407@utoronto.ca>
References: <45357CC3.4040507@utoronto.ca> <ekhrhi$g6t$1@sea.gmane.org> <456C809C.3050503@utoronto.ca> <200611281943.40354.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 21:59:39 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
In-Reply-To: <200611281943.40354.jnareb@gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32589>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAzH-0001DY-0F for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757160AbWK1V7c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbWK1V7c
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:59:32 -0500
Received: from server4.panoramicfeedback.com ([66.216.124.41]:24512 "EHLO
 server4.panoramicfeedback.com") by vger.kernel.org with ESMTP id
 S1757160AbWK1V7b (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006
 16:59:31 -0500
Received: from server4.panoramicfeedback.com ([66.216.124.41]
 helo=[192.168.2.19]) by server4.panoramicfeedback.com with esmtp (Exim 3.36
 #1 (Debian)) id 1GpAz9-0006hH-00; Tue, 28 Nov 2006 16:59:27 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Well, I gues that with "annotate friendly" (weave or knit) storage
> annotate/blame would be faster. But fast annotate was not one of the
> design goals of git.
> 
> How fast is "bzr annotate"?

$ time bzr annotate builtins.py > /dev/null

real    0m1.479s
user    0m1.430s
sys     0m0.030s

builtins.py has 953 ancestor revisions (i.e. revisions that modified it)
and 3016 lines.

That's on a machine with 4141.87 Bogomips.  I did optimize annotate
slightly, but I'm submitting the optimization for our 0.14.0 release.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFbLE90F+nu1YWqI0RAlkdAJ99Ca4ITlwx+TuGvBmux0HPDpx28QCfTY0h
lJYpnpcpWs8SpAP31x48NF4=
=EDXr
