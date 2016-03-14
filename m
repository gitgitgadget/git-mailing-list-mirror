From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Mon, 14 Mar 2016 10:47:28 -0700
Message-ID: <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:48:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afWbM-0007Xo-79
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbcCNRsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 13:48:16 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751216AbcCNRsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 13:48:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0327D4CC69;
	Mon, 14 Mar 2016 13:47:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ge1k45pvptMHZY0W/klpOBKurXI=; b=lRJ8EW
	Co3b3MMGgN79eTIQHVt4+Vl5H3oloAJ8/O22bYm3/hkY5UqtvO9Dv76GSZMGikRm
	5XT+ohn1RMgQsTDXscRsBE8PPGOCmn03auuk9qY1QnMXhkvznUGhOjVVq/p0f0Ii
	Cvqn8nHloW9m7svBmvjQXF+R3i93PRxUcrabM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoPwgS8dxehZli+alVdcjWRwSEgElogy
	nBVpqx8h8tSYKMWnh3pKOEs1LqwWMv7dFBRbS1fYrAaceS7CvKeHKfJF5UZv2JbI
	rsXTJfZGrXH3gybZSG6UJSodL+P0xHc7Mu//I+RsqXPDu1WcPbHWZPwBwGlgcAjW
	8cVF5rw7zpo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDF774CC68;
	Mon, 14 Mar 2016 13:47:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 721A24CC67;
	Mon, 14 Mar 2016 13:47:29 -0400 (EDT)
In-Reply-To: <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Mar 2016 08:56:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D261C2BC-EA0C-11E5-91D1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288793>

Junio C Hamano <gitster@pobox.com> writes:

> But if it makes it easier for translations teams and the i18n
> coordinator to work together if I also pulled the git.pot update
> myself, I'll do so.  I just didn't know (and still don't know) if
> that makes things easier for you guys, or if that risks making
> things more confusing, having to or being able to pull from two
> trees that are not necessarily in sync down to the minute.

So, please just tell me to pull it myself too, if it makes the life
of i18n team and the coordinator easier.

Thanks.
