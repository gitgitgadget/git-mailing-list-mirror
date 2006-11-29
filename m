X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 21:49:12 +0100
Message-ID: <200611292149.14449.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <456DD76C.4010902@gmx.net> <Pine.LNX.4.63.0611292101420.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 20:47:54 +0000 (UTC)
Cc: Marko Macek <marko.macek@gmx.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicholas Allen <nick.allen@onlinehome.de>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NCk5HXvQbisoU7sQIpqlK92ApHO5s5r1R/KsBEoK1AJ36dqU18Hd6xd7jW8BNUpPq9GFSX2HdAS7NrLsthJBpS4ELY/UhYPO9ETNzVhGol+hC7Vh4mfJU3rw/ozNzlYeK8C0z9BaA2I9/p3BRlo58wPzUxjUkp+lu67W6jlO/2I=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0611292101420.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32667>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWL6-0001On-7b for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967669AbWK2Ur2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967670AbWK2Ur2
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:47:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23717 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967669AbWK2Ur2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:47:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1909826uga for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 12:47:25 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr4065266ugg.1164833245266; Wed, 29
 Nov 2006 12:47:25 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id o24sm3126662ugd.2006.11.29.12.47.24; Wed, 29 Nov
 2006 12:47:24 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> 
> On Wed, 29 Nov 2006, Marko Macek wrote:
>>
>> index is of course necessary during merging, ... and as a speed 
>> optimization for applying patches when you know the working copy is 
>> clean.
> 
> I think that it is one major achievement of git to make clear and sane 
> definitions of branches (which are really just pointers 
> into the revision graph), and the index (which is the staging area).

Something resembling index is needed anyway: 1) for "commit all changed
files" to prepare list of files to commit, excluding ignored files,
2) to mark files as "to be added" or "to be removed" (well, git index
could be a little bit smarter here in marking "intent to add"), 3) as
a place for doing the merging. Git just doesn't hide it.

I agree that git definition of branches, and git not hiding index is
it's advantage... and disadvantage to those who learned using version
control on other SCM.
-- 
Jakub Narebski
