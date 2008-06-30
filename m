From: Thomas Koch <thomas@koch.ro>
Subject: how does git svn work
Date: Mon, 30 Jun 2008 21:57:32 +0200
Organization: Young Media Concepts
Message-ID: <200806302157.32828.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDPWq-0001Qg-Ak
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbYF3T6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbYF3T6S
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:58:18 -0400
Received: from koch.ro ([195.34.83.107]:40957 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932528AbYF3T6R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 15:58:17 -0400
Received: from 225-18.203-62.cust.bluewin.ch ([62.203.18.225] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1KDPVP-0006ux-NV
	for git@vger.kernel.org; Mon, 30 Jun 2008 21:57:45 +0200
Content-Disposition: inline
X-Spam_score: -2.3
X-Spam_score_int: -22
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86936>

Hi,

is there a document explaining the internals of GIT-SVN? I'd like to
know, which SVN commands are executed in the background and how git-svn
recognizes branch creation in SVN.

In particular I want to follow the repository at:
http://pubsvn.ez.no/nextgen/

The layout is like
/trunk
/stable
  |- 4.0
  |- 3.9
  |- 3.8
  ...
/releases
  |- 4.0
  |- 4.0r1
  |- 3.9
  |- 3.9r1
  |- 3.9r2


I do not know, whether git-svn can create branches automatically for
each directory under /stable and one main branch for trunk or whether I
need to create one svn-remote definition for every svn directory I want
to track.


Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
