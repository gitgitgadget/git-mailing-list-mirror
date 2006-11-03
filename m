X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Fri, 3 Nov 2006 11:49:59 +0100
Message-ID: <200611031149.59329.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <7vhcxhjbog.fsf@assigned-by-dhcp.cox.net> <7vlkmseutr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:50:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z/gGzEsIAqOrKlU/OXdXNwPAA8J8Nd2vfu+BNhdU/Qqwep2+tl/9yQaZszIj6iM5NwmbTBO6ROnwpCnokyesApOF8A2gk+PWAogj6Ce2Jl562+pFy/1OO4UTz9jTNXdjX5Ja3XtfzPI0zuskqyKFvtIMwBkr5PyxBiQkzRZUDLg=
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkmseutr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30819>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwcR-00061N-0r for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752874AbWKCKtm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbWKCKtm
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:49:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44516 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752874AbWKCKtl
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:49:41 -0500
Received: by ug-out-1314.google.com with SMTP id m3so370894ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 02:49:40 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr2446828ugl.1162550980085; Fri, 03
 Nov 2006 02:49:40 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id o1sm676611uge.2006.11.03.02.49.39; Fri, 03 Nov
 2006 02:49:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
>> I'd see if I can add some constructive comments on patches 5-10
>> tonight, but I'm in the middle of other things so don't hold
>> your breath ;-).
> 
> 7 and 9 look obviously good, so I've applied them without
> others.
> 
>         gitweb: Output also empty patches in "commitdiff" view

This patch in my opinion has no sense without having extended diff
header in commitdiff view, i.e. without "New improved patchset view"
(I have send non-line wrapped version).

>         gitweb: Better support for non-CSS aware web browsers

Thats independent from other changes, true.

> 5 is terminally linewrapped and rather big to comment on without
> comparing pre- and post- patch outputs, so I'll refrain from
> commenting on it. 

You can check out new gitweb at work at my site (when it is up)
  http://roke . dyndns . info/cgi-bin/gitweb/gitweb.cgi

>                    8 is "oops, I made a mistake when I did 5", 
> which discourages me even more from looking at 5 X-<.

Well, you wouldn't notice error corrected by 8 unless you have
files with funny filenames.
-- 
Jakub Narebski
