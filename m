X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Thu, 14 Dec 2006 18:55:57 +1300
Message-ID: <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 05:56:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NYd7t0oUrRq0rx72DifKlUkVejyiNT1tttKdJNwAMzVoeSolimL2QjzLEkk5HbrK+1BRIWWhqcAxpVnNGn/p/+MwPb81J0/pDLTZ+iQePzQcdh2mWRFJkhlkp8VOKdz9yI4vOTQDAhJWuPfhqD6JXCwjfJaJN9LRJ7gqHZI0L4M=
In-Reply-To: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34279>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GujZg-0002rC-Eh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 06:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751805AbWLNFz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 00:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWLNFz7
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 00:55:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:56132 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751805AbWLNFz6 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 00:55:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so732345nfa for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 21:55:57 -0800 (PST)
Received: by 10.49.55.18 with SMTP id h18mr196624nfk.1166075757254; Wed, 13
 Dec 2006 21:55:57 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Wed, 13 Dec 2006 21:55:57 -0800 (PST)
To: "Florian v. Savigny" <lorian@fsavigny.de>
Sender: git-owner@vger.kernel.org

Florian,

a bit of a long shot, but you might be able to access it via Samba,
and just use git on linux. I have to confess to having setup a few git
checkouts for Win32 users this way... in some cases with cygwin+x11
and a shortcut that will do something like

    ssh linuxhost gitk --all

or

    ssh linuxhost qgit

but then again, I'm rumoured to be insane...

cheers,


