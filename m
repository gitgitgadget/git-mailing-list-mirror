From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git equivalent to clearcase wink-in
Date: Thu, 21 Jan 2010 08:46:21 +0100
Message-ID: <vpqiqavgasy.fsf@bauges.imag.fr>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
	<7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
	<20100120211251.GA26274@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamie Wellnitz <jwellnitz@gmail.com>,
	Richard Assal <richard_assal@yahoo.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 08:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXrkb-00035k-ON
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 08:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab0AUHql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 02:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779Ab0AUHql
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 02:46:41 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54443 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879Ab0AUHqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 02:46:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0L7jb0N015205
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 08:45:37 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NXrkD-0002sk-A5; Thu, 21 Jan 2010 08:46:21 +0100
In-Reply-To: <20100120211251.GA26274@glandium.org> (Mike Hommey's message of "Wed\, 20 Jan 2010 22\:12\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 Jan 2010 08:45:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0L7jb0N015205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264664738.23143@B0R/Nfx5FIxgI1QVcKqPxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137635>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Jan 20, 2010 at 04:05:46PM -0500, Jamie Wellnitz wrote:
>> Would something like ccache (compiler cache) help you out?  It's not
>> the same as wink-in (which, as I understand it, copies an already
>> built object file from someone else who has built it).  Instead each
>> user has their own cache, so everyone has to pay the expensive build
>> price at least once.
>
> Surely the ccache directory could be shared on nfs or some other network
> filesystem.

There's a section "SHARING A CACHE" here:
http://ccache.samba.org/ccache-man.html

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
