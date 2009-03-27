From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 15:45:21 +0100
Message-ID: <49CCE681.5050503@drmicha.warpmail.net>
References: <1238157134-27558-1-git-send-email-Niels@Basjes.nl> <m3k56b2hy2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Niels Basjes <Niels@Basjes.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDL0-0004R3-O9
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbZC0Oph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZC0Opg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:45:36 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36923 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837AbZC0Opf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 10:45:35 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C09983014ED;
	Fri, 27 Mar 2009 10:45:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 27 Mar 2009 10:45:32 -0400
X-Sasl-enc: oAoXDVjjuWXhpwjLKk5LtgGNbfFAOYO/I6ouVLRtBtcf 1238165132
Received: from localhost.localdomain (p4FC63422.dip0.t-ipconnect.de [79.198.52.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7A923297C;
	Fri, 27 Mar 2009 10:45:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <m3k56b2hy2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114899>

Jakub Narebski venit, vidit, dixit 27.03.2009 14:50:
> Niels Basjes <Niels@Basjes.nl> writes:
> 
>> Two RPM building improvements:
> 
> Two _unrelated_ RPM building improvements squashed in one commit.
> 
>>   - Building the RPMs can now be done by a non-root user.
> 
> It was always possible, you only have to configure rpm / rpmbuild,
> namely put path to where you want your RPM_BUILDING directory in
> ~/.rpmmacros as %_topdir, for example:
> 
>   $ cat ~/.rpmmacros
>   %_topdir        /home/local/builddir
> 
> Please RTFM first, before going to solve non-problem in (ugh) fairly
> complicated way.

Also, the "solution" from the patch overrides any user choice from
.rpmmacros, AFAICS.

> 
>>   - The additional target all-rpms now builds the RPMs for a multitude of target platforms.
> 
> Please wrap commit messages at 72-76 columns, at most at 80 columns.
> No such overly long lines, please.
> 
> But the all-rpms target looks like a good idea
> 
