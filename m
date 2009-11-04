From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 20:08:46 +0100
Message-ID: <vpqaaz2az0h.fsf@bauges.imag.fr>
References: <vpqljimpr95.fsf@bauges.imag.fr>
	<7vbpjii2ur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lEZ-00057R-JR
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbZKDTJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755921AbZKDTJD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:09:03 -0500
Received: from mx1.imag.fr ([129.88.30.5]:56008 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714AbZKDTJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:09:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nA4J85B7010439
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 20:08:07 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5lDq-0002Gz-Re; Wed, 04 Nov 2009 20:08:46 +0100
In-Reply-To: <7vbpjii2ur.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 04 Nov 2009 10\:03\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Nov 2009 20:08:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nA4J85B7010439
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1257966489.19523@D3PwfKUcwh5WQUW7O7y4kw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132116>

Junio C Hamano <gitster@pobox.com> writes:

> A distribution point repository like this is often bare, and reflogs are
> not enabled in bare repositories (primarily due to my stupidity^Wbeing
> overly cautious---I was very skeptical about reflogs when we introduced
> it).

Thanks for reminding it (I knew it, but I could very well have
forgotten at the last minute ...) :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
