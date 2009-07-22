From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git-svn wowes
Date: Wed, 22 Jul 2009 14:55:11 +0100
Message-ID: <025FAAA7CA644D709E1635C497753444@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 15:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTcI2-00008R-SL
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 15:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZGVNzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbZGVNzR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 09:55:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:20552 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbZGVNzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 09:55:16 -0400
Received: by ey-out-2122.google.com with SMTP id 9so114265eyd.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=2dgD79Ijrw8829mqZQ2coDuTY4z4JyBfL7i9bc35UkI=;
        b=gOLVYMYyREPwXP/TtqkgkmU6CnH1DKWSpTqxX/6crgkzgCLAimIaOwq1hrL3MRRWdf
         Fp+7psvl7XXxPBvk/3A3em5XF1wWyGYmpptIQkt4qS3D29H0LJ2ipJADSop8EaKd0ONh
         js0kG6YZ2c5bnaPBcmo2YG5DYJARvCmkJVDVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=BhAdtCFIH/k9t+UHIJmS6ihhb7xOsICkhXuvejEyTSoMdiSKe054/dt3LFz/cCukVM
         Hd298n5WA5vpoQ82w9L6xvCyhGORi7KhI5LyKVeDlrly6V0nqx5QClHftwPcEViztVvj
         xN9PDjYOcnEp07Yq0LHzRDrVrJqV/soVOFAoA=
Received: by 10.211.179.6 with SMTP id g6mr6664830ebp.49.1248270915002;
        Wed, 22 Jul 2009 06:55:15 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 24sm1633826eyx.33.2009.07.22.06.55.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 06:55:14 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123750>

Hi,

I have a working git-svn clone of a svn based project.

At the mement I have a .sh script run every hour which goes :-

    git svn fetch
    git reset -- hard HEAD
    git svn rebase

I am sure this is like using a hammer to crack a nut.

Is there a better way to do this ?

Many thanks in advance,

Aaron
