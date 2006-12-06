X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Graham Percival <gpermus@gmail.com>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more
 obvious
Date: Wed, 06 Dec 2006 13:02:58 -0800
Message-ID: <45773002.5020409@gmail.com>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:03:44 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Wv2DglY7c7BM4eRcZ+d30WWhuFbEhAqERd0ir0eAx4i1M+SZHbYXN9CM8TD0w5VBDvSQIL3DB9y7KKZrSgilFQ4Nh20FUdW4k+VNuV8g96VO9zKk1N7e+2Mh+5agZ2j5+VJAyE+x0zaDhzv5+ISKC0HSMTwL1/3sxMj1XITCIcE=
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <20061206172450.GE1714@fieldses.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33519>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs3vP-0006qh-Ax for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937639AbWLFVDK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937640AbWLFVDK
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:03:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:3483 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937639AbWLFVDF (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 16:03:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so265948uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:03:04 -0800 (PST)
Received: by 10.78.149.13 with SMTP id w13mr955499hud.1165438983611; Wed, 06
 Dec 2006 13:03:03 -0800 (PST)
Received: from ?192.168.1.139? ( [207.216.3.102]) by mx.google.com with ESMTP
 id 4sm31919006hud.2006.12.06.13.03.01; Wed, 06 Dec 2006 13:03:03 -0800 (PST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

J. Bruce Fields wrote:
> We should start out with the assumption that a shared repo is already
> set up and make it:
> 
> 	committing to a shared repository
> 	creating a shared repository
> 	importing a cvs archive
> 
> which puts it in stuff-most-people-need-to-know to
> stuff-less-people-need-to-know order.  Maybe the current introduction
> should even be postponed to later.

Yes, definitely!

I'm not complaining about changing to git, but Dscho's comment really 
rings true:

 > A developer, especially those whom Git is forced upon, have an
 > attention span shorter than their pub1c hair.

I'm in the middle of exam period, I have a term papers to write, and I 
have two weeks of lilypond bug reports and doc typos to process.  I 
don't care if git can do branches really nicely or walk my dog or cure 
cancer.  I can look at that stuff later -- right now I just want to fix 
things and upload them.

Cheers,
