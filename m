From: "P Fudd" <pfudd@mailinator.com>
Subject: [BUG] Hardcoded python and install on solaris
Date: Wed, 12 Dec 2012 14:34:39 -0800
Message-ID: <1870c3d3587281b436cddb33cca1e822.squirrel@www.pkts.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 00:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivHs-0003xn-I0
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab2LLXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:00:05 -0500
Received: from mail.sbn.ubc.ca ([142.103.124.7]:44463 "EHLO foster.nce.ubc.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179Ab2LLXAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:00:04 -0500
X-Greylist: delayed 1513 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2012 18:00:04 EST
Received: from foster.nce.ubc.ca (localhost [127.0.0.1])
	by foster.nce.ubc.ca (8.14.4/8.14.4) with ESMTP id qBCMYdrE016310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:34:39 -0800
Received: (from apache@localhost)
	by foster.nce.ubc.ca (8.14.4/8.14.4/Submit) id qBCMYdMe016306;
	Wed, 12 Dec 2012 14:34:39 -0800
Received: from 208.81.212.224
        (SquirrelMail authenticated user chowes)
        by www.pkts.ca with HTTP;
        Wed, 12 Dec 2012 14:34:39 -0800
User-Agent: SquirrelMail/1.4.20-2.fc11
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-1.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FREEMAIL_FROM autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on foster.nce.ubc.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211408>

Hi;

When compiling git-1.8.0.2 on a moderately old OpenIndiana machine, I had
to install a few things (m4, autoconf, coreutils, xz, python).

Even though I started the configuration fresh (make distclean; configure),
the makefile still wanted to use /usr/bin/python (instead of
/usr/local/bin/python) and /usr/usb/install (instead of
/usr/local/bin/install).

Thanks for a great SCM!
