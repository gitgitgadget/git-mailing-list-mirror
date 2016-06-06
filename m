From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/3] doc: change configuration variables format
Date: Mon, 06 Jun 2016 16:09:30 +0200
Message-ID: <vpqfusqmmsl.fsf@anie.imag.fr>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-1-tom.russello@grenoble-inp.org>
	<20160606100905.23006-4-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:10:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9vET-0001qi-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 16:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbcFFOJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 10:09:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42075 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcFFOJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 10:09:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56E9T1I001549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 16:09:29 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56E9Ubn000349;
	Mon, 6 Jun 2016 16:09:30 +0200
In-Reply-To: <20160606100905.23006-4-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Mon, 6 Jun 2016 12:09:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 16:09:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56E9T1I001549
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465826972.46481@MgwY9y/LBXBqv62of4cyTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296513>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> As a first step,

Is this your second first step? ;-)

As 3rd and 4th first steps, I'd suggest:

Format short options properly:
perl -pi -e "s/'(-[a-z])'/\`\$1\`/g" *.txt

Format long options properly:
perl -pi -e "s/'(--[a-z][a-z=<>-]*)'/\`\$1\`/g" *.txt

This does not have to be done right now. Large series doing only
reformatting like this tend to create conflicts with in-flight topics so
it may be better to split it into several series anyway.

About conflicts, I just checked: the existing patch series creates one
trivial conflict with pu, and my suggested fix for long options creates
one more. Seems manageable.

For now, I went carefully through the patches. With or without my
suggested changes/additions, the series is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
