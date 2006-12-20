X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: git-svn throwing assertion on old svn tracking branch
Date: Thu, 21 Dec 2006 00:55:51 +0100
Message-ID: <20061220235551.GA2974@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 00:16:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 19:16:28 EST
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34987>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxBc2-0006q8-1S for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161080AbWLUAQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWLUAQ3
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:16:29 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:1269 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1161080AbWLUAQ2 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 19:16:28 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id B64D73EDC for
 <git@vger.kernel.org>; Thu, 21 Dec 2006 00:57:03 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uY7h7lEp9mVU for <git@vger.kernel.org>; Thu, 21 Dec 2006
 00:56:42 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id
 5C5C73EE9 for <git@vger.kernel.org>; Thu, 21 Dec 2006 00:55:51 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

hello guys,

it has been a while, i tried git in conjunction with svn... i got a nice
history, when working with it. This Work is now a year old.

Now I wanted to get on working and got following error message while
fetching from one specific svn tracking branch:

$ git-svn fetch -i svn_master
perl: subversion/libsvn_subr/path.c:343: svn_path_remove_component: 
Assertion `is_canonical(path->data, path->len)' failed.
Aborted

I checked the svn working copy, it is uptodate now (although i had to
search for it, i havent been using this repository for one year...)

the output of gitk --all looks good, too. So i wonder if that error
message above is only an alternative to say "more work? i ask because i
am finished and have nothing else todo.."

It is only happening to this old repository...

Any help is appreciated. If possible, i would like to keep my development
history for this repository.

I almost forgot, i use git version 1.4.4.3.g545b 

Sincerly
Nicolas
