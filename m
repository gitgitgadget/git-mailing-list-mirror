From: Jonathan del Strother <maillist@steelskies.com>
Subject: Can't build git on Lion?
Date: Thu, 28 Jul 2011 08:59:02 +0100
Message-ID: <CAF5DW8+efO0jcynyhg3GCZc5JByHwQzudqtrJXF87YazYjF2mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 28 11:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmMUc-000258-68
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 11:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1G1JCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 05:02:53 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:46325 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab1G1JCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 05:02:52 -0400
X-Greylist: delayed 3807 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jul 2011 05:02:52 EDT
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43992)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1QmLV5-0004Ci-Ow
	for git@vger.kernel.org; Thu, 28 Jul 2011 03:59:24 -0400
Received: by iyb12 with SMTP id 12so2587005iyb.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 00:59:22 -0700 (PDT)
Received: by 10.231.119.67 with SMTP id y3mr484704ibq.155.1311839962117; Thu,
 28 Jul 2011 00:59:22 -0700 (PDT)
Received: by 10.231.16.66 with HTTP; Thu, 28 Jul 2011 00:59:02 -0700 (PDT)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178051>

Heya,
I've upgraded my OS X machine from 10.6 to 10.7 (Lion), and seem to be
no longer able to build git.  Running 'make' results in:
    GEN git-add--interactive
make[2]: *** No rule to make target
`/System/Library/Perl/5.10.0/darwin-thread-multi-2level/Config.pm',
needed by `perl.mak'.  Stop.
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2

There's no /System/Library/Perl/5.10.0 directory, but there is a 5.10
directory.  Symlinking that to 5.10.0 gives me :

    GEN git-add--interactive
Writing perl.mak for Git
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2


Running 'perl -v' shows I'm running v5.12.3.  Where is that
"/System/Library/Perl/5.10.0/darwin-thread-multi-2level/Config.pm"
path obtained from?  Any other information I can provide?

-Jonathan
