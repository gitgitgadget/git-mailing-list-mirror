From: Heiko Voigt <heiko.voigt@mahr.de>
Subject: Re: Partial tree export and merging
Date: Thu, 25 Sep 2008 16:36:15 +0200
Message-ID: <48DBA1DF.3050502@mahr.de>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan>	 <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de> <fcaeb9bf0809241051se24bcf7tb836d1b820e288d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@mahr.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:39:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kirzb-0000Zm-Ui
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYIYOgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYIYOgO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:36:14 -0400
Received: from mail.mahr.com.tr ([193.158.246.156]:17957 "EHLO mail.mahr.de"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYIYOgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:36:13 -0400
Received: from [172.20.12.218] ([172.20.12.218]) by mail.mahr.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 25 Sep 2008 16:36:11 +0200
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <fcaeb9bf0809241051se24bcf7tb836d1b820e288d6@mail.gmail.com>
X-OriginalArrivalTime: 25 Sep 2008 14:36:11.0683 (UTC) FILETIME=[0E55F730:01C91F1C]
X-TM-AS-Product-Ver: SMEX-8.0.0.1259-5.500.1027-16178.007
X-TM-AS-Result: No--12.038200-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96770>

Nguyen Thai Ngoc Duy schrieb:
> That could be done with (under-developing) sparse checkout. Basically
> language team's people do "git clone --sparse-checkout='*.loc:*.html'
> your-repo.git". Then they only have *.loc and *.html files in working
> directory. When they commit, all other files are unchanged. Developers
> merge to have updated *.log/html as usual.

Where is that option ? Or are you suggesting me to implement it ?

> I have a question though: is language team allowed to checkout/modify
> files other than *.loc and *.html?

Well in an ideal world they should only have access to the "language" 
files. But it is not crucial for us if they get access to the source. 
Its more an issue of user friendlyness. The revision control which is in 
place at the moment does allow them to selectively check out those files.

Heiko
