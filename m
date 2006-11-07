X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to show log for only one branch
Date: Tue, 7 Nov 2006 09:08:52 +0100
Message-ID: <200611070908.53121.jnareb@gmail.com>
References: <454EAEDB.8020909@gmail.com> <eink3u$pmh$1@sea.gmane.org> <455001EA.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 08:08:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WJDVPV5OV2VYpS1kbwn3p62diZ8c6kxSXrAGx/zCitjkmfmk+QtZtiNUHLDZOOGOUDn74MYuKfZH9TKlCqKDoNXAg68YavPq05nZdSDUU+i7gBOljYY1vnRGstRR8+iH8+bHjcyL8C+I91lmUwdbFi9ioosullV7ctHI2dLTUBg=
User-Agent: KMail/1.9.3
In-Reply-To: <455001EA.5040306@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31052>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhM0J-0008Cc-9U for gcvg-git@gmane.org; Tue, 07 Nov
 2006 09:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754100AbWKGIIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 03:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbWKGIIQ
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 03:08:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:585 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754100AbWKGIIP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 03:08:15 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1134455ugc for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 00:08:14 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr8701700ugm.1162886894281; Tue, 07
 Nov 2006 00:08:14 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k1sm6130110ugf.2006.11.07.00.08.13; Tue, 07 Nov
 2006 00:08:13 -0800 (PST)
To: Liu Yubao <yubao.liu@gmail.com>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:
> Jakub Narebski wrote:
>>
>> Perhaps what you want is git log --committer=<owner of repo>?
>> 
> Thanks, it can't meet my requirement, if I create two branches
> and merge them, I can't easily tell the track of those two branches.

Use graphical history viewer then. git-show-branch, gitk (Tcl/Tk),
qgit (Qt), less used GitView (GTK+), tig (ncurses), least used 
git-browser (JavaScript). 

BTW. that is what subject line (first line of commit message) is for. 
Note the "gitweb:", "Documentation:", "autoconf:", "Improve build:" in 
the git log.


By the way, what is the status of the proposed "note" header extension 
to the commit object? One could store name of branch we were/are on, 
even though this is absolutely discouraged...
-- 
Jakub Narebski
