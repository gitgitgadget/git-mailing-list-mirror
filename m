From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: how to get 'git diff' to output patch to file
Date: Thu, 14 May 2009 12:52:12 +0100
Message-ID: <93C432AD0B8F4D25A19E0D67C535376A@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 13:52:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ZU9-0007wn-6f
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 13:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbZENLwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 07:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbZENLwP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 07:52:15 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:58537 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbZENLwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 07:52:14 -0400
Received: by bwz22 with SMTP id 22so1233046bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=/BFjbQ3XLIpCNsS4EvwKMj5S1naiaJ8PPRzBNwbA7dA=;
        b=ryss3TJZoCvysXCDJy1On0VWCYzo76YO0lza7IT+Es8gC+uof78KegdC6GMpOOtp0h
         8GACLs9X6qG6sL0m3jOpOOedJBrk/JOWgB4f5GSIyecuTKFDvtz1x1z5KX4wWr4oasrc
         DdXIC5/WRp0yFYgHpKPnGdRA13Td/cHgo+cLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=ZdjTeqLXd1dEaLICtBoPftf7Iw2z9LRvgFY1Ep1ELr5Kf2VqwEukxOUz/qGvWrJpeS
         HPx6q8khMr9fV8Sw2h3rhkfkMY8wYgc2qIVe7S1b9Ut2qJTSylljdxMsB4YRX4y+6uEM
         w9I7rxj4ZBFVKGx+vTRULiFX5+onSbeQ8a15Q=
Received: by 10.103.175.8 with SMTP id c8mr1488449mup.117.1242301934733;
        Thu, 14 May 2009 04:52:14 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id t10sm45091muh.30.2009.05.14.04.52.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 04:52:14 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119181>

How do I get 'git diff -u' to output to a file or standard out instead of 
its viewer ?

Many thanks in advance,

Aaron
