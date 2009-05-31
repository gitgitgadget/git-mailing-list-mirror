From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 20:31:50 +0100
Message-ID: <34D6982455BA4A7E9F5D2D467DC4A55C@HPLAPTOP>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP> <4A229B9A.6060807@dirk.my1.cc> <20090531162515.GB8129@m62s10.vlinux.de> <20090531163225.GE3674@debian.b2j> <9719867c0905310950x153db8efw179a8a10ac3f4640@mail.gmail.com> <20090531173932.GA13856@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Peter Baumann" <waste.manager@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Sebrecht" <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun May 31 21:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAqlK-0008FD-Lx
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 21:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZEaTby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbZEaTbx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 15:31:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:64342 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZEaTbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 15:31:53 -0400
Received: by ey-out-2122.google.com with SMTP id 22so362383eye.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=VC65vcTMnOt2ygvxcHTLnNMvD6H+chp9jxGyLKokiGw=;
        b=UnTgn02lL7Tspf9CneQQrqMwVMj7qiVNrgM10gibEZyIlhXhmNZ7aLRikW8DqxykRM
         0GuW5KOFlDshakHwhymrBQlfxpDSeHI0ZpeoS2epg6mlFPuKWKf8NpIxnOzcY2xpWqFf
         LaWUgis9kWVKvSEUze4ST3/bdqJ39P+PpVddw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=ZRpOqjRXua7ozB5IlhUBrPpXyjea3HBrYNSyNYr4cb7XrL9FQgXHiVlfMBgKCdw+Vd
         6FbC8JhfeZqYsUnW71evIVUK9xVj1e0B+9TTYojTEylENgls8NHU1tTBhDPHENVfkAkn
         KtaJ8thusJ4YPd8cIj4aPjJ65eTiipIWUWKDM=
Received: by 10.210.109.19 with SMTP id h19mr3079865ebc.45.1243798314175;
        Sun, 31 May 2009 12:31:54 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 28sm6302603eye.36.2009.05.31.12.31.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 12:31:53 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120425>

> The 31/05/09, Aaron Gray wrote:
>
>> > I still do not understand what index is.
>> > 1. is index an replica of the committed tree
>> > 2. is index only transient in that its content will be reset once
>> > committed?
>> > 3. or other ?
>>
>> I think index is HEAD or a revision hash. Am I correct ?
>
> HEAD is a reference to a branch name:
> $ cat .git/HEAD
> ref: refs/heads/master
> $
>
> The branch name is a reference to a commit:
> $ cat .git/refs/heads/master
> a80aad7b85fc560451e07792d64ab6cb15a39914
> $
>
> The index is what will be committed by 'git commit'.

Obviously alot more to learn about GIT, hopefully the O'Reilly book will 
clue me up as I am still getting problems with using GIT properly.

Thanks Nicolas,

Aaron
