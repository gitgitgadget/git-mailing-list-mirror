From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] diff-no-index.c: rename read_directory()
Date: Wed, 19 Mar 2014 18:47:08 +0100
Message-ID: <vpqd2hidqsj.fsf@anie.imag.fr>
References: <1395243516-5753-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:47:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKaa-0007O0-6r
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaCSRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:47:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43241 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbaCSRrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:47:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2JHl6i5001337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2014 18:47:06 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2JHl8IO005309;
	Wed, 19 Mar 2014 18:47:08 +0100
In-Reply-To: <1395243516-5753-1-git-send-email-mandrei.dinu@gmail.com> (Andrei
	Dinu's message of "Wed, 19 Mar 2014 17:38:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Mar 2014 18:47:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2JHl6i5001337
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395856029.75433@IP/uW1jyklXpIEv5iOfpwg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244468>

Andrei Dinu <mandrei.dinu@gmail.com> writes:

> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

The commit message should explain why this is a good change. In general,
the "why?" question is more important than the "what" (the reader can
see from the patch that you renamed the function, but cannot guess why
you did so).

Also, when sending multiple patches, send them as a single thread. See
for example:

  http://thread.gmane.org/gmane.comp.version-control.git/244441

In practice, call "git send-email" once, not once per patch. Try sending
the patches to yourself first to avoid disturbing the list in case of
user error.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
