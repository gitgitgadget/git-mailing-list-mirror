X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/n] gitweb: Remove redundant "blob" links from git_difftree_body
Date: Fri, 3 Nov 2006 12:01:46 +0100
Message-ID: <200611031201.46991.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200610311707.43054.jnareb@gmail.com> <7v3b91jalp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 11:02:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CsUeea79bpPJAuk7Y9DDLq8uqZeU0hTFs2JsTg4dtmGbefKRpLeeKuDi0xAlIG/TEhscbz7BKCZeYq8eaqsLgFIX6rR6ItzhPH+Icl8K3pf6pNvxpGUa7PIXdhPQ14vzj6MGkw1QFbsxhyiGtr+hmgLiiqQEbODDGHEt7OhqxaM=
User-Agent: KMail/1.9.3
In-Reply-To: <7v3b91jalp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30825>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfwnf-0000iT-NI for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753215AbWKCLBY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbWKCLBY
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:01:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:55586 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753215AbWKCLBX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:01:23 -0500
Received: by ug-out-1314.google.com with SMTP id m3so373348ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 03:01:22 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr2478225ugh.1162551682391; Fri, 03
 Nov 2006 03:01:22 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e23sm754936ugd.2006.11.03.03.01.22; Fri, 03 Nov
 2006 03:01:22 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> ... First, it did that incompletely: it did not add "blob"
>> link for added files, and added block used mixture of tabs and spaces
>> for align. Second, in "difftree" view the "blob" link is not the most
>> interesting, *contrary* to "blob"/"tree" link in "tree" view, so it
>> should be enough to have hidden link in the form of file name entry.
> 
> I think these "blob" links are good thing to have, and if you
> think the earlier work was incomplete and know some cases are
> not covered I think it would be better to help completing it
> rather than reverting.
> 
> I do not understand why you feel "blob" is not the most
> interesting.  Often, when it is not obvious if a patch is
> correct only with the context, it is useful to view the whole
> postimage after applying the patch, and the "blob" link helps
> that.

O.K. I'll choose the "add blob links where there are none in difftree view"
approach in cleaned up and resend series.

I'll wait a while (a day or two) for further comments before redoing
the series.

P.S. Remove empty patches might produce incorrect HTML (one of <div>
is not closed). I'll correct it on resend.
-- 
Jakub Narebski
