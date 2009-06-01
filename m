From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [RFC] git-cvs script
Date: Mon, 01 Jun 2009 10:47:52 +0100
Message-ID: <4A23A3C8.3090506@yahoo.co.uk>
References: <4A213793.3030205@yahoo.co.uk> <b2cdc9f30905310042u592a6f5cv541055194524cce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 11:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB47M-0001ty-Qz
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 11:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbZFAJrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbZFAJrg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 05:47:36 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:45269 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbZFAJrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 05:47:35 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MB47E-00017W-FR; Mon, 01 Jun 2009 10:47:36 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <b2cdc9f30905310042u592a6f5cv541055194524cce0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120454>

Alex Bennee wrote:
> If this is using the inbuilt cvsps and perl then it will likely choke
> on very large CVS repos. For some CVS tree's I've had to resort to a
> hacked up version of parsecvs to get a conversion running.

I gather cvsps has to read the whole history to be able to interpret the latest
commits, is that right?  In which case a long history is going to generate long
waits on each import. And possibly eat lots of memory too.

I do actually have a larger CVS tree to test it on than I have been using (it's
about a decade's worth of changes on a production website) but I didn't want to
set myself up for a fall by tackling it.  For now, my aim has been to keep CVS
"out of the living room" whilst I work on the small CVS module that concerns me.
Meanwhile, I'm hoping to convince the powers that be that CVS needs to be
replaced, preferably with Git, before I get asked to work on something larger.

However, if you can test it on your repository, and with your patched version of
parsecvs, that would be a good thing. Especially if it works.

Thanks,

N
