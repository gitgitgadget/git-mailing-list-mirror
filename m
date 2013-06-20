From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/5] git-remote-mediawiki: Introduction of Git::Mediawiki.pm
Date: Thu, 20 Jun 2013 10:30:25 +0200
Message-ID: <vpqy5a5dw0u.fsf@anie.imag.fr>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
	<1371712593-6210-2-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 20 10:30:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaGK-0006yM-H4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3FTIaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:30:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41155 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab3FTIa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 04:30:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5K8UPtO004017
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Jun 2013 10:30:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpaG9-0005au-RA; Thu, 20 Jun 2013 10:30:25 +0200
In-Reply-To: <1371712593-6210-2-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 20 Jun 2013 09:16:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Jun 2013 10:30:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228450>

This serie has a conflict with cm/remote-mediawiki. We probably want to
wait for other mediawiki patch series to hit master (they are all marked
as "will merge to master" in Junio's last "what's cooking) before
merging this one.

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> Currently, the mw-to-git project contains only a remote helper
> (git-remote-mediawiki.perl). To inmprove the user experience while working

s/inmprove/improve/

> A perl package offer the best way to handle such case:

s/offer/offers/

> An alternate solution is to concatenate a "toolset" file with each *.perl
> when 'make'-ing the project. In that scheme, everything is imported in the
> script's namespace. Plus, files should be renamed in order to chain to Git's
> toplevel makefile.

Perhaps say explicitely "hence this solution is not acceptable" or so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
