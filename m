From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Detached HEAD warning (again)
Date: Tue, 31 Mar 2009 18:59:38 +0100
Message-ID: <D561809D-BEE9-417A-B030-8337533C8E53@ai.rug.nl>
References: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl> <alpine.DEB.1.00.0903311203490.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoiHS-0000B7-4x
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762261AbZCaR7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbZCaR7u
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:59:50 -0400
Received: from frim.nl ([87.230.85.232]:49370 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759228AbZCaR7t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 13:59:49 -0400
Received: from cnat010.wlan.net.ed.ac.uk ([129.215.5.10] helo=[172.20.100.191])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LoiFV-0006tB-8H; Tue, 31 Mar 2009 18:59:45 +0100
In-Reply-To: <alpine.DEB.1.00.0903311203490.10279@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115293>


On Mar 31, 2009, at 11:04 AM, Johannes Schindelin wrote:

>> 	$ git submodule update --init
>> 	# sub/ is created
>> 	$ (cd sub && touch a && git add a && git commit -am "Add new file")
>> 	[detached HEAD 8641889] Add new file
>> 	 0 files changed, 0 insertions(+), 0 deletions(-)
>> 	 create mode 100644 a
>>
>> 	$ git submodule update
>> 	$ ls sub/a
>> 	ls: sub/a: No such file or directory
>
> 	$ cd sub
> 	$ git checkout HEAD@{1}

Yes, I know that the commits can still be recovered
(otherwise this would be a much bigger issue), but 'git
reflog' has never been a necessary part of a workflow, has
it? It's nifty and can be very useful in situations where you
accidentally lost something, but you can hardly call this a
nice workflow or expect people that use submodules to know
about this.

- Pieter
