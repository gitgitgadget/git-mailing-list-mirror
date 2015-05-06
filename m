From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixed translation in config file to enhance user output message from the porcelain command(git config). This fixes the error and die function by wrapping it in the _(...) function. This also avoid the code from breaking
Date: Wed, 06 May 2015 12:47:39 -0700
Message-ID: <xmqqk2wltrms.fsf@gitster.dls.corp.google.com>
References: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
	<CAGZ79kaVhYi8amQkRMsHEWZCyMOSWr7NwRaz5TG+pyz5O79k6g@mail.gmail.com>
	<CAKB+oNt7WFqqXLwjxyoEVj2_eP2wworpb-_uXXkEvVgQgR8uTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 21:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5IJ-0006ch-A5
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 21:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbbEFTrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 15:47:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbbEFTrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 15:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F35DC4F9F3;
	Wed,  6 May 2015 15:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6bsbBESQq38x2jri+lUzCpFLjk0=; b=qXu4Qf
	Xmv4BR9Je5O0nA7Pq5KUJU1fJjScLsdbHHQWl2pWn78++jhuKUpJqhU1TFqB91LJ
	xm/qw3+qyypT4S1veDqCm7efnsrzs0+mTR/yIOHuIkQLp3SnMWXoSrzrsrL0vs+w
	MMXavr9EU+WtdYF4+Y1/XE3XyChvByuZRWA5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PoKrfKPRh0jOMl2AdjT0QEA+rci7vPbT
	4+6dyee9RTl9QRIBAT9IYBIZ1w84Hj2cDy/sTVYSImABEl/u7hDLnB6qwGcbuWyj
	lgqYnLsysCDMs/67l3DkhpqKMYEQfjAYZFxXQPeYEnp9fe2M9EJBNVP8wB2v+/Gu
	yheBBnxwSts=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC1CE4F9F2;
	Wed,  6 May 2015 15:47:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D7474F9EE;
	Wed,  6 May 2015 15:47:40 -0400 (EDT)
In-Reply-To: <CAKB+oNt7WFqqXLwjxyoEVj2_eP2wworpb-_uXXkEvVgQgR8uTg@mail.gmail.com>
	(Alangi Derick's message of "Wed, 6 May 2015 20:33:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C12C125C-F428-11E4-96E8-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268487>

Alangi Derick <alangiderick@gmail.com> writes:

> Thanks so much for the correction. So the points i should not is that;
> - I shouldn't Bcc but i should instead Cc

You are sending to a single recipient, git@vger.kernel.org; To:
should be the most natural thing to do, not Cc:.

> But my problem is figuring out the porcelain commands from the
> plumbing commands.

"git help git" should list the commands in categories.
