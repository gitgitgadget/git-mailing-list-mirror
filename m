From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make a non-bare repo bare.
Date: Thu, 16 Jul 2009 13:47:01 -0700
Message-ID: <7vd4808iey.fsf@alter.siamese.dyndns.org>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
 <7vbpnlbbln.fsf@alter.siamese.dyndns.org> <h3mpls$9dt$1@ger.gmane.org>
 <e2b179460907160155g7c84b083u8a1dd6ba193f4531@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Graeme Geldenhuys <graemeg@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRXrI-00027b-Nh
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 22:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbZGPUrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 16:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933328AbZGPUrH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 16:47:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbZGPUrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 16:47:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 64321676C;
	Thu, 16 Jul 2009 16:47:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B7ADA676B; Thu,
 16 Jul 2009 16:47:02 -0400 (EDT)
In-Reply-To: <e2b179460907160155g7c84b083u8a1dd6ba193f4531@mail.gmail.com>
 (Mike Ralphson's message of "Thu\, 16 Jul 2009 09\:55\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2E37786-7249-11DE-9EF3-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123421>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/7/16 Graeme Geldenhuys <graemeg@gmail.com>:
>> Junio C Hamano wrote:
>>>
>>> Funny.
>>>
>>> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.gi=
t/123303
>>>
>>> It is posed as a question but describes the correct (and officially
>>> supported) procedure.
>>
>>
>> Now it deserves to be in some Git FAQ. It seems the issue is more co=
mmon
>> than I thought. :-)
>
> It already is
>
> http://git.or.cz/gitwiki/GitFaq#HowdoImakeexistingnon-barerepositoryb=
are.3F
>
> unless that's new?

Somebody needs to promise to keep that entry up-to-date, or we should
rewrite it so that we do not expose such an implementation detail.

Even today core.bare is not the only difference between a repository wi=
th
a work tree and a bare one.  We also set core.logallrefupdates these da=
ys
for a repository with a work tree, so the procedure described there is
already stale.  And this kind of implementation details are bound to
change.

Asking git what to do is the only reliable "cut-and-paste-ready" recipe=
=2E
