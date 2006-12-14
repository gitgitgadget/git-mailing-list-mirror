X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document the simple way of using of git-cat-file
Date: Thu, 14 Dec 2006 01:35:32 +0100
Message-ID: <200612140135.33745.jnareb@gmail.com>
References: <20061213221841.GB4928@fieldses.org> <elq3pa$93b$1@sea.gmane.org> <Pine.LNX.4.63.0612140127520.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 00:33:18 +0000 (UTC)
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RD5BCWAHMXpkAHVschiD9i3nqN0oj0F7hWJo9OGU0Evmgfvc1oWSqt88tAYvmjXiSnvrYhBu/KXQcpw8NazNEN+GPY+d1TqVysUp+ieKNMoirW6nwdMDyJSD3v8THuPGALHx2GXPns2dZLu01BA09LTJXaOw+wUJTlismzrxFEU=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612140127520.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34272>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GueXC-0000OW-Hz for gcvg-git@gmane.org; Thu, 14 Dec
 2006 01:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751609AbWLNAdK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 19:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWLNAdK
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 19:33:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:9962 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751609AbWLNAdJ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 19:33:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so339989uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 16:33:07 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr388412ugl.1166056387367; Wed, 13 Dec
 2006 16:33:07 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 24sm1674498ugf.2006.12.13.16.33.06; Wed, 13 Dec
 2006 16:33:07 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Thu, 14 Dec 2006, Jakub Narebski wrote:
> 
>> Robin Rosenberg wrote:
>> 
>>> Since you can give a version and a path name to git-cat-file,
>>> mention it in the man page.
>> 
>> Very nice, with the exception that git cat-file can be used also
>> for trees and commits (although hit-ls-tree and git-show are usually
>> used) and for tags, not only for files.
> 
> The point is: you are much more likely to look at a blob that at a tree. 
> And if you want to do that, you can always use git-ls-tree.
> 
> But as I mentioned in another thread, I'd rather see git-show do the job 
> of showing blobs, too, in addition to commits as it does already.

More important is that git-cat-file is used for _tags_; git-show used
for tag takes tag as <commit-ish>, so it cannot show tag.
-- 
Jakub Narebski
