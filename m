From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 09:56:29 -0700
Message-ID: <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de>
 <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:57:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLoB-000762-PT
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbYDVQ4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944AbYDVQ4o
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:56:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbYDVQ4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 12:56:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42AF42A3E;
	Tue, 22 Apr 2008 12:56:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 903ED2A3B; Tue, 22 Apr 2008 12:56:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80138>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I really hate the idea of introducing yet other marks when we alre=
ady=20
> have unique identifiers: the (abbreviated) commit names.

Didn't I give you an example why commit object names are _not_ unique
identifiers already?

I also do not understand why you think 'mark' is ugly.  I _suspect_ tha=
t
the machinery to read the TODO insns would need to keep a copy of what =
it
gave to the end user, compare it with what user edited to make sure the
user did not make nonsense insn sequence out of it, which J=C3=B6rg's c=
ode
doesn't do (yet), and I suspect a simple rule like "you cannot move ins=
ns
across 'mark' boundary" would be sufficient for that check.
