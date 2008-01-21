From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: =?ISO-8859-15?Q?=5BANNOUNCE=5D?= GIT 1.5.4-rc4
Date: Mon, 21 Jan 2008 11:49:15 +0100
Message-ID: <1JGuDL-2AugiG0@fwd26.aul.t-online.de>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 12:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGulk-0004zm-6l
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934AbYAULYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758895AbYAULYT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:24:19 -0500
Received: from mailout05.sul.t-online.de ([194.25.134.82]:50934 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758838AbYAULYS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 06:24:18 -0500
X-Greylist: delayed 2049 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2008 06:24:18 EST
Received: from fwd26.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1JGuEB-0003dF-02; Mon, 21 Jan 2008 11:50:07 +0100
Received: from localhost (bjkhvGZVZhFJZUCEGX5NjBO+7YqfLmust-+sR9mi0t689TdcEcOFarLbM1-Yzb6Z1T@[172.20.101.250]) by fwd26.aul.t-online.de
	with esmtp id 1JGuDL-2AugiG0; Mon, 21 Jan 2008 11:49:15 +0100
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-1-3
X-ID: bjkhvGZVZhFJZUCEGX5NjBO+7YqfLmust-+sR9mi0t689TdcEcOFarLbM1-Yzb6Z1T@t-dialin.net
X-TOI-MSGID: fdee807e-37e1-49f1-9869-2d3a4503b145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71263>


Concerning RPM specs.

I created rpm packages on a x86_64 SuSE 10.3 system.

There were two complains about unmatched dependencies for expat-devel
and perl(Error)
I could not get rid off.

So I used rpmbuild --nodeps -ta git-1.5.4.rc4.tar.gz

The installation (rpm -i) gave the following error

error: Failed dependencies:
        openssh-clients is needed by git-core-1.5.4.rc4-1.x86_64
        perl(:MODULE_COMPAT_5.8.8) is needed by
perl-Git-1.5.4.rc4-1.x86_64

But when I used --nodeps here too the installation went through and git
seams 
to be working alright

Cheers,
Michael
