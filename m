From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] git-svn: svn.pathnameencoding for dcommit
Date: Mon, 22 Feb 2016 10:00:46 -0800
Message-ID: <xmqqr3g47hgx.fsf@gitster.mtv.corp.google.com>
References: <1456109711-26866-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXumz-0003UV-C2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 19:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbcBVSAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 13:00:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751784AbcBVSAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 13:00:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 522D345E7F;
	Mon, 22 Feb 2016 13:00:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ojevfzw6qUVWc+wBEXxuftMgwlY=; b=kSM1ln
	MqMypuXDF2U4vEDNxMvJ3/LWuUOAyigTZb+l/xaRL0BIQ0fPK/RCiSooxVsc+c7+
	MfKzDy+HQ2UsdVIfOZIhXYcjzkBh5lVcOwzJJ7C4spKHH20xVVDxNA1RGhorBHoW
	+8/J4qS+QB91bT0UtsFKsHjH1C0dMTVjCHmp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HIUqL5wS67PCzfVM2pduU14eItIMuzLG
	JWEMSj7zQnzm+4ykm3iIHigi8xeFCO2V6KhUphcoM8kXZ5r02+ChR76sKAzk8ddu
	7tkn52R3QYM6CvvNIvLQCfUA894HW2jUX0zL5FUYCoy9ULXV09Ed1cTZyP9bNRoj
	w8AVGVDV9zY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3520A45E7D;
	Mon, 22 Feb 2016 13:00:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91AA845E7C;
	Mon, 22 Feb 2016 13:00:47 -0500 (EST)
In-Reply-To: <1456109711-26866-1-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Mon, 22 Feb 2016 02:55:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 336E7F3A-D98E-11E5-A5BA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286938>

Eric Wong <normalperson@yhbt.net> writes:

> The following changes since commit 0233b800c838ddda41db318ee396320b3c21a560:
>
>   Merge branch 'maint' (2016-02-17 10:14:39 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git ks/svn-pathnameencoding-4
>
> for you to fetch changes up to 1b42f45255de5844b7fe8d0c60fea74cd5b9f954:
>
>   git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-22 02:29:36 +0000)

Thanks.
