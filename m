From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/5 v4] diff: parse detached options --stat-width n, --stat-name-width n
Date: Mon, 02 Aug 2010 20:47:03 +0200
Message-ID: <vpqzkx4df88.fsf@bauges.imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-3-git-send-email-Matthieu.Moy@imag.fr>
	<7v1vahnebk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:48:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og03M-0003nV-O8
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab0HBSry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:47:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab0HBSrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:47:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o72IacoH010975
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 20:36:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Og02S-0001bQ-7I; Mon, 02 Aug 2010 20:47:04 +0200
In-Reply-To: <7v1vahnebk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 09\:56\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Aug 2010 20:36:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72IacoH010975
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281379000.8243@IN4m2M7IqnHxgxx0LFJS6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152436>

Junio C Hamano <gitster@pobox.com> writes:

> This will accept "--stat-width=40", "--stat-width 40", and "--stat=40,20"
> but not "--stat 40,20" --- am I reading the patch correctly?

Yes.

> Not a complaint but trying to double-check.  I think it is Ok not to try
> guessing wrong (the user may be interested in a path 40,20, for example).

Right. Same goes for all optional arguments, the sticky form is
required.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
