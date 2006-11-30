X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 12:57:44 +0100
Message-ID: <456EC738.6000103@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061128154434.GD28337@spearce.org> <200611281629.08636.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 11:58:33 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <200611281629.08636.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32725>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpkYU-0004c1-Nc for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936225AbWK3L6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936234AbWK3L6Q
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:58:16 -0500
Received: from main.gmane.org ([80.91.229.2]:50568 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936225AbWK3L6P (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:58:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpkYG-0004YP-Mn for git@vger.kernel.org; Thu, 30 Nov 2006 12:58:04 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 12:58:04 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30
 Nov 2006 12:58:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
...
> Worse, if you allow that to happen, the supermodule can commit a state that 
> cannot be retrieved from the submodule's repository.  The ONLY thing a 
> supermodule can record about a submodule is a commit.

So what? You have a submodule commit that only exists in the 
supermodule. I fail to see the problem. The changes you made to the 
submodule _in the supermodule_ can later be pulled from wherever you want.

Regards

Stephan
