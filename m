From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 11:14:52 +0100
Message-ID: <492BD01C.8070807@viscovery.net>
References: <492BC56A.6040506@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4uxo-0002F8-9G
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 11:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbYKYKO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 05:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYKYKO4
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 05:14:56 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54551 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYKYKOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 05:14:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L4uwX-0005Gl-1K; Tue, 25 Nov 2008 11:14:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C972369F; Tue, 25 Nov 2008 11:14:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <492BC56A.6040506@xmos.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Luis Gutierrez schrieb: > At my company we have been using
	git for the past months, and except for > a few people, everyone is happy
	with it. Last week, we discovered that > the mac version of git was misbehaving
	(v1.5.6.4), but upgrading the > client to the latest one (v1.6.0.4) fixed
	the issue. Fearing consistency > issue between version, I decided to update
	the version of the central > repository (ie, the place were people can go
	and synchronize their code) > on a RHEL4 box from 1.5.6.4 to 1.6.0.4. > went
	to my git directory, pulled, checkout v1.6.0.4, and compiled with > 'make
	--prefix=/usr/loca/ all' and installed with the same comamnd. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101655>

Luis Gutierrez schrieb:
> At my company we have been using git for the past months, and except for
> a few people, everyone is happy with it. Last week, we discovered that
> the mac version of git was misbehaving (v1.5.6.4), but upgrading the
> client to the latest one (v1.6.0.4) fixed the issue. Fearing consistency
> issue between version, I decided to update the version of the central
> repository (ie, the place were people can go and synchronize their code)
> on a RHEL4 box from 1.5.6.4 to 1.6.0.4.
> went to my git directory, pulled, checkout v1.6.0.4, and compiled with
> 'make --prefix=/usr/loca/ all' and installed with the same comamnd.

It's not necessarily the cause of your problems, but didn't make install
warn you:

        !! You have installed git-* commands to new gitexecdir.
        !! Old version git-* commands still remain in bindir.
        !! Mixing two versions of Git will lead to problems.
        !! Please remove old version commands in bindir now.

Did you do as you were told?

-- Hannes
