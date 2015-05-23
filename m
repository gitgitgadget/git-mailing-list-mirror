From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sun, 24 May 2015 00:33:33 +0200
Message-ID: <vpqwpzyc4aq.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>
	<vpqbnhd157k.fsf@anie.imag.fr> <555F252C.2060601@gmail.com>
	<vpq8ucffj8h.fsf@anie.imag.fr>
	<xmqqoalbciwj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 00:33:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwHzF-00017u-HY
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 00:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbbEWWdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 18:33:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40491 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbbEWWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 18:33:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4NMXUH3013061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 May 2015 00:33:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4NMXXcd016239;
	Sun, 24 May 2015 00:33:33 +0200
In-Reply-To: <xmqqoalbciwj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 23 May 2015 10:18:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 24 May 2015 00:33:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4NMXUH3013061
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433025212.92191@f83OBuzH/rxOm1ChBsVOmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269820>

Junio C Hamano <gitster@pobox.com> writes:

> And I do not think an array of things that are operated on should
> not be named "ref_filter_item".

Is the double-negation intended? It seems contradictory with:

> Surely, the latter "set of operations to be applied" may currently
> be only filtering, but who says it has to stay that way?

(With which I do agree)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
