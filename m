From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-merge-octopus creates an empty merge commit with one
 parent
Date: Mon, 13 Feb 2012 11:51:09 -0800
Message-ID: <7vpqdieclu.fsf@alter.siamese.dyndns.org>
References: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vipjafu27.fsf@alter.siamese.dyndns.org> <20120213202039.5346fa89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1vh-0001F5-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699Ab2BMTvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 14:51:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078Ab2BMTvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 14:51:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 762907F61;
	Mon, 13 Feb 2012 14:51:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nj/cBrSDmUVO
	B16L7CQhwrG0iWw=; b=AzTvbVlgnO+NnJCgmwGdvVd4KM24LtC95YFUG9G3rB4G
	0QxIOiTvyjIdzVzvBheO8kW3Fu+up2wLWtW1uuoOlBUr5AcvKGHmgHj6GZGIN5on
	FM0IYRVjHR0cAOq2EC20rwxKqWtjhunbph1Ta4584WfraBYMsjKocR6m6sbEI48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UPvZHw
	GInzKDwIUhL21CeoqvWDKKxDcbC4w7yE40VX24f2Uagjx/WDiZFmEkiaFuquXp6m
	ielycj+e3RWWvC5wuU0NU5jfcDWh7szwg7HfG60P7eVTASFmFjlHpgujgmJL0HwQ
	sz9KrYdB+W7tD86QRlQIm9MxdFJ+RNp90Wgzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CEFD7F60;
	Mon, 13 Feb 2012 14:51:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39387F5D; Mon, 13 Feb 2012
 14:51:10 -0500 (EST)
In-Reply-To: <20120213202039.5346fa89@gmail.com> (=?utf-8?Q?=22Micha=C5=82?=
 Kiedrowicz"'s message of "Mon, 13 Feb 2012 20:20:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 140BE3BA-567C-11E1-ADBD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190654>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> ... Except that I still think this behavior is not correct.

Well, what was missing from my "don't do it then" quote was "Doctor it
HURTS when I do this."; there is no question that it is not correct if =
it
hurts ;-).

Patches welcome; I suspect it shouldn't be too intrusive or difficult.
