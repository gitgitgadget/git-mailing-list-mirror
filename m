From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame --reverse selecting wrong commit
Date: Sun, 29 May 2011 23:47:48 -0700
Message-ID: <7vlixoofaj.fsf@alter.siamese.dyndns.org>
References: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
 <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com>
 <BANLkTimXppE9sCW8tMntbD8p5-bRVFLHmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 30 08:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQwGf-0007gs-Lg
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab1E3Gr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 02:47:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1E3Grz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:47:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 022F06AC8;
	Mon, 30 May 2011 02:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gGCWv0OKcEpplwTfrFf9bqiUkZ0=; b=bCZtIo
	+0ZAa3uz3JjH5vUYQuUSZmFNWaih3FcrzX4gCO+RR8FschlkoTR0LS8KJa5H1gT9
	+fMMj7d61z2AvYytnKWnVCHdORN966ZCIRTB6LqdaER3jXhSAOz42QqCBqC2Pyh3
	i2px3idAwYAqiFBNlNoUss0iFqYZjF9Ne0hY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQY9jbuTdibt5piIDvBGfYySkvBvuQGR
	UkjVJW0T7bALiq9pLPAhu58x6bB1CKM+NzYa6M9Ypd95oX+Dav5IWirNqjnzgXt/
	rddr2ZcWps+10A3cHBA6o8ij4N37tZTe+qbXvT9GEdQc+7KMqiKdiNE1ZdED6lEW
	pL8KizgSEfs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEF556AC7;
	Mon, 30 May 2011 02:50:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D5A6A6AC5; Mon, 30 May 2011
 02:49:58 -0400 (EDT)
In-Reply-To: <BANLkTimXppE9sCW8tMntbD8p5-bRVFLHmQ@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 29 May 2011 20:11:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0ACA48A6-8A89-11E0-98DD-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174728>

Shawn Pearce <spearce@spearce.org> writes:

> Rereading commit 85af7929ee ("git-blame --reverse"), it seems you left
> this an "exercise for the reader"... and in the past 3 years, no
> reader has stepped forward to implement the exercise as a patch to
> blame. *sigh*

Yeah.

It has always been my opinion that asking for "one commit past the blamed
one" is a undefined request (after all, blame for the line fell on that
commit exactly why the next commit does _not_ have any corresponding
line), so that is why I punted there.

Now we seem to have found one interested reader, eh? ;-)
