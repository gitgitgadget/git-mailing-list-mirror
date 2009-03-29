From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Owners
Date: Sun, 29 Mar 2009 15:00:31 +0100
Message-ID: <DD0015EE77F44D48A8A3835D901CF52A@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 16:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnvbB-0003fc-DN
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 16:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbZC2OAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 10:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbZC2OAj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 10:00:39 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:48374 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbZC2OAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 10:00:38 -0400
Received: by ewy9 with SMTP id 9so1705138ewy.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=hGkcDQWlQr/emAhgBnRafMpJB0c+zunqeQc85TRBoFY=;
        b=mPZiW4tYJV1JPp2sONmhkqhzLyxmsv5aRCMZzRODHvWkzJhEvrz8MFsUIYXNB5BDJs
         uTmgrtmArhwuVO/31qtNxhc6V8EwuJs8jSYI9FiHMyWK7rx/aolFFcG+1YIIuAyVceGY
         h4lgF37RUf5D/+czpNS6+ZAZaEvn65Bo9d0GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=aMiAVwpv8ANqLGbUBEHr45ia4Q+xNECvWCIAgrdtc5XDzwo3ecyyxI51XsEgVRsiBb
         ver7elDxicQeM/X14kYLZ84HrctrioKIfYKHHWNcX6gG7i5qi+2qBNwH/LSjkxvq4Y3z
         d1eegJwvdfNFOGaEGAW5oAysYqnG9wri3Og/k=
Received: by 10.210.127.13 with SMTP id z13mr1800096ebc.91.1238335236009;
        Sun, 29 Mar 2009 07:00:36 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 10sm4451698eyd.33.2009.03.29.07.00.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 07:00:35 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115027>

Okay, I seem to have a normal operations now :-

    git svn fetch
    git reset --hard HEAD
    git svn rebase

Seems to do the job, thanks.

I am wondering what is going on with users, the ones that were accidently 
written as root are showing root as their owner, where as others under the 
user name git is not showing this in the owner field.

If someone could please fill me in in this area.

Many thanks in advance,

Aaron
