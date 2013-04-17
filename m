From: Alexander Tomlinson <alex@aivor.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Tue, 16 Apr 2013 23:37:36 -0500
Message-ID: <278B6790-7EDC-4E7F-A944-B00A6AEE86F2@aivor.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 17 06:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USK7j-0006DW-K6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 06:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab3DQEhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 00:37:31 -0400
Received: from smtp-out2.electric.net ([72.35.23.38]:56820 "EHLO
	smtp-out2.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab3DQEha convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 00:37:30 -0400
Received: from 1USK7c-0004jn-T7 by cernan.electric.net with emc1-ok (Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1USK7c-0004kW-Uk
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:37:28 -0700
Received: by emcmailer; Tue, 16 Apr 2013 21:37:28 -0700
Received: from [10.86.10.83] (helo=fuseout2c)
	by cernan.electric.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1USK7c-0004jn-T7
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:37:28 -0700
Received: from mailanyone.net
	by fuseout2c with esmtpsa (TLSv1:AES128-SHA:128)
	(MailAnyone extSMTP aivort)
	id 1USK7b-0005UJ-Pt
	for git@vger.kernel.org; Tue, 16 Apr 2013 21:37:28 -0700
In-Reply-To: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com>
X-Mailer: Apple Mail (2.1503)
X-Outbound-IP: 10.86.10.83
X-Env-From: alex@aivor.com
X-PolicySMART: 1102869
X-Virus-Status: Scanned by VirusSMART (c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221501>

Sorry about the =3D escapes.  My first attempt to submit bounced b/c it was html and I missed
cleaning some escapes.  The snippet should be:

    if type_base == "symlink":
        git_mode = "120000"
        # p4 print on a symlink contains "target\n"; remove the newline
        data = ''.join(contents)
        contents = [data[:-1]]


--Alex
