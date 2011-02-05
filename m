From: Thomas Koch <thomas@koch.ro>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sat, 5 Feb 2011 19:31:10 +0100
Message-ID: <201102051931.10979.thomas@koch.ro>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <m3zkqe8xc8.fsf_-_@localhost.localdomain>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlnJS-0005qo-A9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab1BES4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:56:44 -0500
Received: from koch.ro ([88.198.2.104]:55399 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab1BES4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:56:44 -0500
X-Greylist: delayed 1523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Feb 2011 13:56:44 EST
Received: from 149-128.76-83.cust.bluewin.ch ([83.76.128.149] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1Plmum-0003tL-Hb; Sat, 05 Feb 2011 19:31:20 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.32-4-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <m3zkqe8xc8.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166111>

Jakub Narebski:
> there is (supposedly) problem when checking out such tree (see email
> referenced above) with an old git.
Proposal:

- Implement the possibility to checkout/read/handle empty directories as soon 
as possible, even in the next 1.7.x release.
- Don't implement the possibility to create/commit empty directories yet.
- Implement the possibility to checkin empty directories next year, but allow 
it only, if the user knows that this breaks backwards compatibility of the 
repo. (Generate warning and require --commit-empty-directories option)

Sorry if this should be crap. I'm not a GIT dev.

Best regards,

Thomas Koch, http://www.koch.ro
