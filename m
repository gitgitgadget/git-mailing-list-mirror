From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] parseopt: make usage optional
Date: Sun, 08 Mar 2009 13:25:14 -0700
Message-ID: <7vr617kbit.fsf@gitster.siamese.dyndns.org>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
 <49B2C784.90800@lsrfire.ath.cx> <49B40B9A.8080202@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPaE-0002rt-Ts
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZCHUZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 16:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbZCHUZX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:25:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbZCHUZX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 16:25:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A79304A16;
	Sun,  8 Mar 2009 16:25:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 056C24A15; Sun, 
 8 Mar 2009 16:25:16 -0400 (EDT)
In-Reply-To: <49B40B9A.8080202@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 08 Mar 2009 19:16:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F831946-0C1F-11DE-8D2A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112639>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Allow usagestr to be NULL and don't display anything a help screen in
> this case.  This is useful to implement incremental parsers.

Can I amend "s/anything a/any/"?
