From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] core.filemode may need manual action
Date: Sun, 19 Oct 2014 15:35:23 -0700
Message-ID: <xmqqr3y3r8lw.fsf@gitster.dls.corp.google.com>
References: <54418CA0.6050503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 00:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfz4U-00065D-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 00:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbaJSWf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2014 18:35:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569AbaJSWf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 18:35:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E7417C16;
	Sun, 19 Oct 2014 18:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E6rzf84Kpx75
	cLcps25cjh/5q1Q=; b=O/Zfs8x63+rTCAKSTKuqujkY2kroB/jI1qYzaw+owz7E
	jvWJdiThlGZZ7AY2zkbEHp6gBFrX+r0naakqSA0CyfWcIfcH0hdZCfu/ATDqqYQ2
	0u6poQ9ClGnq4CvOFZp5m8C7Rtx9L7FuQDt2YrbOp4ArwPW9PNSr0Td5LMBA77E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tsdpnA
	yzsPJueSr0scv51XJpS+4VWARJdRNKzW7+OBvRBrcApkfwb2vmB8p+2p6D+zFHVX
	I2mTftv6pPqQVZPjm2AF2KWqMGswmG0cU+OusehSeLnZWexAKAAcHAh8siP3Y7HE
	huxB9uI2ym/D1xSJiLyDnNerxRmlNKWcWpbD4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABA8E17C15;
	Sun, 19 Oct 2014 18:35:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33DEC17C14;
	Sun, 19 Oct 2014 18:35:24 -0400 (EDT)
In-Reply-To: <54418CA0.6050503@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 17 Oct 2014 23:39:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 376E825A-57E0-11E4-925F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> - The '+' at an otherwise empty line generates an empty line
>   in html, so s/^$/+/

I think the rule is actually that you cannot have multiple
paragraphs in an enumerated list the same "headword double-colon and
then indented paragraph" way, and need to unindent second and
subsequent paragraphs, and have "+" before each of them, i.e.

        .--------------------------------
        |core.fileMode::
        |	Here is my first paragraph.
        |+
        |Here is my second one.
        .--------------------------------

That is how the existing "The default is true, except..." paragraph
is done, and I was hoping that you would notice it and follow that
example.
