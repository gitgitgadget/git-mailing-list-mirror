From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: can't push to ransom ssh port ?
Date: Fri, 04 Jul 2008 15:35:55 +0200 (CEST)
Message-ID: <20080704.153555.71091133.hanzl@noel.feld.cvut.cz>
References: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pneshama@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 04 15:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElaN-0006LO-1c
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbYGDNna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbYGDNna
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:43:30 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:56387 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754166AbYGDNn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:43:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 0767BFD806;
	Fri,  4 Jul 2008 15:35:56 +0200 (CEST)
In-Reply-To: <912ec82a0807040628k14c8acd1ree9d82b68f69e080@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87391>

> Is there a way to tell git to connect to a random port X ?
> 
> (something like ssh's -p parameter)

It can also be done using ~/.ssh/config with this:

Host a.b.c.d
Port 12345

(see man ssh_config), this way you just need to do it at one place for
ssh, scp and all git repositories.

Regards

Vaclav
