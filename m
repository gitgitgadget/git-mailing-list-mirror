From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: how to ignore all .xvpics directories
Date: Mon, 03 Nov 2008 13:15:36 +0100
Message-ID: <490EEB68.3040009@melosgmbh.de>
References: <490ECE54.5090505@melosgmbh.de> <m3d4hdf2qp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 13:20:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwyPu-0005VP-Ag
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 13:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbYKCMTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 07:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbYKCMTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 07:19:09 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:23278 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbYKCMTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 07:19:05 -0500
X-Greylist: delayed 7444 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 07:19:04 EST
X-RZG-CLASS-ID: mo00
X-RZG-AUTH: :P2kWY0mrft+7PRqjQVQfkgnIveo2zsFMc4bua7BlzFdiPwP9DUuD8pO0q5s=
Received: from mail.melosgmbh.de (p5B07AD3C.dip0.t-ipconnect.de [91.7.173.60])
	by post.webmailer.de (mrclete mo32) (RZmta 17.14)
	with ESMTP id V00dbdkA3CHg1H ; Mon, 3 Nov 2008 13:19:03 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.034,BAYES_00: -1.665,TOTAL_SCORE: -1.631
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Mon, 3 Nov 2008 13:18:58 +0100
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <m3d4hdf2qp.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99935>

Jakub Narebski schrieb:
>> [ Note: some time ago this issue has already popped up:
>> http://thread.gmane.org/gmane.comp.version-control.git/50504
>>
>> However, adding a line with just .xvpics in the toplevel .gitignore
>> does not help. Neither does /**/.xvpics
> 
> Could you reproduce the steps you tried? Because I have checked, and
> putting .xvpics or .xvpics/ in top level .gitignore (or in
> .git/info/excludes, or ~/.gitignore) works as expected: filename
> without '/' in it is match agains _basename_.
> 
> Note that .gitignore is about contents which is not tracked (not known
> to git). If you added .xvpics to commit by accident, .gitignore will
> do nothing then.
Thank you Jakub,

I checked that and indeed... someone left uncomitted changes (i.e. 
deleted those (acc. commited) files without committing) and got me confused.
It *does* work for untracked files.

Sorry for the noise.

-- 
Christoph Duelli
