From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git svn fails to work
Date: Sat, 28 Mar 2009 17:48:39 -0000
Message-ID: <EA1460555FA0423EB6C233B3B0F4F098@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 28 18:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lncfi-0006c9-8Z
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 18:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbZC1Rst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZC1Rss
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 13:48:48 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:41245 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbZC1Rsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 13:48:47 -0400
Received: by ewy9 with SMTP id 9so1488261ewy.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=t/e5YCrXrHO5Cxei3c7OT1LiBEmmzu9wNKeEOdTOLxw=;
        b=HZKk2KPe1TSB6Uy4BWrQkNSrRlzCTAQ79scCTNO2VSjNrNUTVgmdDCiMkP8qf5bAry
         1EaqL1Utq4P9oM9wBP2hm11RZiWRhsa1vyBz2BDnYUgweh/btGkrZhh8hg3e3QfWjqHJ
         QcV48126hypynNB9l1gbVKOHx+Ld4mhyaTtGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=e+4HcNMY4vlmLP69qcDFX2E27KYXN1LF4pNT2RFny3ZVffz9CflymmhlCfG6WoheZ4
         2lu0qjDTbufC+Uyti8eYCJeySbCX52Ua4xKNToeX8mbAeW50lEEAP4CoockUURKJF7nw
         IOG+miCKasAg2+/edtfCWnjgLuxBbFztNmOBU=
Received: by 10.210.53.5 with SMTP id b5mr1158504eba.90.1238262525079;
        Sat, 28 Mar 2009 10:48:45 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 23sm3404688eya.16.2009.03.28.10.48.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 10:48:44 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114972>

I have been tying for a week to get git svn to work. If i do a 'git clone' 
and if falls over 'git svn fetch' picks up from where it left off, but on 
completion I can only see the older stuff if at all and a 'git clone rebase' 
eithr shoud up unreconsilable differences or refuses to execute the command 
at all, gust giving uphelpfull help afaics.

Does anyone have a real work how to for git svn ?

Otherwise I am giving up and either going back to svn or over to mercurial.

Aaron
