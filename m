From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Makefile: add uninstall target.  Fixes elementary good cleaning manners.
Date: Wed, 18 Nov 2009 14:28:31 +0100
Message-ID: <vpqr5rwdksg.fsf@bauges.imag.fr>
References: <1257945756.26362.79.camel@heerbeest>
	<48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	<1258547389.25909.101.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkas-0004gl-NC
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZKRN27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbZKRN27
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:28:59 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50233 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755544AbZKRN26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:28:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAIDRSxT004542
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Nov 2009 14:27:28 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NAkaG-0002m1-Fd; Wed, 18 Nov 2009 14:28:32 +0100
In-Reply-To: <1258547389.25909.101.camel@heerbeest> (Jan Nieuwenhuizen's message of "Wed\, 18 Nov 2009 13\:29\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Nov 2009 14:27:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAIDRSxT004542
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259155649.4069@gZ4IpZBvhlYtvMnX/JP4Tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133168>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> writes:

> Sorry.  Let me retry that.  See below.

Please, read Documentation/SubmittingPatches 

>>From f260a4dcf0b42088eb1da74aee49f49ac4b0c55b Mon Sep 17 00:00:00 2001
> From: Jan Nieuwenhuizen <janneke@gnu.org>
> Date: Wed, 11 Nov 2009 14:19:00 +0100
> Subject: [PATCH] Makefile: add uninstall target.  Fixes elementary good cleaning manners.
>
>    * Modified     Makefile
>    * Modified     gitk-git/Makefile
>    * Modified     perl/Makefile
>    * Modified     templates/Makefile

Git knows better than you which files are modified by a commit, so
it's counter-productive to rewrite by hand this list in the commit
message. This place is the place to explain _why_ your change is good
(to convince the maintainer to apply it in git.git in particular).

>  Makefile           |   18 +++++++++++++++++-
>  gitk-git/Makefile  |    2 ++
>  perl/Makefile      |    2 +-
>  templates/Makefile |    5 +++++

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
