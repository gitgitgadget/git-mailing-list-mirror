From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 11:43:52 -0700
Message-ID: <7v1vt2lgyf.fsf@gitster.siamese.dyndns.org>
References: <49B74373.3090609@gmail.com>
 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 19:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhpuS-0001lI-3a
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZCLSoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 14:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbZCLSoF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:44:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbZCLSoE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 14:44:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7C0FA1302;
	Thu, 12 Mar 2009 14:44:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7BAFCA1300; Thu,
 12 Mar 2009 14:43:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
 (david@lang.hm's message of "Thu, 12 Mar 2009 11:00:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C13B6470-0F35-11DE-8277-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113103>

david@lang.hm writes:

> On Thu, 12 Mar 2009, saurabh gupta wrote:
>
>> On Thu, Mar 12, 2009 at 3:17 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> ...
> with XML files it's possible to be symanticly identical, but not
> identical as far as a text merge driver is concerned.
> ...
> a good XML merge driver would have options that you could set for a
> particular file type to know about these sorts of things.

Correct.

>>> =C2=A0When it cannot autoresolve,
>>> but there is no way to "mark" a tentative result with conflict mark=
ers, it
>>> can do the same thing as the "binary" driver and let the mergetool =
backend
>>> handle the "driver punted" case.
>>
>> I think you mean to say that in case, there is a conflict and the
>> changes don't overlap, then merge driver leaves the file as it is an=
d
>> the merge helper will handle the file.
>
> if there is a conflict it should be because the changes do overlap. i=
f
> they don't overlap why is it a conflict?

Correct.  In such a case when the "driver" can be sure that the result =
is
reasonable, "helper" should not even kick in.  That was the main point =
of
my suggestion, which you seem to have got right.

Thanks.
