X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 14:50:45 +0100
Message-ID: <200612021450.46005.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <20061201220821.GL18810@admingilde.org> <200612021004.22236.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 13:51:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <200612021004.22236.andyparkins@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33024>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqVGe-00080w-Cq for gcvg-git@gmane.org; Sat, 02 Dec
 2006 14:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163006AbWLBNuu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 08:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424091AbWLBNuu
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 08:50:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:1211 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1163009AbWLBNuu (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 08:50:50 -0500
Received: (qmail invoked by alias); 02 Dec 2006 13:50:47 -0000
Received: from p5496B2C8.dip0.t-ipconnect.de (EHLO noname) [84.150.178.200]
 by mail.gmx.net (mp030) with SMTP; 02 Dec 2006 14:50:47 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 11:04, Andy Parkins wrote:
> > So what do you do with deleted submodules?
> > You wouldn't want them to still sit around in your working directory,
> > but you still have to preserve them.
> 
> Now that is a tricky one.  Mind you, I think that problem exists for any 
> implementation.  I haven't got a good answer for that.

That suggests that it is probably better to separate submodule repositories
from their checked out working trees. Why not put the GITDIRs of the submodules
in subdirectories of the supermodules GITDIR instead?

