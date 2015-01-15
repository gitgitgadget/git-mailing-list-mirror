From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 10:51:48 -0800
Message-ID: <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
References: <20150115090703.GA12333@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:52:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBpWr-0003ys-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbbAOSwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:52:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755839AbbAOSvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:51:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5FD02FCBE;
	Thu, 15 Jan 2015 13:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E+zLmRY4RrKnikF2lyCDlPV4XMA=; b=jsj/XF
	nsUtpeJ/sUOIDKYuzob/3en9vBEvoK4egyw47xo3UegwNOuzDWlif6TyUNZxd7Uk
	C8upBZueHyKqjfNImCTb5d702OoQP6e5Um5NXyIN8n8OJtJEQf1IA2ZJ0vhzqVmV
	IKhsuoXcO3IoqMSKBaqbV0Lt4V4+oP/OIq4ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RLfWDOuD/j7j9UYaP5gkvCmvgKSXHcTt
	s/E+EOVN2gx8TsWuJnV5dB56u4wImvLIfdkrfGg7YU9RNzknm6GjuYF3Z+rO1YJh
	/snqqEf97HpP4TyR4tKgw3zVSonKd8nWDm6/9YUkoVpKhVbiLk6r7IAln90jJLPe
	/0YCOU0JjDM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD4822FCBD;
	Thu, 15 Jan 2015 13:51:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 422E42FCBC;
	Thu, 15 Jan 2015 13:51:49 -0500 (EST)
In-Reply-To: <20150115090703.GA12333@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 15 Jan 2015 09:07:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FDADEC4-9CE7-11E4-9502-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262500>

Eric Wong <normalperson@yhbt.net> writes:

> The following changes since commit 563d4e59bd167fe2eecc5480e3841d878b1c8c2b:
>
>   Fifth batch for 2.3 cycle (2015-01-14 12:44:03 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git for-junio
>
> for you to fetch changes up to a94655dcfedc6b266ba32a3d32b0d52a1ce6a928:
>
>   git-svn: make it play nicely with submodules (2015-01-15 08:35:55 +0000)
>
> ----------------------------------------------------------------
> Ramkumar Ramachandra (2):
>       Git::SVN: handle missing ref_id case correctly
>       git-svn: make it play nicely with submodules
>
>  git-svn.perl    | 6 ++++++
>  perl/Git/SVN.pm | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Thanks.  No tests necessary/feasible?  Just being curious.
