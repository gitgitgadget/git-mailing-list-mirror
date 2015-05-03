From: Junio C Hamano <gitster@pobox.com>
Subject: Re: multiple source file extensions
Date: Sat, 02 May 2015 19:26:16 -0700
Message-ID: <xmqqfv7ewg53.fsf@gitster.dls.corp.google.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
	<CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
	<20150502011100.GB5634@peff.net> <20150502020431.GA15775@lanh>
	<CACsJy8C2aztHWHP0_U8VWJxMrT2HE7aYBxDQTnSWS1TVwCnedw@mail.gmail.com>
	<20150502023504.GC587@peff.net>
	<CAPig+cT8kP0NrmXXn-chBU+zjM_28NT5CVivda2NDs_mxuepzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 03 04:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yojbr-0006mY-M6
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbbECC0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 22:26:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750966AbbECC0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 22:26:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6AEA4EAF8;
	Sat,  2 May 2015 22:26:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EEjfNLTFOhvyMUuMQ60T0CD70xI=; b=WCt9d4
	2HDIGK7/+t0DuOvUaFzEJHRzqQom3q3o+JkOkcF1FK/bZfbl6HOn0mOZUtv48RGd
	Y3Pq+gYOqd5dWpUjoUtgiqmQIo694RaAwSq6DVb9bIcV19BLsSxHFNrcsAgO9lqr
	0NbWwZX33QkvZeOILKFzl3ihu+u6CknbLKGjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FkriltVq6qfFK4TaMNcz2adq1g8MpfRU
	VLU4FvGjlAyCCt/8uQZ/63nSn8r4O4bwXrvU4qeY6bgdcnLds7ClVgCFq0lCQlnM
	tVi4SjMPn8AU+MZEasNXmTzsdsi9Ni2oWCq2Q4Ty9jNxObH+8EABms8O/3H6vtes
	KysTqiWrmIU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF80D4EAF7;
	Sat,  2 May 2015 22:26:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57A314EAF5;
	Sat,  2 May 2015 22:26:17 -0400 (EDT)
In-Reply-To: <CAPig+cT8kP0NrmXXn-chBU+zjM_28NT5CVivda2NDs_mxuepzQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 2 May 2015 03:11:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7251810-F13B-11E4-B909-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268252>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I agree we don't really need curly braces in pathspecs. :)
>
> However, neither POSIX shells nor the Windows command interpreter
> support curly-brace alternation.

Why "However"?  Neither of them offer it because their users do not
need it---why should we give it only when they are using Git and
only for the in-repo contents (we obviously cannot help when their
users want to refer to the working tree files)?
