X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: Some tips for doing a CVS importer
Date: Wed, 29 Nov 2006 19:45:08 -0500
Message-ID: <20061130004508.GA22208@nevyn.them.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456ACAF3.1050608@alum.mit.edu> <456AD137.8060209@bluegap.ch> <456B61FE.7060100@alum.mit.edu> <456C5363.6040409@bluegap.ch> <456E2746.4050707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 00:45:31 +0000 (UTC)
Cc: Markus Schiltknecht <markus@bluegap.ch>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	dev@cvs2svn.tigris.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456E2746.4050707@alum.mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32690>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpa3G-0005LF-Op for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967738AbWK3ApT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967739AbWK3ApT
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:45:19 -0500
Received: from nevyn.them.org ([66.93.172.17]:35500 "EHLO nevyn.them.org") by
 vger.kernel.org with ESMTP id S967738AbWK3ApS (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:45:18 -0500
Received: from drow by nevyn.them.org with local (Exim 4.63) (envelope-from
 <drow@nevyn.them.org>) id 1Gpa32-0005mo-Tl; Wed, 29 Nov 2006 19:45:09 -0500
To: Michael Haggerty <mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 01:35:18AM +0100, Michael Haggerty wrote:
> ...times 4 (tags per day) -> 32GB.  If I understand correctly, the tags
> were created nightly by automated scripts.

Correct.  Remember, checking out a branch from a CVS repository from a
particular date was extremely awkward; the tags were the only way to
have reproducible snapshots.

-- 
Daniel Jacobowitz
