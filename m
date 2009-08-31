From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 13:22:08 +0200
Message-ID: <vpqskf8z0rj.fsf@bauges.imag.fr>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 13:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi4xr-0003Z3-Go
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 13:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbZHaLWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZHaLWM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 07:22:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56843 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbZHaLWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 07:22:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7VBImqP018459
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 Aug 2009 13:18:48 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mi4xc-0001YR-Tp; Mon, 31 Aug 2009 13:22:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mi4xc-0006pM-SU; Mon, 31 Aug 2009 13:22:08 +0200
In-Reply-To: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net> (Sitaram Chamarty's message of "Mon\, 31 Aug 2009 11\:14\:22 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 31 Aug 2009 13:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7VBImqP018459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252322328.41554@21nt4lrsNjqDkV2YRIvysA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127478>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Hello,
>
> Cloning an empty repo seems to produce a spurious error.
> The repo still seems fine though.

Can't reproduce here:

$ git clone ssh://.../tmp/empty cloned
Initialized empty Git repository in /tmp/cloned/.git/
warning: You appear to have cloned an empty repository.
$ git --version
git version 1.6.4.187.gd399.dirty

Maybe you have an older version of Git?

-- 
Matthieu
