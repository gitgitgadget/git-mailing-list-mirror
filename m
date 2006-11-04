X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Initial push to git+ssh://repo.or.cz/srv/git/git/jnareb-git.git fails
Date: Sat, 4 Nov 2006 12:51:07 +0100
Message-ID: <200611041251.07790.jnareb@gmail.com>
References: <200610291308.44653.jnareb@gmail.com> <20061104111340.GZ18879@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 11:51:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HOiWGpxroQJINdZcYmMy5H3emnmt+7SyNEvhNgVRpEDNT+nz996YcZTQVNcp67GkgY3NhrGD/sm2livaFCWOP1M/ExikXrup1p1TzCm1OoR7ZTSWpAcU5C0OOosO+qYhaaaWTGIFYV2ukAafK+GHzx5jQpj1zAtNf3EDYOVmMTo=
User-Agent: KMail/1.9.3
In-Reply-To: <20061104111340.GZ18879@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30920>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgK3H-00072x-Vz for gcvg-git@gmane.org; Sat, 04 Nov
 2006 12:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965326AbWKDLu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 06:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbWKDLu4
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 06:50:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:61123 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965326AbWKDLuz
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 06:50:55 -0500
Received: by ug-out-1314.google.com with SMTP id m3so587672ugc for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 03:50:54 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr4249841ugh.1162641053792; Sat, 04
 Nov 2006 03:50:53 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id s7sm2278749uge.2006.11.04.03.50.53; Sat, 04 Nov
 2006 03:50:53 -0800 (PST)
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis "<pasky@ucw.cz>" wrote

> On Sun, Oct 29, 2006 at 01:08:44PM CET, Jakub Narebski wrote:

>> And here it hangs...
> 
> This is because the unpacking takes really looooooooong time. :-(

That was because git-push didn't have progress report on uploading and 
unpacking.
-- 
Jakub Narebski
