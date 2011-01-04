From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] gitweb: make logo optional
Date: Mon, 3 Jan 2011 23:02:06 -0600
Message-ID: <20110104050206.GA8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 06:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZz2Q-00087e-Am
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 06:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab1ADFCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 00:02:22 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63399 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab1ADFCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 00:02:21 -0500
Received: by gwj20 with SMTP id 20so6411464gwj.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 21:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=w6zNwtsHFrJnnOW0U7azoCuUIa28/fL9FZtW/mjBffc=;
        b=krHcJTSL+e2Ec5doYWJcXWH47YGsakgjR9FBOPy6A5O0YXE9+F1K1ksM2D+LOSj8NX
         iE+RREdvcKeUw1pScXltAvrsNnqIqIXBiuHtlyfZpfBYVGTwQ2EzQFQPV5cuytF8ofOO
         yT5zolKWhH+mEV7GfYtzK2e7MY/gcuj6gPVa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=JapuARMLj+VoJl0EiJ3BOXhpWSrARpyLg4MlvA2qKgAxtekgSZge3BmTxvjFwCx2y5
         y4YcvsKXZt07tZ6qpUhH9Zhb1jK+OJR2Q3zcLfnRh2nC2NDk9pspXklAW6Lu/EcFkJvj
         l6n0e/ru8kafA5YsNq+zwJo/MpV8FEhjMqri0=
Received: by 10.90.100.5 with SMTP id x5mr13424450agb.28.1294117339824;
        Mon, 03 Jan 2011 21:02:19 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id c30sm29049507anc.20.2011.01.03.21.02.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 21:02:18 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164475>

These patches were last seen in the instaweb 1.7.1 maintenance
thread[1] but I believe they are independently useful.  The
idea is to allow disabling the logo in gitweb.

Jonathan Nieder (2):
  gitweb: skip logo in atom feed when there is none
  gitweb: make logo optional

 gitweb/gitweb.perl |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/155224
