From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Mon, 14 Mar 2016 08:56:34 -0700
Message-ID: <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:56:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUrL-0003Lr-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965386AbcCNP4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 11:56:39 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965378AbcCNP4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 11:56:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4E3B4A96F;
	Mon, 14 Mar 2016 11:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05M+epFi2r7N85PDUV4gmAfGO54=; b=q3Agzf
	2nqH9v9o32vVnGaExzuTqxKKsLRrGfRhaOQGFED+tUn2Ok+6K0apQ5uLYNPbOkgU
	IjSUfCs8RPl5PPAP2p8xPhMzNX1+qZDAOf1BzI9Pfz4JCTS+0TvcOd0K0w78SeDb
	OkqtiLzUddHRP1DdDGTLMBkKRu61CbwSHRXKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PLDnhRWGonqjmQGzQwoS1NyN27BfRcCJ
	CL4A/cC4p0jdOg/PbDpX+nLh9PbvfArpsNPEWDvXT19fr+cRypBqELJVfqn/SC+H
	4C2ID8iSvY0pjZxEoJNleeAxcxZ6vTfDI7gJWk+9dSl8aQGR0tFPcvB6dIVpDuD8
	yMPGER9n9eE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC18A4A96E;
	Mon, 14 Mar 2016 11:56:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F3E84A96D;
	Mon, 14 Mar 2016 11:56:36 -0400 (EDT)
In-Reply-To: <56E6D8C4.2010205@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 14 Mar 2016 16:29:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 54B90ABE-E9FD-11E5-A539-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288786>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Have you pulled git.pot for 2.8.0 already? [1]

Thanks for bringing this up.

No, I never pull the "git.pot round N for release" myself, as I am
not working on any translations, and I expect that translation teams
work off of i18n coordinator's tree (i.e. Jiang's tree), not from
mine.  The updated git.pot would come to me along with the new
translations via his tree.

But if it makes it easier for translations teams and the i18n
coordinator to work together if I also pulled the git.pot update
myself, I'll do so.  I just didn't know (and still don't know) if
that makes things easier for you guys, or if that risks making
things more confusing, having to or being able to pull from two
trees that are not necessarily in sync down to the minute.

> [1] http://permalink.gmane.org/gmane.comp.version-control.git/287774
