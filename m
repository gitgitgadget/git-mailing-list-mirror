From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Sat, 16 Apr 2016 12:23:02 +0200
Message-ID: <20160416122302.Horde.jjsXp-czGdXN7lDuc-Vg6pE@webmail.informatik.kit.edu>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
 <1460200767-32864-2-git-send-email-rappazzo@gmail.com>
 <xmqqk2k2l0yx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 12:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arNO1-0004J2-MU
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 12:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbcDPKX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2016 06:23:27 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57259 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163AbcDPKX0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 06:23:26 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1arNNq-0007Fl-1U; Sat, 16 Apr 2016 12:23:22 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1arNNW-0007ho-GK; Sat, 16 Apr 2016 12:23:02 +0200
Received: from x4db289c7.dyn.telefonica.de (x4db289c7.dyn.telefonica.de
 [77.178.137.199]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 16 Apr 2016 12:23:02 +0200
In-Reply-To: <xmqqk2k2l0yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1460802202.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291719>


Quoting Junio C Hamano <gitster@pobox.com>:

> Applying this patch on top of sg/completion-updates topic makes the
> tests much more readable.  Given that sg/completion-updates topic is
> planned to be rerolled ($gmane/287839), I think it would be better
> to do this as a preparatory clean-up patch before it makes the tests
> uglier by doing "add --absolute-git-dir" patch in the middle.
>
> G=C3=A1bor, what do you think?

Sure, go ahead.  A standalone test cleanup patch could graduate to mast=
er
faster than a 20+ patch series, so it shouldn't be held hostage.

The reroll of sg/completion-updates is almost ready.  "Almost", because=
 the
refs completion speedup series (another 10+ patches...) is almost ready=
 as
well, but needs some final polishing and I want to trickle down some of=
 the
test updates into sg/completion-updates.  Unfortunately, I don't expect=
 to
have time to finish it up in the next few days...  but fortunately that=
'll
leave you time to agree on how to rewrite t1500 and Michael to do the
reroll ;)

Anyway, if Michael rerolls based on master and you have troubles you do=
n't
want to deal with with the conflicts between the reroll and my series, =
I
would say just discard sg/completion-updates for the time being.


G=C3=A1bor
