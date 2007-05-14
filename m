From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Mon, 14 May 2007 19:50:37 +0200
Message-ID: <vpqy7jr47ma.fsf@bauges.imag.fr>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle>
	<200705131949.38051.list-receive@mneisen.org>
	<20070513182405.GA13618@diana.vm.bytemark.co.uk>
	<20070513210128.GA13428@muzzle>
	<alpine.LFD.0.98.0705141016370.6739@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 19:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnehy-00011x-Ei
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956AbXENRuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbXENRuu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:50:50 -0400
Received: from imag.imag.fr ([129.88.30.1]:37177 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673AbXENRut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 13:50:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4EHob00002257
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 19:50:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hnegv-0005FD-99; Mon, 14 May 2007 19:50:37 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hnegv-0006Jk-6g; Mon, 14 May 2007 19:50:37 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.98.0705141016370.6739@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 14 May 2007 10\:26\:06 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 14 May 2007 19:50:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47278>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I wouldn't personally mind if somebody taught git to just track empty 
> directories too.

Just to add my 2 cents: I just had a case where I would have needed
empty directories, and it seems reasonable as a workflow:

As a group of teachers, one created a skeleton, with stg like

./course/
./practical-works/day1
./practical-works/day2
./exercices/day1
./exercices/day2
...

He did it with svn, filled in only a few directories, I "git-svn
clone"d it, and I got almost nothing!

These empty directories are not interesting by themselves, but as a
placeholder to add files, I think it's a good thing to have them.

-- 
Matthieu
