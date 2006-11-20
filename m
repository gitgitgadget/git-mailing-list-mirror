X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Rename detection at git log
Date: Mon, 20 Nov 2006 11:57:23 +0600
Message-ID: <200611201157.23680.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 05:57:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xp981TkBnVAuwm7glcYWrfqhkf1ZTcGhOjrrrp0BDqYSvugPwzyqMED5EUTanqOiUL+n01blBv8PsRVQLDGVB4PC30JWh0+5YIR1J4XPx6F7RdxXP/vERgbRxCWyvmyhtDuAcIaoG0ueBICjN2YfqlVY0WAPGhd0ZgaVCjCAW8g=
User-Agent: KMail/1.8
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31882>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm29w-0006oU-LT for gcvg-git@gmane.org; Mon, 20 Nov
 2006 06:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933941AbWKTF5d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 00:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933942AbWKTF5d
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 00:57:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:12244 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933941AbWKTF5d
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 00:57:33 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1102789ugc for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 21:57:31 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr7224064ugm.1164002251610; Sun, 19
 Nov 2006 21:57:31 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2]) by mx.google.com with ESMTP id
 w40sm3806088ugc.2006.11.19.21.57.30; Sun, 19 Nov 2006 21:57:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

How can I see all changes for one file ? Including renames/copies ? Currently 
I don't known how to see them :

> mkdir 1 && cd 1 && git init-db
defaulting to local storage area
> date >> a
> git add a
> git commit -a -m "1"
Committing initial tree c47d83a6544612309aad57519ca831cf62a489d5
> mkdir b
> git mv a b/
> git commit -a -m "2"
> PAGER=cat git log -M -C --pretty=oneline b/a
3b591f7147ee8dbe15fdf456db5730072d41bed8 2
>

At lastline I would like to see two commits : renaming a -> b/a and creation 
of a. By the way, how can I see commit message with git log ?

Thanks for help.
