From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix handling of non-ASCII characters in inserted
 HTML files
Date: Wed, 03 Dec 2008 13:14:30 -0800
Message-ID: <7vfxl5c66h.fsf@gitster.siamese.dyndns.org>
References: <200811171140.45884.jnareb@gmail.com>
 <20081201175741.11133.82393.stgit@localhost.localdomain>
 <7v63m1j4ke.fsf@gitster.siamese.dyndns.org>
 <200812031121.43606.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tatsuki Sugiura <sugi@nemui.org>,
	Gerrit Pape <pape@smarden.org>, Recai Oktas <roktas@debian.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7z4f-0000ad-Mi
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 22:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYLCVOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 16:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYLCVOj
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 16:14:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYLCVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 16:14:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91D3E83DC2;
	Wed,  3 Dec 2008 16:14:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 71B2483DC0; Wed,
  3 Dec 2008 16:14:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64B93BE0-C17F-11DD-9457-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102289>

Jakub Narebski <jnareb@gmail.com> writes:

> With "close $fd" removed the patch is correct (and patches t9500*).

Yeah, it passes that test here, too.  Let's unleash it to 'master' and in
an unlikely case where it still has bugs we know which commit to revert
;-).

Thanks.
