X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: correctly access repos when only given partial
 read permissions
Date: Sun, 03 Dec 2006 11:40:10 +1300
Message-ID: <457200CA.7010805@vilain.net>
References: <11644366982320-git-send-email-normalperson@yhbt.net> <4571F6E7.4050809@vilain.net> <20061202222433.GA21171@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 22:40:39 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20061202222433.GA21171@localdomain>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33065>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdX3-0000pJ-Oe for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936574AbWLBWk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936573AbWLBWk1
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:40:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:3507 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S936574AbWLBWk0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 17:40:26 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 00147139B0D;
 Sun,  3 Dec 2006 11:40:23 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 4D0811380C2; Sun,  3 Dec 2006 11:40:17 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
>> I now get this error:
>>
>> Filesystem has no item: File not found: revision 8514, path
>> '/mirror/fai/tags/mirror/fai/tags' at /home/samv/src/git/git-svn line 3236
> 
> This should be fixed in 1ca7558dd838e82f6f6b8611b981654fa4ecde2b in
> Junio's master: "git-svn: fix multi-init".

Ah, so it did.  Silly me for running on ancient version of git-svn ;)

>> (next, I'll make git-svn correctly look at the svm:* revprops to get the
>> upstream repo URL and revision number for the commit message)
> 
> Cool.  While you're at it, would you mind looking into supporting some
> of the merge revprops that I've heard about, too?  Thanks.

Great idea, I'll certainly do that.  Of course, they are relative to the
*local* repository...

