From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git & ssh on F10 server
Date: Fri, 17 Apr 2009 16:56:16 +0100
Message-ID: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 17:58:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuqSJ-0007M5-Ep
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758057AbZDQP4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbZDQP4V
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:56:21 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47104 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZDQP4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:56:20 -0400
Received: by ewy24 with SMTP id 24so288859ewy.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=CQXuAvjEhcIZH/VSvyE6cSJf6bkRTwa1BaXv2arpGQE=;
        b=k/H0qq0eenlXk8OJp8vqDnQ3Uc7gdZIfBzPBJxp0U62/37I06liDCMWKaeVwihCc8X
         /D4URdJmp+vpR1yCecoaRSOi0kpsODS/LygU/1XYrc0pUoqcUsIVzkaApUGrYcsQTzjo
         8tDppkGWVXWxHg7XsHfcE4V7/G1po0S06cyAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=XoiY2PLOz9SJPKG3/mRdV+sCs34nC8dVHjkx8n5xb6Km2HseLHyrvsbUSyNBA902zL
         BfXq8UTFnD2GVDViGizP39Uhs05C3dy+WEkGRwMHCLvJPCCxBm0rxxPyBOfPIxpjhsxS
         38bUnIVj5ctio9VXp9nFg8TC+2oO3WLYRN9J8=
Received: by 10.210.41.14 with SMTP id o14mr819232ebo.8.1239983779341;
        Fri, 17 Apr 2009 08:56:19 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 28sm3778808eye.34.2009.04.17.08.56.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Apr 2009 08:56:18 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116752>

Hi,

we have a Fedora 10 server in SELinux enforcing mode setup running 
git-deamon and gitweb (with home grown SElinux policy).

Anyway now we find out you cannot do a 'push' over the basic git protocol, 
back to the server repository.

So now am trying to get git to work over ssh. The repositories are located 
/pub/git/*/.git

Basic attempts using BerliOS'es instructions for client end failed.

    http://developer.berlios.de/docman/display_doc.php?docid=1812&group_id=2

Could someone please help us with this.

Aaron
