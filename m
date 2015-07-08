From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 3/4] status: give more information during rebase -i
Date: Wed, 08 Jul 2015 09:10:40 +0200
Message-ID: <vpqr3ojjf9r.fsf@anie.imag.fr>
References: <vpqk2ujoadw.fsf@anie.imag.fr>
	<1435784916-15456-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435784916-15456-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqlher1upy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjVN-0000F3-TA
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbbGHHKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:10:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55984 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932497AbbGHHKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:10:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t687AeqT009188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2015 09:10:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t687AeOO018227;
	Wed, 8 Jul 2015 09:10:40 +0200
In-Reply-To: <xmqqlher1upy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Jul 2015 15:14:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jul 2015 09:10:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t687AeqT009188
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436944242.38669@SWO0c7ZUUwPYlj/Ri4Xnfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273640>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, does this have any potential interaction with 16cf51c7
> (git-rebase--interactive.sh: add config option for custom
> instruction format, 2015-06-13)?  I _think_ that the other topic
> should only affect the collapsed format, so there hopefully
> shouldn't be a problem, but just double checking if you folks
> considered the ramifications already.

16cf51c7 adds rebase.instructionFormat that allows changing the part
after <command> <sha1> in the todo-list, but this part is not parsed by
our patch. So it's OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
