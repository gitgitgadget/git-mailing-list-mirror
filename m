From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] struct ref_update: move "have_old" into "flags"
Date: Tue, 17 Feb 2015 07:52:57 -0800
Message-ID: <xmqq61b04js6.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kYqx8s8Cz29Qn1aBtCnDOkR-Guk4RM-_KQeO+nHWv=r8w@mail.gmail.com>
	<xmqqsiebrlez.fsf@gitster.dls.corp.google.com>
	<54E35220.3010302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:53:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNkSX-0006dw-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 16:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbbBQPxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 10:53:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751686AbbBQPxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 10:53:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3013371FB;
	Tue, 17 Feb 2015 10:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HeAzHNFNlaBXLjf0ol8OoqHSPbY=; b=lf1b8A
	QEuZwMQsmKb4D4d/e2OiCVlKtOuJKXguuIOAsmE0ISsMEHL4Tk4wICc6KGETO8N2
	C3HXFXih/eHYUqEL9hsu/jW2EoSdh6/amRBbxObNWKNM2W3lbUqNzlX4e4g/p/1u
	CU+E2EV7xtjo3OiVy3rNI8Qf7E6ewO21FwT3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NybsdTL2YlrbfvZEGpX47w5Ui47RtAiS
	9Cfba0GNMoTpGInUJeKhgfRps42XyoLbAOppIaES792wIhU0jvtJhZ5Xms1Njpvc
	KEDKRcVjk3Z/DbaG9Utps1soBQOmX3HcjwnMY6PKKkBLpAtb6E+XiOgxIeOQtUTA
	hPcSn2vgXEo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9957371FA;
	Tue, 17 Feb 2015 10:52:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10DAC371F9;
	Tue, 17 Feb 2015 10:52:58 -0500 (EST)
In-Reply-To: <54E35220.3010302@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Feb 2015 15:37:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BCA0016-B6BD-11E4-9AB2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263949>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For example I want to rename the constants to REF_NODEREF ->
> REF_NO_DEREF and REF_ISPRUNING -> REF_IS_PRUNING [1], but am leaving
> that for when the refs code is not in so much flux. I can reorganize the
> constants and docs then.

These renames are very sensible.  Thanks for your attention to the
details.



>
> Michael
>
> [1] As I type this I realize that the comment misspells the name of
> REF_ISPRUNING. I'll fix that, too.
