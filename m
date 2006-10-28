X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 10:59:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610281058070.3849@g5.osdl.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org>
 <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> <7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
 <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
 <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 28 Oct 2006 18:00:52 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028072146.GB14607@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30384>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdsTd-0007v6-7l for gcvg-git@gmane.org; Sat, 28 Oct
 2006 20:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751249AbWJ1SAF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 14:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWJ1SAE
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 14:00:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13728 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751248AbWJ1SAB (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 14:00:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9SHxWPo022251
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 28
 Oct 2006 10:59:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9SHxV3q031362; Sat, 28 Oct
 2006 10:59:31 -0700
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Sat, 28 Oct 2006, Shawn Pearce wrote:
> 
> Why not just use create a new flag file?
> 
> Lets say that a pack X is NOT eligible to be repacked if
> "$GIT_DIR/objects/pack/pack-X.keep" exists.

Yeah, me likee. Simple and straightforward, and mixes well with the 
"--keep" flag that has been discussed for git repack anyway.

