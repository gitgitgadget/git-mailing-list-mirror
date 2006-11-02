X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Thu, 02 Nov 2006 15:47:17 +0300
Message-ID: <eicpch$7ar$2@sea.gmane.org>
References: <200610261641.11239.andyparkins@gmail.com>	<200611010953.57360.andyparkins@gmail.com>	<7vpsc710oy.fsf@assigned-by-dhcp.cox.net>	<200611012029.41869.andyparkins@gmail.com> <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 12:55:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30745>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfc6R-0004SD-1Z for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751781AbWKBMzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 07:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbWKBMzQ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:55:16 -0500
Received: from main.gmane.org ([80.91.229.2]:3502 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751781AbWKBMzO (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 07:55:14 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gfc62-0004Ob-Ep for git@vger.kernel.org; Thu, 02 Nov 2006 13:55:02 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 13:55:02 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006
 13:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> In other words, I do not have a good explanation on what "git
> reset [--hard|--mixed] <commit> <path>..." does that I can write
> in the documentation.

In my humble opinion, git-reset is somewhat overloaded in functionality,
and it takes time to explain its function to git newbies.

Why not split it into two commands, e.g.

  git-rewind for manipulations with HEAD
  git-reset for manipulations with index and working copy only

?
