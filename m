X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Wierd tag errors from current 'next'
Date: Sat, 25 Nov 2006 13:32:16 +0000
Message-ID: <456845E0.1050001@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 13:32:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32286>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnxdp-0002Z1-Re for gcvg-git@gmane.org; Sat, 25 Nov
 2006 14:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935184AbWKYNcT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 08:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935185AbWKYNcT
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 08:32:19 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:52740 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S935184AbWKYNcS
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 08:32:18 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gnxcy-0005HO-SK for git@vger.kernel.org; Sat, 25 Nov 2006
 13:31:33 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I just was fetching some updates from a repository which I sync from CVS
into my development repository.  I got the following wierd errors about
a tag during the fetch, it seemed to fix itself by the end ... hmmmm.

apw@pinky$ git --version
git version 1.4.4.1.g61fba

-apw

apw@pinky$ git fetch
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
remote: Generating pack...
remote: Done counting 42 objects.
remote: Result has 28 objects.
remote: Deltifying 28 objects.
remote:  100% (28/28) done
remote: Total 28, written 28 (delta 20), reused 20 (delta 12)
Unpacking 28 objects
 100% (28/28) done
g* refs/heads/origin: fast forward to branch 'master' of
/home/apw/git/abat-up/
  old..new: a6bb0e2..1063ab6
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
Auto-following refs/tags/v0_72_3
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
error: refs/tags/v0_72_3 does not point to a valid object!
remote: Generating pack...
remote: Done counting 0 objects.
Total 0, written 0 (delta 0), reused 0 (delta 0)
Unpacking 0 objects

* refs/tags/v0_72_3: storing tag 'v0_72_3' of /home/apw/git/abat-up/
  commit: a38fa34
