From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git-svn and --bare repositories
Date: Wed, 22 Jul 2009 21:48:12 +0100
Message-ID: <F624E89E52304371B3CCFB737F9324DD@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTik5-0004Xa-DO
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 22:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbZGVUsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 16:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbZGVUsS
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 16:48:18 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:35199 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZGVUsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 16:48:17 -0400
Received: by ewy26 with SMTP id 26so534513ewy.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=2ZoEmPKE5zZiNECJXHrot9yD9+iw4FbdLn+URtwG2QQ=;
        b=HJUhcTuZVPy592CeIUEYG6EGh8bMfyGyWickMuUEzNK89/SkUu1eTEtV1Ij83p6Rwu
         n62OUf/+y6p32Oh4PRIHOnwvq1V5BuownAxZnoP09aHYRkdTnp9o8aWHlYJ6hS3YmmVq
         CUxWEClmUr1SKy/SuV39re2fO3iAGygwPfySs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=Rfq6X9av+A3vjHvwDxckXJZQd5phdL03EESd2DWKal1PsnaIeN2HtuFU9KHA14E82z
         1i+Lrmv21xSHauxvFmy/ZhfJ/Am6VOYka261jQ7gbHIMCbQiZer5jMU/EDwI8qIew0Jy
         L5ddJAx+fwIdGQX4oUKUXxkeXFhXx7fJSy7I8=
Received: by 10.210.144.8 with SMTP id r8mr5241046ebd.36.1248295696534;
        Wed, 22 Jul 2009 13:48:16 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 5sm2125708eyf.38.2009.07.22.13.48.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 13:48:15 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123773>

How do I do a git svn fetch to a bare test.git repository created with :-

    git --git-dir test.git --bare init --shared=true

I have tried :-

   git --git-dir test.git svn fetch http://test.org/git/test

and

   git --git-dir test.git/svn svn fetch http://test.org/git/test     /// 
fictious address :)

but neither work.

As you may guess I am not really sure what I am doing here.

Many thanks in advance,

Aaron
