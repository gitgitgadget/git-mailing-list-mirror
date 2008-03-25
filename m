From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: git-format-patch|git-send-email sucks
Date: Tue, 25 Mar 2008 19:29:50 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0803251928500.7062@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0803251914060.2240@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 19:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeDv9-0003iT-IZ
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbYCYS3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbYCYS3w
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:29:52 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:42849 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394AbYCYS3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 14:29:51 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 790C31803165B; Tue, 25 Mar 2008 19:29:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 72CD61C00E290
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 19:29:50 +0100 (CET)
In-Reply-To: <alpine.LNX.1.10.0803251914060.2240@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78203>


On Tuesday 2008-03-25 19:18, Jan Engelhardt wrote:
>
> git@ cc'd for justice.
>
> <rants>
>
>  * `git-format-patch --stdout | git-send-email` does not fly,
>    files need to be exported first, it's a bit inconvenient
>
> * git-send-email should really default to --no-chain
>
>  * git-send-email should stop if it cannot find the headers
>    it is looking for (esp. Subject), even if I dared to forget --dry-run
>    (point in case:  git log -1 mycommit >x.diff; git-send-email x.diff)
>
> </rants>

<more rants>

To be in the picture, the command issued was:

rm -f 00*; git-format-patch -C -M --stat=72 --summary -p --thread -n 
origin/symbolic/upstream..HEAD; git-send-email --thread 
--no-signed-off-by-cc --no-chain --to user2@localhost 00*

   * jengelh@localhost _still_ gets all the mails

</more rants>
