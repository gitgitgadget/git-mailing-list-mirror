From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Thu, 13 Jun 2013 13:44:40 +0200
Message-ID: <vpq8v2etetz.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-2-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 13 13:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un5xT-0003vr-IW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 13:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3FMLor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 07:44:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56642 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab3FMLor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 07:44:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DBid36006205
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 13:44:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un5xI-0003JO-Ix; Thu, 13 Jun 2013 13:44:40 +0200
In-Reply-To: <1371118039-18925-2-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 12:07:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 13:44:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227721>

benoit.person@ensimag.fr writes:

> +install_pm:
> +	cp $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)

Better use "install", which is roughly like "cp".

Also, this fails if the target dir does not exist, ie. if one did not
run "make install" at the toplevel Git. It's OK, but perhaps you should
add a comment in the Makefile like '# Run "make install" from Git's
toplevel before using this'.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
