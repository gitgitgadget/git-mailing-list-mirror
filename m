From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Advice wanted to set up GIT repository manually sync'ed form SVN
Date: Wed, 18 Mar 2009 20:46:11 -0000
Message-ID: <79BA5EFC11BE4E06A78D39D06D1549AF@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 21:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2g2-00051F-Bq
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 21:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZCRUqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZCRUqU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 16:46:20 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:61715 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbZCRUqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 16:46:19 -0400
Received: by ewy9 with SMTP id 9so188882ewy.37
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=iZ1r/MjYRcFuKAAyioVi8eYprjsoPJd7YF9/P72FZok=;
        b=XvFJAniOK+lX80WM6o7vxvRef2MfpYKjZBY5c4jcNzoXM9CLSA08n5LfIFItCyqF9v
         Qu3eePveo4wj6MGP4Mm9RFQnMwrUSul5De3ifKIb6rP4afXLDczLDcA/t6M92C/lISxh
         aqhxzSPjkMxyVUY5/fLtOhRSQCCZo8JuyZwew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=dz6h3+6COzJ4KMlrhc8ZFsjZls5uNX5322hWexdiF8WsIUtJyGvLFm3wKDeRrPKH4V
         hvu6a1NM2r1krZsl84YXDlRAdFEs0vBrl9eZWJ7EjOF2UfIDC+TEvUXE9GpHoFWewSAL
         RrzkqvF+ZG9v4ilTWWqsv4d/D9OsgUNfCsBEE=
Received: by 10.216.10.82 with SMTP id 60mr788265weu.180.1237409176266;
        Wed, 18 Mar 2009 13:46:16 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 35sm822744nfu.47.2009.03.18.13.46.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Mar 2009 13:46:15 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113660>

Hi,

I am a realitive GIT newbie, ie I have not used GIT on a project but have 
read quite a lot of documentation on it, over the last year or so.

We are wanting to have a git and git-web repository that is synced to a main 
SVN repository, wh only want to read the SVN repository at this stage. I am 
planning on using git-svn raw, and do fetch'es by hand.

Is there any advice that I should know at this point before proceeding ?

Many thanks in advance,

Aaron
