From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 19:53:58 +0200
Message-ID: <vpqljlfsn9l.fsf@bauges.imag.fr>
References: <20090819082423.GA18860@atjola.homenet>
	<vpqljlguqtn.fsf@bauges.imag.fr>
	<fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com>
	<20090819091445.GB18860@atjola.homenet>
	<fcaeb9bf0908190218x487dd7f4y355e411a8cb1f254@mail.gmail.com>
	<7v1vn7wvce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 19:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdpPJ-0001uN-4T
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbZHSR47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbZHSR47
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 13:56:59 -0400
Received: from imag.imag.fr ([129.88.30.1]:50642 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbZHSR46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 13:56:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7JHrwPp029163
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 19:53:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdpME-0007Ls-5f; Wed, 19 Aug 2009 19:53:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdpME-0003mM-4I; Wed, 19 Aug 2009 19:53:58 +0200
In-Reply-To: <7v1vn7wvce.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 19 Aug 2009 10\:45\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 19 Aug 2009 19:53:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126567>

Junio C Hamano <gitster@pobox.com> writes:

> So I wounld't be surprised if there were bugs lurking around "-t" family.
> Patches to fix them are welcome; people's scripts depend on them.

In the particular case of -t, as far as my grep can tell, it's
untested, not used in Git itself, and rather unlikely to be used
elsewhere given it's strange behavior.

I'd say the best thing to to is to keep it, but mark it as deprecated
in the doc, and point to 'diff --name-status' and 'status' as superior
alternatives in the doc.

-- 
Matthieu
