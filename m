From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v5 02/10] for-each-ref: clean up code
Date: Mon, 08 Jun 2015 18:23:42 +0200
Message-ID: <vpqfv622mpd.fsf@anie.imag.fr>
References: <55729B78.1070207@gmail.com>
	<1433574581-23980-1-git-send-email-karthik.188@gmail.com>
	<1433574581-23980-2-git-send-email-karthik.188@gmail.com>
	<vpqd2168dwa.fsf@anie.imag.fr> <5575B30B.6000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zq4-00074f-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbbFHQXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:23:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54294 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbbFHQXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:23:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GNdFu009961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 18:23:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GNgsk008585;
	Mon, 8 Jun 2015 18:23:42 +0200
In-Reply-To: <5575B30B.6000407@gmail.com> (Karthik Nayak's message of "Mon, 08
	Jun 2015 20:51:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 18:23:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58GNdFu009961
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434385422.77269@Ol5Y4g6c3lChSSfctZw9ZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271067>

Karthik Nayak <karthik.188@gmail.com> writes:

> I put these two together as they are trivial changes.
> Either I could reword the commit message or split the commit.

I'd split the commit. Actually, even though it's only a small comment
change, it's not so "trivial" in the sense that one needs a good
understanding of the code to check the correctness of your patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
