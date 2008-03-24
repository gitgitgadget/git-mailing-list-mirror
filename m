From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 20:01:19 -0700
Message-ID: <7vprtk3jwg.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <5d46db230803231406x132e748bm306494ec5f8dfd2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 04:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdcwy-0008Qr-U4
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 04:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbYCXDBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 23:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbYCXDBg
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 23:01:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYCXDBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 23:01:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4F182242;
	Sun, 23 Mar 2008 23:01:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4B9022241; Sun, 23 Mar 2008 23:01:28 -0400 (EDT)
In-Reply-To: <5d46db230803231406x132e748bm306494ec5f8dfd2b@mail.gmail.com>
 (Govind Salinas's message of "Sun, 23 Mar 2008 16:06:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77998>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> I also sent out the following patch that could be put in instead of...

I had an impression that that change would break the existing output that
somebody other than you are depending on.

I personally think it is plausible that everybody wants the new behaviour
your patch propose, but that kind of change is not appropriate for 1.5.5
cycle (might be Ok for 1.6.0 after we see agreements on the list), and
definitely not something we would want to apply after -rc0.
