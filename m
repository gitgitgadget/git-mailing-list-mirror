X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 16:35:09 +0100
Message-ID: <200610291635.09525.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com> <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 15:35:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=prd4QoLHvOCmPUh+VDnFxQ3ZHJ367nhx8r1rk6ex8foGzcjeyxJd/yMhFDqoG/Me0khFrZNWzoiLjwm6vk9+xnUvd9w87HHu0sG16ah0cgwNQDMKhhP3AN1zSmcfjneOQrd5Y55krCtEtY1pQ0bMa+qMf64A1cfbeeBpZwzET3g=
User-Agent: KMail/1.9.3
In-Reply-To: <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30432>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeCh3-00064w-KM for gcvg-git@gmane.org; Sun, 29 Oct
 2006 16:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751607AbWJ2PfT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 10:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWJ2PfT
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 10:35:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:52612 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751581AbWJ2PfR
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 10:35:17 -0500
Received: by ug-out-1314.google.com with SMTP id 32so986822ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 07:35:15 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr2683650ugj; Sun, 29 Oct 2006
 07:35:15 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id m1sm1813302ugc.2006.10.29.07.35.14; Sun, 29 Oct
 2006 07:35:14 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Changes:
[...]
>> * <file> hyperlinking should work also when <file> is originally
>>   quoted. For now we present filename quoted. This needed changes to
>>   parse_difftree_raw_line subroutine.
> 
> This feels Ok.

Emphasisis on "should". Check
  http://roke(.)dyndns(.)info/cgi-bin/gitweb/gitweb.cgi?p=git.git;a=commitdiff;h=gitweb/test

By the way, should we use quoted or unquoted filename?
-- 
Jakub Narebski
