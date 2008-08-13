From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 14:50:00 -0700
Message-ID: <7vhc9olh4n.fsf@gitster.siamese.dyndns.org>
References: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
 <7vy730n0ac.fsf@gitster.siamese.dyndns.org>
 <c475e2e60808131420h5b7350abq188b3f8a53b51d98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Giovanni Funchal" <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOFQ-0004hv-Ro
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYHMVuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 17:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbYHMVuN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:50:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbYHMVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:50:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C550358D7F;
	Wed, 13 Aug 2008 17:50:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D174D58D7B; Wed, 13 Aug 2008 17:50:06 -0400 (EDT)
In-Reply-To: <c475e2e60808131420h5b7350abq188b3f8a53b51d98@mail.gmail.com>
 (Giovanni Funchal's message of "Wed, 13 Aug 2008 23:20:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD5B0AEE-6981-11DD-8731-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92282>

"Giovanni Funchal" <gafunchal@gmail.com> writes:

> My changes should not break a lot of people's setups. Most people will
> find the new default better because it works straight on
> linux/windows.

My understanding is that Linux/Windows people won't be using
NO_R_TO_GCC_LINKER.  What I was afraid of breaking was people who have
their own config.mak (which is included by Makefile) to customize the way
the linkage works, setting NO_R_TO_GCC_LINKER appropriately.  Doesn't your
change to the Makefile in a way not to pay attention to the variable break
them?
