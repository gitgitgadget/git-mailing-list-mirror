From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 15:58:35 +0200
Message-ID: <4BFD290B.6050502@drmicha.warpmail.net>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Walker <PWalker752@aol.com>
X-From: git-owner@vger.kernel.org Wed May 26 15:59:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHH9D-0000oP-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 15:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab0EZN7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 09:59:24 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36799 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755096Ab0EZN66 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 09:58:58 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 30FF5F8713;
	Wed, 26 May 2010 09:58:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 26 May 2010 09:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dd+JxkUYZVfU/rgvgsjZPU2HzmY=; b=HzHasIEdFaQbU9UOUGRo4RS/miJh9q5cRIrnekcVgHbU51K6qL13QZ4y4mFiYPk7VdU9DYVj/SEUQSDCCyvJclYUfTFMJzvcW3dyeqehvvlBcr1G8b6Y4Jll8Ejlxegu5ELICzcUKIPrA5vPBar2GyeNVFLT8YwiqF7YLoGnlJk=
X-Sasl-enc: T54XVkKPBuuvDxNn4Fhr9XlOd+QU9lAMC2Il61fO01JT 1274882329
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5FB464D838B;
	Wed, 26 May 2010 09:58:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147799>

Paul Walker venit, vidit, dixit 26.05.2010 15:35:
> As I could not find any bug reporting information on the wiki I  
> thought I would mention this here, please let me know if there is a  
> better forum for bug reports.  I believe the latest git release  
> (1.7.1.) has an installation bug when building with  
> "NO_CURL=YesPlease".  Looking at the Makefile line 1999 it reads
> 
> for p in $(REMOTE_CURL_ALIASES); do
> 
> which results in "/bin/sh: syntax error at line 1 : `;' unexpected" as  
> REMOTE_CURL_ALIASES is empty.

That seems to depend on the shell. My bash 4.1.2 doesn't care. What does
/bin/sh --version say for you?

Michael
