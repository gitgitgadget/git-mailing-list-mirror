From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: remove hardcoded version number in the test suite
Date: Thu, 13 Jun 2013 13:38:18 +0200
Message-ID: <vpqk3lytf4l.fsf@anie.imag.fr>
References: <1371123008-28068-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 13 13:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un5rV-0007si-1R
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 13:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab3FMLiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 07:38:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39020 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab3FMLiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 07:38:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DBcH6l007061
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 13:38:19 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un5r9-0003C0-4G; Thu, 13 Jun 2013 13:38:19 +0200
In-Reply-To: <1371123008-28068-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 13:30:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 13:38:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227720>

benoit.person@ensimag.fr writes:

> Updates the code to make it more easy to switch mediawiki version when
> testing. Before that, the version number was partly hardcoded, partly
> in a var.

This is obviously good.

> Maybe I should add a warning that the installation procedure may not work 
> in the future ? It seems to work for the range 1.19.X - 1.21.X though :) ?
> Should I also update the version number to the latest one (1.21.1) ?

This kind of remarks does not belong to the commit message, it should be
below the --- (before the diffstat).

And yes, I think a comment saying "# Versions foo, bar and boz have been
tested" or so would be welcome.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
