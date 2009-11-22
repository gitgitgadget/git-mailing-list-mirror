From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] apply: Use the term "working tree" consistently
Date: Sun, 22 Nov 2009 09:28:20 -0800
Message-ID: <7viqd2ii4r.fsf@alter.siamese.dyndns.org>
References: <4B0964C5.7040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 18:29:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCGFN-0001P2-QR
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 18:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbZKVR2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 12:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbZKVR2W
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 12:28:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbZKVR2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 12:28:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F037A0D3A;
	Sun, 22 Nov 2009 12:28:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GkMU0SetC8Sa
	7I4Ku0WhGCjEIqw=; b=ahviYDT6QMtc7JF140ndUQid5ko1X4FGnVvR11bRoLZm
	OtZvIhn2mVM7rZOvUY017cQ+mv1kF6f+ekMatSJwW4lh5mKR/86WzkCLIv1fCSUM
	JV/6BPxpnavRTmUa7E0PdW4Wq0kZaTeR1Q6Kk2w21oPRRjKHkE2DHM4jnsWgAu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qsvIJN
	pho2zIvLZkdZEwTsriqpA6g7kTCPHdSlpTmh7zBf0pKNXNt1J6jEBKj2LJsmvnqk
	ikx2X/LvabQK3VBzZdjUW4edvOCR/C0MRJZXn6gj9bS8oqir4H4Qab1gWsQQPiPN
	0lMJEqMDkVAeluOD7z2I7dkt5QX21KSi1PqSs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10421A0D39;
	Sun, 22 Nov 2009 12:28:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 22536A0D38; Sun, 22 Nov 2009
 12:28:21 -0500 (EST)
In-Reply-To: <4B0964C5.7040501@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Sun\, 22 Nov 2009 17\:20\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 707ADC30-D78C-11DE-8932-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133446>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> The documentation for 'git apply' uses both the terms "work tree" and
> "working tree". Since the glossary uses the term "working tree", chan=
ge
> all occurrences of "work tree" to "working tree".

Consistency is good.

I'd personally vote for fixing it the other way around starting from th=
e
glossary, though.
