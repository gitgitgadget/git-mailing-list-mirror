X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Anand Kumria" <wildfire@progsoc.org>
Subject: when is a remote a branch?
Date: Sun, 12 Nov 2006 15:50:02 +0000 (UTC)
Message-ID: <ej7fra$8ca$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 15:50:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: backup.global.cn
User-Agent: pan 0.117 (We'll fly and we'll fall and we'll burn)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31263>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjHbF-0003u8-ES for gcvg-git@gmane.org; Sun, 12 Nov
 2006 16:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932939AbWKLPuU convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWKLPuU
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 10:50:20 -0500
Received: from main.gmane.org ([80.91.229.2]:54218 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932939AbWKLPuS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 10:50:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjHax-0003pY-C8 for git@vger.kernel.org; Sun, 12 Nov 2006 16:50:07 +0100
Received: from backup.global.cn ([195.224.169.69]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Sun, 12 Nov 2006 16:50:07 +0100
Received: from wildfire by backup.global.cn with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 12 Nov 2006 16:50:07
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I generally tend to use cogito -- it does all the heavy lifting, like
recovering from interrupted fetchs (usually) for me.  One thing I haven=
't
really gotten my head around is the difference between a branch and a
remote.

git-branch knows of 'remotes' (via the -r parameter) and these to be
unrelated to what cogito thinks remotes are (it seems to look for thing=
s
in .git/refs/head/<name> and then a corresponding .git/branches/<name>/
which it then declares a remote).

Yet, git-init-db creates both .git/remotes and .git/branches

What is the difference between the two. From my (na=C3=AFve) perspectiv=
e the
two tools (git and cogito) regarded them very differently.

Any explanation, or pointer to some documentation, would be helpful.

Thanks,
Anand
