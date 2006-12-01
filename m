X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 13:09:49 +0100
Message-ID: <45701B8D.1030508@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:10:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201110032.GL18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32906>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7Dx-0002Im-Q2 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030896AbWLAMKe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030897AbWLAMKd
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:10:33 -0500
Received: from main.gmane.org ([80.91.229.2]:28651 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030896AbWLAMKc (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:10:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gq7Dh-0002Dk-AN for git@vger.kernel.org; Fri, 01 Dec 2006 13:10:22 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 13:10:20 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01
 Dec 2006 13:10:20 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
...
> So you not only store your submodule HEAD commit in the supermodule when you
> do commit to the supermodule, it also means that your submodule HEAD
> will be updated when you update your supermodule.

Why the magic? The typical workflow in git is

1. You work on a branch, i.e. edit and commit and so on.
2. At some point, you decide to share the work you did on that branch 
(e-mail a patch, merge into another branch, push upstream or let it by 
pulled by upstream)

I fail to understand why these two steps have to be mixed up. Someone 
care to explain?

Regards

Stephan
