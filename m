From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Fri, 16 May 2014 10:05:26 -0700
Message-ID: <xmqq4n0pbqnc.fsf@gitster.dls.corp.google.com>
References: <20140514184145.GA25699@localhost.localdomain>
	<xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
	<CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
	<20140515050820.GA30785@localhost.localdomain>
	<alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
	<20140515184808.GA7964@localhost.localdomain>
	<CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
	<xmqqmweiessl.fsf@gitster.dls.corp.google.com>
	<CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
	<xmqqmweibjjo.fsf@gitster.dls.corp.google.com>
	<CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNCR-0007sk-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866AbaEPStj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 14:49:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52437 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757748AbaEPSti convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 14:49:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27D4717CB6;
	Fri, 16 May 2014 14:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=74TnnwMnxCNy
	HF6QJkQfghDAGmY=; b=j3DaBoh3E8BLNAL4SO7Nq8rVqIzaknPRSKgfQhlBENfX
	cD5OJUFKnhjSYzyUTf/i6msARsJ038M0JTbqHFJi2vqjfmP2EgqmCy/0ex9u+pbu
	/P/apZmeI++fI9TxDTfnjnVXC+x40zPoYoTU+RVPDrWeGVlE0xuV6j7f3RxqNTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZuiOli
	537caFMMMgrrWa5ekQcHpBnJjAgH7/NmMFbfNeV7L7Hd9GdooZ3sIqEqq1jeip4F
	8UPJtuNuDGwyLXLIAekjxigZm3asNPkZhaG6SSGXXP1uoPH9UAeHt5DDlK5JzbAE
	i5e6F5ZumapgDkqnkRZFAPCsMpjC9NpqJIvAE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E3B517CB4;
	Fri, 16 May 2014 14:49:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 279321653E;
	Fri, 16 May 2014 13:05:29 -0400 (EDT)
In-Reply-To: <CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 16 May 2014
 09:54:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 483A9112-DD1C-11E3-BA1B-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249409>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Correct, but is "where does it appear" the question we are
>> primarily interested in, wrt this breakage and its fix?
>
> That of course depends on how we want to test gitweb output.
> The simplest solution, comparing with known output with perhaps
> fragile / variable elements masked out could be done quickly...
> but changes in output (even if they don't change functionality,
> or don't change visible output) require regenerating test cases
> (expected output) to test against - which might be source of
> errors in test suite.

I agree with your "to test it fully, we need extra dependencies",
but my point is that it does not have to be a full "HTML-validating,
picking the expected attribute via XPATH matching" kind of test if
what we want is only to add a new test to protect this particular
fix from future breakages.

=46or example, I think it is sufficient to grep for 'href=3D"...%xx%xx"=
'
in the output after preparing a sample tree with one entry to show.
The expected substring either exists (in which case we got it
right), or it doesn't (in which case we are showing garbage).  Of
course that depends on the assumption that its output is not too
heavily contaminated with volatile parts outside our control, as I
already mentioned in the message you are responding to.

But it all depends on "if" we wanted to add a new test ;-)
