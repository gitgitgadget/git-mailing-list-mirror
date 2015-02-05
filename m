From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advice on edits to git-rebase man page
Date: Thu, 05 Feb 2015 13:29:45 -0800
Message-ID: <xmqqmw4sjbcm.fsf@gitster.dls.corp.google.com>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
	<vpqa90s4oz2.fsf@anie.imag.fr>
	<xmqqa90smbhu.fsf@gitster.dls.corp.google.com>
	<vpq1tm412dk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthew Brett <matthew.brett@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTzq-0002GM-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 22:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbbBEV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 16:29:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753409AbbBEV3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 16:29:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A58E36C07;
	Thu,  5 Feb 2015 16:29:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pkrINiLYZ3sXN+mj7hemnphfjWY=; b=XzY07K
	fMNDCBxv/d80oi5kuXMdyUFvJ9HKoIEGCRl6Okg0Ct19d3DeHvN5MJouJCLCH6L7
	lFsx/LpzkQjhUNRSWpfaFcJUtVc5pw29vJiK/aN54I3y4X+OIDna5yY9gdAtjf4H
	Epv2ADJvw/ICZ4rWFEXJzfiErPw9OCYCE0HHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rEdVJ7RnMAwDrE1ig/J+J/P4UbzL0NXj
	qw/zJarx4SzswsMkOFm0u4uamYuP6Aj2uwSlIZAt+n+TNcFrLbV4mTz5lvKY9p3D
	Q7vQy4ggjJl9lPPbm8qUea2AaFanVoE/N1tOl/Go2Sl8f7XsXdE9dxcc9QzFLpXK
	O/3Zj1FAkOU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10CE836C06;
	Thu,  5 Feb 2015 16:29:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98B7336C05;
	Thu,  5 Feb 2015 16:29:46 -0500 (EST)
In-Reply-To: <vpq1tm412dk.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	05 Feb 2015 22:20:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B78E40C-AD7E-11E4-BD28-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263409>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps something like this instead?
>>
>>     git-rebase - Rebuild a branch on top of a different commit
>
> I would say "Replay history on top of a different commit" instead.
> "Rebuild" may be misleading (it's not "build" as in "compile & link"),
> and the rebased history does not technically have to be a branch.

I am fine if the description were "replay history and repoint the
branch tip to the result"; the fact that branch tip moves is an
important part of the semantics of the command.

Otherwise, you cannot cleanly capture why we have rebase and
cherry-pick (which can do ranges these days).
