From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Vietnamese l10n pull request problems
Date: Sun, 27 May 2012 22:23:15 -0700
Message-ID: <7vr4u46fr0.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHWsfNSVESsZ6KoSH+_FEuLrrESC1_N0=DB5uMaWSv+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 07:23:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYsQs-00077W-4A
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 07:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2E1FXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 01:23:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab2E1FXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 01:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D66525B61;
	Mon, 28 May 2012 01:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=21QGArS1+HOqvfdEpJO0wdQP2ow=; b=xam3hZ
	sFIu7Dk671sgMeWojrp5Hq3SlIZ4T++pnk+i34NKUaFFb03TiAAtpsCyDDtLjo+6
	zgp2FCwLrU3KFVQ610Z1nL8xpVM23p8Au99Cxrj1meVEImOJgAdLUQx7v9sfV7lx
	r0EOcFe66BYb1evdY6UCxt9nmsnXiSuiYL7v4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQk/8hx5eMjNLK9iWqXPjhbrxakbzSBE
	lHo+sUyHN73ZE5eafAqGz7Pa1pe7dig0B3Cw6obPff6bvIGwg2hzHrqxhR2oe3QZ
	mFz3i4c/nl8++F04DaNvUCh4DJxBrj1LUlCFQNI6cmvGmfcHj/Ay8aHQTvmDXhQZ
	CoiZAb+v0jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3B15B60;
	Mon, 28 May 2012 01:23:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BA8F5B5F; Mon, 28 May 2012
 01:23:16 -0400 (EDT)
In-Reply-To: <CANYiYbHWsfNSVESsZ6KoSH+_FEuLrrESC1_N0=DB5uMaWSv+Xg@mail.gmail.com> (Jiang
 Xin's message of "Mon, 28 May 2012 11:31:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A86F786-A885-11E1-883C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198626>

Jiang Xin <worldhello.net@gmail.com> writes:

> Vnwildman, the new git l10n team leader for Vietnamese send me a huge
> pull request, it has some problems I think other l10n teams should care about.
>
> The URL for the pull request is https://github.com/git-l10n/git-po/pull/22 .
>
> 1. Commit log should has a signed-off-by line, no dought

There doesn't seem to have any S-o-b:.  Please reject and kick this
series back to the team and ask them to redo their history.

> 2. Trival commits (from the same contributor, with not description in
>     commit log) should be squashed or not, I am not sure.

As you noted in 3., there are too many useless merges directly from
me, and after remove them, there remain only commits with useless
single line subject "Continue translation into Vietnamese." (even
for a single-line log message that is wrong; omit the final
full-stop).

I think the reason why these have the same useless subject is
because they are separate only because the translator happened to
have stopped between commits, not because each of these is logically
separate and deserves a unique message.

They should all be squashed into a single commit, after removing the 
merge in the wrong direction.

> 3. l10n team leaders should not merge git upstream directly.

Again, very true.

>>> Oh dear!I hate to change history!

That is not a valid excuse. The history leading to e4797a3bc277 will
never be in my tree, and if Jiang pulls it, the I won't be able to
pull from him either, so as far as wider upstream git is concerned,
the history did not even exist---there is no harm rebuilding a
history that never existed in the first place ;-)

Thanks.
