From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 20:06:00 +0100
Message-ID: <vpqeioeaz53.fsf@bauges.imag.fr>
References: <vpqljimpr95.fsf@bauges.imag.fr>
	<alpine.LFD.2.00.0911041243350.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lBb-0003RK-DQ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbZKDTGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZKDTGE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:06:04 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50122 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867AbZKDTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:06:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nA4J5LVQ009540
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 20:05:21 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5lBB-0002F2-BW; Wed, 04 Nov 2009 20:06:01 +0100
In-Reply-To: <alpine.LFD.2.00.0911041243350.10340@xanadu.home> (Nicolas Pitre's message of "Wed\, 04 Nov 2009 12\:46\:48 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Nov 2009 20:05:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nA4J5LVQ009540
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1257966321.97391@cQTTyDLjLW5PvL1uVRvylQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132115>

Nicolas Pitre <nico@fluxnic.net> writes:

> You could checkout the first revision which committer's date is older 
> than midnight.  Of course that means you have to trust that students 
> didn't mess up with time stamps.

Not only that: they could have commited something the day before, and
pushed it the day after. In the particular case I have in mind, the
deliverable is an intermediate one, and we insist a lot on testing, so
the senario is not unlikely: commit dangerous code the day of the
deadline, and push it the day after. So, the reflog is definitely the
answer here.

But thanks anyway!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
