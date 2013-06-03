From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Mon, 03 Jun 2013 11:34:04 -0700
Message-ID: <7vzjv7dowz.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-4-git-send-email-artagnon@gmail.com>
	<87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
	<20130603180701.GJ2192@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZa9-0008J4-S4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657Ab3FCSeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 14:34:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab3FCSeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 14:34:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE8325C08;
	Mon,  3 Jun 2013 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rJothuncxSEC
	J0MNdk+zLOXFbjw=; b=voSPfgPvzOz6UhiaEk747HgOKirCNt2J0tQZ9xsvH5VM
	zzg2a5XYVDfpbtCpI5q9qJrOFMl7DzY7sseJOrLkNbAjnDjeFH4NG76MeAmsQGJe
	3yS1JWigx9ZQsqZx+DgDw3kxgHBbFEe/MY6AaTnarUzdOcR1p5dfppbDORlJDbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dE9DSS
	pSc/zbO5NaNlnqhG1Qb3I/1+YX5So6X3TX3xMj69Nol300DRFafCq65cnQnjAfcn
	22JedFVwNVA79l9F2+W33EOxkMH45hy9dVZiBvxrTStiaP5cUpPSIX7V15yEpTHZ
	ujICLNIR4/PuipXZ89PVyxqSpmcTf4bbsfvKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD4B25C07;
	Mon,  3 Jun 2013 18:34:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81ECD25C03;
	Mon,  3 Jun 2013 18:34:06 +0000 (UTC)
In-Reply-To: <20130603180701.GJ2192@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 3 Jun 2013 20:07:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C475FBE-CC7C-11E2-A5BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226260>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> But providing short options for completion is pointless.  Those who
> know git blame's short options will just type them right away, becaus=
e
> it requires less key presses than using completion, and those who
> don't know these options will only see -C, -M, etc. and won't have an=
y
> clues what it stands for.


It is not necessarily true that "they won't have any clue"; one
could argue that "-C -M etc" can serve as reminder to people who
once learned but forgot momentarily.

My conclusion is the same, though; "git blame -h" is for those
people.
