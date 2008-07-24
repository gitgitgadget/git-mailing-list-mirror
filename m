From: "Anton Mostovoy" <a@mostovoy.net>
Subject: git svn throws locale related error when built from source
Date: Thu, 24 Jul 2008 11:49:52 -0500
Message-ID: <5FD07FB3AABE444EBC082117C401BEA4@chi.orbitz.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM41o-000525-QR
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYGXQt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYGXQt5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:49:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:13637 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbYGXQt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:49:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1257026ywe.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 09:49:55 -0700 (PDT)
Received: by 10.65.53.3 with SMTP id f3mr915479qbk.27.1216918194215;
        Thu, 24 Jul 2008 09:49:54 -0700 (PDT)
Received: from AMOSTOVOYT60 ( [198.175.55.5])
        by mx.google.com with ESMTPS id f45sm13378662pyh.42.2008.07.24.09.49.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 09:49:53 -0700 (PDT)
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcjsOfNYfcm4CrqoT06C29t9bKC2kgAGeF1gAFVHPEA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89906>

Hi

I built git 1.5.6.3 manually (no package with 1.5.4+ on gutsy), and I am
getting the error below when running 'git svn rebase'. 
svn works fine on its own though.  
The default locale is set to en_US.UTF-8

svn: error: cannot set LC_ALL locale
svn: error: environment variable LANG is en_US.UTF-8
svn: error: please check that your locale name is correct

I found a workaround that works, but it would be nice to have it work
properly.
$> LANG= git svn rebase"

Thanks in advance.
-Anton

P.s. I am sending this again, because I did not find the message on
http://dir.gmane.org/gmane.comp.version-control.git
