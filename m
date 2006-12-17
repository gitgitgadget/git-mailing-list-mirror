X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sun, 17 Dec 2006 15:33:58 +0100
Message-ID: <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 14:34:16 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CeX3U4KixDEf6KLeaGboUtFsLPth5VKdOpFfHd+J3UzBUiEKxTAhUnSpry99R24wxjOJRLJI4QdVCVQqEuFCg2atuE7DykDq4TxckXKXKOzyq9RyEN7K731jadF9uKV6pdE4JRbxNqr9K+xlgqB8EqIqTdMPTS/AaL4UBR+vR2k=
In-Reply-To: <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34690>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvx5e-0002Ga-4u for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752717AbWLQOeA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbWLQOeA
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:34:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:18990 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752717AbWLQOd7 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 09:33:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1678836nfa for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 06:33:58 -0800 (PST)
Received: by 10.49.75.2 with SMTP id c2mr3314924nfl.1166366038380; Sun, 17
 Dec 2006 06:33:58 -0800 (PST)
Received: by 10.49.14.13 with HTTP; Sun, 17 Dec 2006 06:33:58 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

I just tried to use git writing to my FAT32 formatted usb stick.

On windows XP, I compiled git with and without NO_D_TYPE_IN_DIRENT,
but after the
following actions I always got the error "fatal: Unable to write new
index file" or
"fatal: unable to create '.git/index': File exists":

mkdir git-test-repo
cd git-test-repo
git-init-db
echo iii>test
git add test
git commit -m "test msg"
echo ooo>test1
git add test1 ***error***

converting the stick to NTFS I have no problems.

any hint ???

---
