From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC idea] Resumable clone
Date: Mon, 02 Mar 2015 15:47:27 -0800
Message-ID: <xmqqoaob7yi8.fsf@gitster.dls.corp.google.com>
References: <CACSCj9wkx1cSqcMbkt8+2S0GCzuBNeUjXyb4=n5_K7QzL_jawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSa3i-0002J6-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbbCBXrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:47:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753447AbbCBXra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:47:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E61F3D139;
	Mon,  2 Mar 2015 18:47:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gUhJv2KvwqHUKdnG5ZfM3loqTnQ=; b=h3cnQq
	mHeCLDuhVyg3fO7GIXoP/4ij8NVMBKP5ZAtppjaY9PZdeAkLTpBvFxK2UAKL3NVx
	Cz7bINSAMws2CkKOpsUP2ICs0PUvHwLgRck0bVYBMCXekwlwrIon1g+IwtJxtEBP
	6ASGrpLiDfZgn7lA6RYT0E7JqTFbOjodfcxXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BA4nvXAjjAY2sTxmr3T5LNkQRvJJPx8W
	tHg+di7HI1CORgOY4NQTbJlhujQtlgYvummen6YuJnF70MT6tU82fLBFFz6GUiMo
	hedHnENPByj0TQdzfsgbSXu5qtO3d6npYc2zF6QN68mUCy/gXs4GLXGp7eBDPvJJ
	D1Nff+19KgY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 658833D138;
	Mon,  2 Mar 2015 18:47:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC2B83D135;
	Mon,  2 Mar 2015 18:47:28 -0500 (EST)
In-Reply-To: <CACSCj9wkx1cSqcMbkt8+2S0GCzuBNeUjXyb4=n5_K7QzL_jawg@mail.gmail.com>
	(Koosha Khajehmoogahi's message of "Tue, 3 Mar 2015 00:33:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C806E16-C136-11E4-BC46-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264637>

Koosha Khajehmoogahi <koosha.khajeh@gmail.com> writes:

> Among GSoC 2011 ideas of git [1], it was proposed that a GSoC project
> could be implementing resumable clone for git. AFAIK, this feature is
> still missing in git but could be a great idea to be implemented. Does
> that sound OK to the community?
>
> [1]: https://git.wiki.kernel.org/index.php/SoC2011Ideas#Resumable_clone

Depends on how it will be implemented, I guess.

I highly suspect that it would not fly well if it is added as a part
of the current protocol, as people are actively discussing how to
revamp it.  And I have a feeling that the v2 protocol would not
ready for a student to build upon by this summer.
