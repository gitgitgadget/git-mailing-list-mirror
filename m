From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Sun, 15 Mar 2015 15:18:38 -0700
Message-ID: <xmqqvbi1sy4h.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 23:18:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXGrx-0007AM-J1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 23:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbCOWSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 18:18:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751436AbbCOWSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 18:18:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E078C40B05;
	Sun, 15 Mar 2015 18:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7y5flVhA3Fa7YDsnbFKhhxuqPZg=; b=YJP5b/
	XxgyJqLOXVSkxbp/y7LFXFPPiAagiux2ghp1S08gE/yDws8SSkE16G7F0lQPidhR
	qNjkhNtFm5nki7H/yHFD2nOiPl8dYOQ68E/CS4k4z35ZFXSoyCMlQqwTJjIvLoSv
	HZkNu8hD+mYZjFkVoLaPeIvJNO5Nccxrtg34A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iq2FrP4IY2cowfzrgF9WRB/OSFMWlsVU
	qzenu/9ZE+SOF48GE+bdqgw3URk6ellgOgEtfDbrJ4/soxDdXurDTOZh/zDwnXC+
	cN7pcn7vZAr8emkTfSoYCqQO8Hq+xuDc2+SO/M6QTRUMMquipfmRiXZbkZTx1LWu
	a9iauWX3Fyc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D96C740B02;
	Sun, 15 Mar 2015 18:18:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63A7C40B00;
	Sun, 15 Mar 2015 18:18:39 -0400 (EDT)
In-Reply-To: <CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
	(Christian Couder's message of "Sun, 15 Mar 2015 09:46:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B3F4D20-CB61-11E4-A842-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265529>

Christian Couder <christian.couder@gmail.com> writes:

> I wrote something about a potential Git Rev News news letter:

I read it.  Sounds promising.

Just one suggestion on the name and half a comment.

How would "Git Review" (or "Git Monthly Review", or replace your
favourite "how-often-per-period-ly" in its name) sound?  I meant it
to sound similar to academic journals that summarize and review
contemporary works in the field and keeps your original "pun" about
our culture around "patch reviews".

I obviously do not know how the actual contents would look like at
this point, but depending on the quality of the publication I might
be able to steal some descriptions when keeping the notes on topics
in flight that appear in my "What's cooking" report.  And it can go
the other way around, too.  The publication may want to peek my
"What's cooking" report for hints on how to characterize each topic
and assess its impact to the evolution of Git.
