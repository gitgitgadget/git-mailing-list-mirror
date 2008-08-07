From: "Anton Mostovoy" <git@mostovoy.net>
Subject: git svn throws locale related error when built from source
Date: Thu, 7 Aug 2008 10:33:59 -0500
Message-ID: <5C17B49DFD5F456B8701BE301F4B55A1@chi.orbitz.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 17:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR7WA-0002k0-LB
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 17:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYHGPeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 11:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYHGPeF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 11:34:05 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:13075 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYHGPeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 11:34:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so85881and.103
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 08:34:01 -0700 (PDT)
Received: by 10.100.120.6 with SMTP id s6mr2367907anc.106.1218123241682;
        Thu, 07 Aug 2008 08:34:01 -0700 (PDT)
Received: from AMOSTOVOYT60 ( [198.175.55.5])
        by mx.google.com with ESMTPS id m6sm13111410wrm.35.2008.08.07.08.34.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Aug 2008 08:34:01 -0700 (PDT)
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
Thread-Index: AcjsOfNYfcm4CrqoT06C29t9bKC2kgAGeF1gAFVHPEACjEOccAAyNmMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91586>

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
$ LANG= git svn rebase

Here is the output of the locale command:
$ locale
LANG=en_US.UTF-8
LANGUAGE=en-US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

 
Thanks in advance.
-Anton
