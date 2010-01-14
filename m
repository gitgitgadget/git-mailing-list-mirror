From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:25:57 +0100
Message-ID: <vpqiqb4lq4q.fsf@bauges.imag.fr>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com>
	<46a038f91001140544u64dd7eefn94625cdc40881cd6@mail.gmail.com>
	<alpine.DEB.1.00.1001141509230.3029@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 15:31:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVQj9-0001I4-Rg
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 15:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab0ANOa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 09:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730Ab0ANOa5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 09:30:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58824 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0ANOa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 09:30:56 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0EEPYiQ031270
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 15:25:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NVQe6-0007Pb-13; Thu, 14 Jan 2010 15:25:58 +0100
In-Reply-To: <alpine.DEB.1.00.1001141509230.3029@intel-tinevez-2-302> (Johannes Schindelin's message of "Thu\, 14 Jan 2010 15\:16\:55 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jan 2010 15:25:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0EEPYiQ031270
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264084202.44741@WONF5pR3s0GabILkyyF1pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136994>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Of course it'd only work if you have full ssh access, unless the git 
>> server learns a new command to mkdir (in sane and approved locations).
>
> You mean a new "init" command a la "git --git-dir=bla.git init", which 
> _does_ mkdir the directory.

I think he meant

  git --git-dir=git+ssh://foo.bar/var/git/mynewthing.git init

which doesn't.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
