From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH 0/9] http-fetch fixes
Date: Wed, 1 Feb 2006 16:30:53 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060201153052.GA16461@informatik.uni-freiburg.de>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:32:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Jwg-0006D9-5v
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWBAPaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWBAPaz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:30:55 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54972 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1422631AbWBAPay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 10:30:54 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F4Jwb-0007MT-C7; Wed, 01 Feb 2006 16:30:53 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k11FUrmE016795;
	Wed, 1 Feb 2006 16:30:53 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k11FUrbU016794;
	Wed, 1 Feb 2006 16:30:53 +0100 (MET)
To: Mark Wooding <mdw@distorted.org.uk>
Mail-Followup-To: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15418>

Hello Mark,

Mark Wooding wrote:
> This patch series fixes the git-http-fetch bug I reported in
> `git-http-fetch failure/segfault -- alas no patch'.  The preliminary
> patch I was working on /did/ actually fix the bug I found, but uncovered
> a bunch more, which I think I've finally got to the bottom of.
> 
> The series applies to commit 1506fc34f7585880aeeb12b5fdfe2de4800f9df5.
after reverting c8568e139ed2149fbfb7ef9a8d819d5b6b7c554f it applies to
8233340ce6eb700eb2cd9c0fef4d1705997c499b (=current master), too.
    
With these patches applied, I get now a Segfault, while cloning u-boot.

        walk a7b9fb9110e3c0be644b3e2c8f397f606138a710
        got 98dce899a97f7998b11f58e8c7897ba9f7e0b95a
        got 0cfa422c45d2e2b6023b74a3784034bb18a7eb73
        got 9341e20e95c5ff5c36a8f9506b4039bbc6aefd43
        /home/uzeisberger/usr/bin/git-clone: line 42: 24002 Segmentation fault
        git-http-fetch -v -a -w "$name" "$name" "$1/"

Actually now I cannot reproduce it anymore.  I added some debugging code
s.t. I can give more details if it reoccurs.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=5+choose+3
