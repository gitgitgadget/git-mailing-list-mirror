From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 16:57:48 +0100
Message-ID: <D457E686769D44D8BE5DDC26FEEA4AE3@HPLAPTOP>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP> <4A229B9A.6060807@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?iso-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun May 31 17:58:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnQn-0002Tx-5K
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 17:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbZEaP54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 11:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbZEaP5z
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 11:57:55 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42213 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbZEaP5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 11:57:54 -0400
Received: by ewy24 with SMTP id 24so7320679ewy.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=5UksYyYDdESM886ZSEG9oVwjlbioTmgqwtxdQ36bh1I=;
        b=ALkXZ/UCH8g3Cj8N2SpMJaHD0i1QQf8K42lH0Y5w8Fjw3MsMzLLd93kxvQgU4VohJk
         EhWJ+MDDJOBcq8/3uDQGWG9FaiO0WQj2chu864i2HrZ28nz6jZnM9rIQ6aX0yIt2I7bx
         R+od0IuBKd8jrAHU/WoTxd3phHoCLxBQqLc9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=L8DabMDu2fQ5UE1e/lFVGb0eL1rWXAy3V/LUMLXcOg7o6lReNzbRcgdktYThbJdwYo
         eR8Aq4f2Op/ScRzG8pTnXmS+P0vSeWPRBBxVIXTZQ9r+G7RM2tg6mmBwWKri8LV2c6h2
         EorPn55oUHHmDwCHtHtyDfVmtadKcgdcWGMYE=
Received: by 10.210.43.10 with SMTP id q10mr2835277ebq.98.1243785473628;
        Sun, 31 May 2009 08:57:53 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 5sm6031272eyf.48.2009.05.31.08.57.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 08:57:52 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120406>

> Am 31.05.2009 15:09 schrieb Aaron Gray:
>> Hi,
>> 
>> How do I reset the working files back to HEAD ?
>> 
>> Many thanks,
>> 
>> Aaron
>> 
> 
> $ git reset --hard
> 
> This will revert all changes you made in your working tree back to the 
> HEAD. It will delete your changes made so far. To revert only a single 
> file, use
> 
> $ git checkout -- path/to/file

Great thanks alot Dirk, you anticipated my second question too :)

Cheers,

Aaron
