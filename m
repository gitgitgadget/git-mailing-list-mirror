X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: UI nitpick
Date: Wed, 20 Dec 2006 23:55:47 +0100
Message-ID: <emcf17$esj$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 22:56:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34978>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxAMf-00022C-P5 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1160998AbWLTW4b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWLTW4b
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:56:31 -0500
Received: from main.gmane.org ([80.91.229.2]:37628 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1160998AbWLTW4a
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 17:56:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GxALy-0007Is-N2 for git@vger.kernel.org; Wed, 20 Dec 2006 23:56:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 20 Dec 2006 23:56:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006 23:56:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hi,

git-reset is really neat when you messed something up, but it 
spews messages.

  [lilydev@haring lilypond]$ git-reset  HEAD
  lily/accidental-engraver.cc: needs update
  lily/lyric-combine-music-iterator.cc: needs update

this makes me think that the reset was unsuccesful.

After a few more experiments with 

  git-reset <stuff> HEAD^ 

I started noticing that the list grew longer and longer.


It would be nice if git-reset printed 

 HEAD is now <sha1> - <excerpt of commit message>


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
