X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: Problems with git-svn authors file
Date: Mon, 11 Dec 2006 12:44:22 +0100
Message-ID: <20061211114422.GA5332@fry.bender.fht>
References: <20061210172604.GA18385@hermes.lan.home.vilz.de> <200612110904.54389.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 11:44:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612110904.54389.andyparkins@gmail.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33995>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtjaJ-0006Nt-GL for gcvg-git@gmane.org; Mon, 11 Dec
 2006 12:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762838AbWLKLog (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 06:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762839AbWLKLog
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 06:44:36 -0500
Received: from mail.hs-esslingen.de ([134.108.32.78]:39931 "EHLO
 mail.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762838AbWLKLog (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 06:44:36 -0500
Received: from localhost (mail.hs-esslingen.de [134.108.32.78]) by
 mail.hs-esslingen.de (Postfix) with ESMTP id 50C2E13F5D; Mon, 11 Dec 2006
 12:44:34 +0100 (CET)
Received: from mail.hs-esslingen.de ([134.108.32.78]) by localhost (rslx211
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 06373-08; Mon, 11 Dec
 2006 12:44:23 +0100 (CET)
Received: from localhost (ovpngp2254.hs-esslingen.de [134.108.122.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by mail.hs-esslingen.de (Postfix) with ESMTP id
 A0BE113F62; Mon, 11 Dec 2006 12:44:23 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Dec 11, 2006 at 09:04:52AM +0000, Andy Parkins wrote:
> On Sunday 2006 December 10 17:26, Nicolas Vilz wrote:
> 
> > Use of uninitialized value in hash element at /usr/bin/git-svn line
> > 2952.
> > Use of uninitialized value in concatenation (.) or string at
> > /usr/bin/git-svn line 2953.
> > Author:  not defined in .git/info/svn-authors file
> > 512 at /usr/bin/git-svn line 457
> >         main::fetch_lib() called at /usr/bin/git-svn line 328
> >         main::fetch() called at /usr/bin/git-svn line 187
> 
> I've had errors like this.  For certain repositories (possibly very old ones) 
> there is an unusual, empty, revision 0.  I got around the problem by telling 
> git-svn to start at revision 1.  Everything seemed fine after that.
> 

Well it is a fresh repository. And you are right, there is an empty
revision 0. I didn't recognize that is was the revision 0 I got stuck
with. But it is obvious now :)

> $ git-svn fetch -r1
> 
> I don't know if that will be your fix, but it's worth a try.
That fixed it, thx.

