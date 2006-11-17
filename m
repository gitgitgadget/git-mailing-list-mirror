X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 18:41:43 +0100
Message-ID: <200611171841.44379.jnareb@gmail.com>
References: <87hcx1u934.wl%cworth@cworth.org> <ejkdhv$vog$2@sea.gmane.org> <87y7qahvbp.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 17:40:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GqXiG7jbIWm5pQqre55HmZqVgDyK0Px3w04tLSVSynUUFWAc5o3NtuDcd7khC6MDjSHgQwSJ3p+qHFCtEkwedtwfxvPIs7Jsf7WVUVzc6/OrpgBXT47NIl/FApLalicakOtqYC3Qjs9GTN8/yHpLvuOkrzPMUyLUZ9EpQ3ZLzdY=
User-Agent: KMail/1.9.3
In-Reply-To: <87y7qahvbp.fsf@wine.dyndns.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31717>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7hY-0000k9-G2 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933026AbWKQRkY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933027AbWKQRkY
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:40:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:21490 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933026AbWKQRkX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:40:23 -0500
Received: by ug-out-1314.google.com with SMTP id m3so765515ugc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 09:40:21 -0800 (PST)
Received: by 10.67.119.13 with SMTP id w13mr3031463ugm.1163785221756; Fri, 17
 Nov 2006 09:40:21 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id s7sm4294677uge.2006.11.17.09.40.21; Fri, 17 Nov
 2006 09:40:21 -0800 (PST)
To: Alexandre Julliard <julliard@winehq.org>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Alexandre Julliard wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Alexandre Julliard wrote:
>>> Junio C Hamano <junkio@cox.net> writes:
>>> 
>>>> I would rather say "use 'git branch' to make sure if you are
>>>> ready to merge".  Who teaches not to use "git pull"?
>>> 
>>> We do that for Wine. The problem is that we recommend using git-rebase
>>> to make it easier for occasional developers to keep a clean history,
>>> and rebase and pull interfere badly.
>>
>> What about proposed (and I think not accepted) merge strategy
>> "rebase" (formerly called "subordinate" or something like that)?
> 
> That sounds very interesting. Has it ever been implemented, or only
> discussed?

There was some implementation with warts

  http://thread.gmane.org/gmane.comp.version-control.git/30068
  Message-Id: <20061025155009.GD5591@parisc-linux.org>

which didn't got corrected and resent.
-- 
Jakub Narebski
