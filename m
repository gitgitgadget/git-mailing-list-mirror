From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git rm --cached
Date: Sun, 04 Nov 2007 18:04:47 +0100
Message-ID: <vpq1wb6x7ps.fsf@bauges.imag.fr>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
	<87mytwiq1f.dlv@vanicat.homelinux.org>
	<20071102174140.vobtdjxfwsgoc040@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 18:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioiuf-0002Uu-56
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 18:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbXKDRFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbXKDRFK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 12:05:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:64598 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbXKDRFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 12:05:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lA4H4le4005750
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 4 Nov 2007 18:04:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ioitz-0000M6-Er; Sun, 04 Nov 2007 18:04:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ioitz-0003KB-Bs; Sun, 04 Nov 2007 18:04:47 +0100
In-Reply-To: <20071102174140.vobtdjxfwsgoc040@intranet.digizenstudio.com> (Jing Xue's message of "Fri\, 02 Nov 2007 17\:41\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 04 Nov 2007 18:04:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63419>

Jing Xue <jingxue@digizenstudio.com> writes:

> 1. I looked at the "index" as a staging area for _changes_ not files
> themselves. So where 'man git-rm' says '--caches ... remove[s] the
> paths only from the index, leaving working tree files.'  I took it to
> mean that it removes the changes on those paths, rather than staging a
> new "path deletion" action for a later commit.

The index is a full snapshot of "what will be commited". The
interesting parts of the index are usually the ones which differ from
either HEAD or the working tree, but the index do contain everything.

-- 
Matthieu
