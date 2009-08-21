From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 12:26:41 +0200
Message-ID: <vpqtz01cvj2.fsf@bauges.imag.fr>
References: <1250509342.2885.13.camel@cf-48>
	<200908200937.05412.jnareb@gmail.com>
	<alpine.LFD.2.00.0908201358010.6044@xanadu.home>
	<200908211207.38555.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 12:27:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeRL0-0000Kg-O1
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 12:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZHUK1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 06:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbZHUK1E
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 06:27:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35540 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbZHUK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 06:27:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7LANn9k000395
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Aug 2009 12:23:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MeRKT-0003AF-8c; Fri, 21 Aug 2009 12:26:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MeRKT-0001Hr-6L; Fri, 21 Aug 2009 12:26:41 +0200
In-Reply-To: <200908211207.38555.jnareb@gmail.com> (Jakub Narebski's message of "Fri\, 21 Aug 2009 12\:07\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Aug 2009 12:23:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7LANn9k000395
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251455031.59012@3X7gQdnT+dbp7CTvGPUboA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126704>

Jakub Narebski <jnareb@gmail.com> writes:

> On the other hand Linux is fairly large project in terms of LoC, but
> it had its history cut when moving to Git, so the ratio of git-archive
> of HEAD to the size of packfile is overemphasized here.

Emacs can be a good example if you want a project with a loooong
history.

emacs.git$ git ll | wc -l  
100651
emacs.git$ du -sh emacs.tar.gz .git/objects/pack/pack-144583582d53e273028966c6de2b3fb2fe3504bc.pack 
29M	emacs.tar.gz
138M	.git/objects/pack/pack-144583582d53e273028966c6de2b3fb2fe3504bc.pack

(from git://git.savannah.gnu.org/emacs.git )

-- 
Matthieu
