From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-pull.sh: better warning message for "git pull" on
 detached head.
Date: Tue, 07 Apr 2009 17:43:44 -0700
Message-ID: <7vk55wvutb.fsf@gitster.siamese.dyndns.org>
References: <e2b179460904070224o3057c6efk6930bd1249adb0fe@mail.gmail.com>
 <1239098181-10360-1-git-send-email-Matthieu.Moy@imag.fr>
 <20090407104145.GA22658@pvv.org> <vpqvdpgn19y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 08 02:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrLvS-0003PX-LM
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 02:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758398AbZDHAnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757211AbZDHAnx
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 20:43:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878AbZDHAnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 20:43:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1BB4A8E7A;
	Tue,  7 Apr 2009 20:43:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 152D3A8E78; Tue,
  7 Apr 2009 20:43:45 -0400 (EDT)
In-Reply-To: <vpqvdpgn19y.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 07 Apr 2009 13:36:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 541E19B8-23D6-11DE-B180-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116012>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Grepping the source, "not on a branch" seems more widely used than
> "detached head" in the UI (including in another place of git-pull.sh),
> so, yes, something like this would be better:

Yeah, "not on a branch" sounds like the best wording.
