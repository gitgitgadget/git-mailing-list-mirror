From: Sam Vilain <sam@vilain.net>
Subject: Re: Temporary directories getting errantly added into trees
Date: Sat, 24 Nov 2007 13:07:39 +1300
Message-ID: <47476B4B.6030906@vilain.net>
References: <4744FCD9.7020102@vilain.net> <Pine.LNX.4.64.0711221052280.27959@racer.site> <20071123082103.GA11236@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 01:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IviYq-00032x-Jf
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 01:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXKXAHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 19:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbXKXAHf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 19:07:35 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48021 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbXKXAHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 19:07:34 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 1DE50205470; Sat, 24 Nov 2007 13:07:32 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D254320544D;
	Sat, 24 Nov 2007 13:07:28 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071123082103.GA11236@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65934>

Karl Hasselstr=F6m wrote:
>> But I don't know about QGit, StGit, etc...
>>    =20
> I don't think StGit relies on the name of any file outside .git. (It
> does pollute the root of the worktree with some temp files of its own=
,
> though -- but not across invocations.)
>  =20

Yes, I've had to add .tmp_msg* to my .git/info/exclude for those, too.=20
Given nothing cares, perhaps put them under .git anyway?

Sam.
