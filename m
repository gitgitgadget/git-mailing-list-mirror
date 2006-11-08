X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: New improved formatting of chunk header in diff
Date: Wed, 8 Nov 2006 22:55:03 +0100
Message-ID: <200611082255.03617.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <200611082158.43652.jnareb@gmail.com> <7vzmb1r4yu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 21:54:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OMRCESPvIMlvdDH53YhOOGNn1VsrBcVEUIK5jWsvFZVchfU1uXHBuq2IYkk37Lg66r03zJooXY/ql+TNn/ZoHvo15GaISyXmc4EcVH0fOKFKrMTuPzM1iyZ13pNnjGwiLouNWs3in2AgAScf2bGBLFTJiawAN3OACM+u2rI6LDg=
User-Agent: KMail/1.9.3
In-Reply-To: <7vzmb1r4yu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31161>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhvNG-0003hE-Ag for gcvg-git@gmane.org; Wed, 08 Nov
 2006 22:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754606AbWKHVyS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 16:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbWKHVyS
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 16:54:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:32265 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754606AbWKHVyR
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 16:54:17 -0500
Received: by ug-out-1314.google.com with SMTP id m3so38206ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 13:54:15 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr194765ugh.1163022855151; Wed, 08
 Nov 2006 13:54:15 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id l33sm1260263ugc.2006.11.08.13.54.13; Wed, 08 Nov
 2006 13:54:13 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> O.K. This one introduced new feature, and wasn't needed for earlier 
>> accepted patch (output empty patches) to have sense. And it is rc1 
>> phase...
> 
> I personally do not mind minor gitweb 'feature' updates in -rc
> cycle, just like I am planning to see if there are gitk updates
> I haven't pulled from Paulus (I think there is at least one
> patch from last month or so), unless the changes do not break it
> so badly.

I'll resend corrected patch then...
 
>> By the way, where I can find proper specifiction of unified diff format? 
>> Do I understand correctly that bot from and to ranges can be without 
>> number of lines part if it simplifies to 0?
> 
> When Linus did apply.c and I did diff.c, we primarily worked off
> of sources to GNU patch.
> 
> There is a POSIX draft proposal now.
> 
> http://www.opengroup.org/austin/mailarchives/ag-review/msg02077.html
> 
> See also updates about the proposal.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/29331/focus=29389

Thanks a lot.

Personally I think that we should push for git extended headers to be
(as an option) in POSIX for unifed diff... well, with the exception
of index and similarity lines. ;-)

-- 
Jakub Narebski
