From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: more compact summary and without extra quotes
Date: Mon, 19 Jan 2009 19:49:19 -0800
Message-ID: <7vocy2ocw0.fsf@gitster.siamese.dyndns.org>
References: <1232405116-2359-1-git-send-email-santi@agolina.net>
 <alpine.DEB.1.00.0901200043400.3586@pacific.mpi-cbg.de>
 <adf1fd3d0901191600k6fd7a364h3e55f9600960df03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 04:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7df-0002WI-3e
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 04:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZATDtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 22:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbZATDtc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 22:49:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZATDtb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 22:49:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DC6291CD4D;
	Mon, 19 Jan 2009 22:49:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 679E51CD70; Mon,
 19 Jan 2009 22:49:22 -0500 (EST)
In-Reply-To: <adf1fd3d0901191600k6fd7a364h3e55f9600960df03@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Tue, 20 Jan 2009 01:00:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55780328-E6A5-11DD-A05A-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106432>

Santi B=C3=A9jar <santi@agolina.net> writes:

>>> As discussed in the git mailing list:
>>>
>>> http://marc.info/?l=3Dgit&m=3D122765031208922&w=3D2
>>>
>>> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
>>> ---
>>
>> You really want to move the link after the ---.  I often read commit
>> messages off-line, and let me tell you: I am not really happy readin=
g
>> links then.  Not at all.
>
> OK, less work for me :-)

I do not mind URL in the commit log; it would help me or other forgetfu=
l
people three months from now if we need to go back to the original
discussion.

I however agree with Dscho that it is irritating when somebody uses URL=
 to
avoid summarizing the issue himself.  If somebody cares enough and
understands the issues discussed at URL to come up with a patch that is
worth applying, he surely should be able to summarize the primary idea =
and
issues involved in a few paragraphs.

A summary of discussion in addition to URL would save everybody's time.
