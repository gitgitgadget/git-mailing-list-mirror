From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Tue, 11 Mar 2014 14:03:08 -0700
Message-ID: <xmqqk3c0o3cj.fsf@gitster.dls.corp.google.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:03:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTpg-000168-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbaCKVDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:03:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358AbaCKVDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:03:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75B6070BAD;
	Tue, 11 Mar 2014 17:03:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sodjp3riul01eeHpO6Y0KRn+mg0=; b=vc2xlE
	SQLFbSecEU1VF2qRB2rFdTpMnvRm53xuiTCbYyu+pXXJu7qxyP6Sd/mK9y72trAv
	sJITbALvp+WBuLtt+0GqbV0lBgnsDs4pGHYsIP8XAOyhd7rt3PmiZ1p7EeuShcUQ
	qdU32qN54+zgI2dpd6+XIh+Izg3MnLYm8L5Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ya6uQSCqanD+aSWdSyYQaCUwpvkP6kzh
	t5HT6VmdVSkyO1mZwRkh8OK8mI90/Dvn+uvAkkoOPqviraZ2conWfy/Wi3TBxFfC
	/ImbQ9yFqLNJoanoV/7rGpr9x4ltDI3juEuOPg70xjML9xUn0HvtBECjruxLTZ/0
	Dp7PXLlbpT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6127F70BAC;
	Tue, 11 Mar 2014 17:03:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 970F270BAB;
	Tue, 11 Mar 2014 17:03:10 -0400 (EDT)
In-Reply-To: <1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Mon, 10 Mar 2014 19:49:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D72288E-A960-11E3-BE4B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243898>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> Add (failing) test: with commit changing the environment to let hooks
> now that no editor will be used (by setting GIT_EDITOR to ":"), the
> "edit hunk" functionality does not work (no editor is launched and the
> whole hunk is committed).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>
> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh

I'll move this to t/t7514-commit-patch.sh for now while queuing.
