From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 15:21:48 +0000
Message-ID: <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com> <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de> <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com> <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhmlo-0001g5-1s
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678AbZCLPV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 11:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbZCLPV6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:21:58 -0400
Received: from frim.nl ([87.230.85.232]:40418 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629AbZCLPV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 11:21:57 -0400
Received: from vpn-014.vpn.net.ed.ac.uk ([129.215.37.14])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LhmjJ-0006Gz-Aw; Thu, 12 Mar 2009 16:21:54 +0100
In-Reply-To: <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113078>


On Mar 12, 2009, at 1:43 PM, Sverre Rabbelier wrote:

> The point is that we _already_ warned the user (like Dscho pointed
> out), and that(as you pointed out), it didn't work :P.

You can also get this in other interactions, for example:

	$ git checkout -b origin/test HEAD
	$ git checkout -b origin/test master

yes, these might be user errors, but I still think it's not OK to  
create a new ref 'refs/heads/origin/test' if there's also a 'refs/ 
remotes/origin/test' (as I've said a few months ago).
