X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 10:52:22 -0600
Organization: Freescale
Message-ID: <45632EC6.5030902@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 16:52:50 +0000 (UTC)
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <20061121163206.GA22006@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32001>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYrV-0004U1-Hp for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031027AbWKUQwf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbWKUQwf
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:52:35 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:51416 "EHLO
 de01egw01.freescale.net") by vger.kernel.org with ESMTP id S1031027AbWKUQwe
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:52:34 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
 kALIE8B1027503; Tue, 21 Nov 2006 11:14:08 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALGqNXt008884; Tue,
 21 Nov 2006 10:52:23 -0600 (CST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Twice the size of a normal tarball isn't too bad, considering that
> you have the _complete_ history in the pack and yet the normal
> tarball has no history at all.

That is true.  However, for the particular project I'm working on, double the 
size is not really acceptable.

My goal is to provide a source tree that is "git enabled", so that user can use 
git command to fetch, apply, and create patches.  Currently, we're just handing 
out tarballs, so we want to move people to the 21st century.

> Shallow clone is a development feature still being working on in
> Junio's 'pu' branch of git.git.  It has a few issues still to be
> worked out so it hasn't been made part of one of the more stable
> branches yet (like 'next', 'master', or 'maint').

Well, until it's available on an official git release, it doesn't help me.

-- 
Timur Tabi
