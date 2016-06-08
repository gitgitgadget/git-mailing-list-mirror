From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/3] doc: more consistency in environment variables format
Date: Wed, 08 Jun 2016 10:12:30 +0200
Message-ID: <vpqa8iwyu8h.fsf@anie.imag.fr>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160607223507.18061-1-tom.russello@grenoble-inp.org>
	<20160607223507.18061-4-tom.russello@grenoble-inp.org>
	<5757C1B4.5060709@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:12:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYbc-00057c-20
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbcFHIMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:12:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56247 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161184AbcFHIMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:12:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u588CUut022308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jun 2016 10:12:30 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u588CVQY006977;
	Wed, 8 Jun 2016 10:12:31 +0200
In-Reply-To: <5757C1B4.5060709@kdbg.org> (Johannes Sixt's message of "Wed, 8
	Jun 2016 08:56:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 08 Jun 2016 10:12:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u588CUut022308
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465978352.1625@dlZT6qOnlwjP1HuKceqeHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296767>

Johannes Sixt <j6t@kdbg.org> writes:

> Also, you should investigate cases where "environment" is at the
> beginning of a line, because then the variable name is most likely at
> the end of the previous line. At the least, you missed an occurrence
> of GIT_EXTERNAL_DIFF in diff-config.txt.

In theory, yes, but the goal of this patch is not to get everything
right, only to make one step in the right direction. Doing it with perl
substitutions allows making a relatively large step with minor effort.

Obviously, other patches getting more consistency elsewhere are welcome,
but I don't think they have to be part of this series. On a side note,
this patch is written by students of mine as part of a school project
which ends this Friday, leaving very little time for them to write more
patches.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
