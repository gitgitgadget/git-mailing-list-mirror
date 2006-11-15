X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 18:27:52 -0800
Message-ID: <f2b55d220611141827m5ebe27bfvf59eb04fd5b20cfc@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	 <87hcx1u934.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 02:28:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcZb08Lt60oWTjyfIQr5+Dci2aJW3+CWa7PAsADCeGQ1V0C1TKwEgHmUzE2ap45C2D06SCh8wngSjbZMj6YKtCXbhJCMrxClnXx2+XAqP3/s3qqdDHY0cydreHrdNx9fzV+7TePdpqHrzoOWaK+tYFoTwimGW9sVEXgRXqw+GkA=
In-Reply-To: <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31404>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkAVK-00057Q-1Z for gcvg-git@gmane.org; Wed, 15 Nov
 2006 03:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754363AbWKOC1y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 21:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbWKOC1y
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 21:27:54 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:63992 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1754360AbWKOC1x
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 21:27:53 -0500
Received: by wx-out-0506.google.com with SMTP id s7so45380wxc for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 18:27:52 -0800 (PST)
Received: by 10.90.25.3 with SMTP id 3mr1856923agy.1163557672612; Tue, 14 Nov
 2006 18:27:52 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Tue, 14 Nov 2006 18:27:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I would kind of like to see "git poll" -- visit all remote branches,
fetching objects and tags into the local repository, so that I can
inspect changes off-line and merge, cherry-pick, etc. to my heart's
content.  That would fit the platform integrator's workflow nicely --
"git poll" into a tracking tree, do some merges there (such as
backporting a subsystem to a "stable" base kernel), then merge this
backport branch to each platform working copy and cherry-pick other
changes as necessary.

Cheers,
