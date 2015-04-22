From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 0/2] git-p4: improve client path detection when branches are used
Date: Wed, 22 Apr 2015 10:11:43 -0700
Message-ID: <xmqqegncf5ps.fsf@gitster.dls.corp.google.com>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkyBv-0005QP-Ho
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966918AbbDVRL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 13:11:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966676AbbDVRLv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:11:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 954804A5FD;
	Wed, 22 Apr 2015 13:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLL56fhSOATiS1rA7VzTa5UPgS8=; b=r9oS1b
	txL+gAUK/amnmyxTNYwzISQ9bD/fb0FfDL+FPs+8L1UyXi1IR33BZEHvoGZqRZy9
	GDlcBzm+6dm66pC1EgamBbXxDa+6gSpc807vsYPL3ATP66vXv4lJIiztCPZczkqq
	ZJuBf8nD3rzTI46RRmIHBn64Tyk5TfFLpbz5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ER5rCO5zZQImOOzkQou2U4ktAxPrjqH/
	PdZpC75iDAJveag2zzkP8P96PSgB1fGMhqE8Qnh9A/QHFpCeNhXbNgOFduTidYpZ
	ZNkw0AdRgkrhb6MG5axa4zlzDkNH5CYKHrbd8QFzR5DttygwU9PYSDXfiWGt7Vpg
	YtD514TlL0s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E7074A5FC;
	Wed, 22 Apr 2015 13:11:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 092C44A5FA;
	Wed, 22 Apr 2015 13:11:44 -0400 (EDT)
In-Reply-To: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Tue, 21 Apr 2015 23:49:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7203B20-E912-11E4-B276-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267597>

Vitor Antunes <vitor.hda@gmail.com> writes:

> The updates introduced in the third revision of these two patches consist only
> on updates to the commit messages to better clarify what they implement.
>
> Vitor Antunes (2):
>   t9801: check git-p4's branch detection with client spec enabled
>   git-p4: improve client path detection when branches are used
>
>  git-p4.py                |   13 ++++--
>  t/t9801-git-p4-branch.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+), 4 deletions(-)

Thanks; will re-queue.  Luke, could you comment?
