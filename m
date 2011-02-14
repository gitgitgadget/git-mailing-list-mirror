From: Junio C Hamano <gitster@pobox.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Mon, 14 Feb 2011 13:23:11 -0800
Message-ID: <AANLkTinpY2B0g-U4No-8rV7TFV5-z=x7AAGqgHNR7Wrt@mail.gmail.com>
References: <4D596435.9020605@gmail.com>
 <AANLkTin0xB=hJ-v21+esT6Zqj2f53XiwD8tBW4qFkuVy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 22:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5tA-0008Ie-7X
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1BNVXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:23:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab1BNVXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 16:23:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE9E03024
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:24:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=sasl; bh=q2sPazUF3OgrnTCMq3J8R3jD/dg=; b=jvvYma
	vc4gSX8j65vB/rhTVRA2GqvYE9x1L4XhKiT5+7ai8zV9OOl+PJRMBi3uko2UO55o
	SsHS8iDZsHiXupOI5NP8C5cuAcaoEdNd96YRALF2oB9WhjxxOR3hWAYLQC3eeRt9
	IfQeMdoeWgjULUjEB29NndiY0BdDvyA6eaLQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; q=dns; s=sasl; b=w754ndhn9c8slQV9Jayy1vIInBhYr4u6
	DoaCZL8FQq1YmOE787FYwFHj+O+J98pTPAyUwrP6LrV1r2ZQrTmdyGiG/UdVHFoY
	PgSl18pTcDz5aTkItKE0LwzKSnaXkQP4oRpwQ4Gz6ba7AvjWlaw3cJBgsW62qBnb
	8pPnG4dh5ME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB07B3023
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 16:24:16 -0500 (EST)
Received: from mail-wy0-f174.google.com (unknown [74.125.82.174]) (using
 TLSv1 with cipher RC4-SHA (128/128 bits)) (No client certificate requested)
 by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9864F3021 for
 <git@vger.kernel.org>; Mon, 14 Feb 2011 16:24:16 -0500 (EST)
Received: by wyb28 with SMTP id 28so5172845wyb.19 for <git@vger.kernel.org>;
 Mon, 14 Feb 2011 13:23:11 -0800 (PST)
Received: by 10.216.47.19 with SMTP id s19mr62831web.56.1297718591249; Mon,
 14 Feb 2011 13:23:11 -0800 (PST)
Received: by 10.216.80.213 with HTTP; Mon, 14 Feb 2011 13:23:11 -0800 (PST)
In-Reply-To: <AANLkTin0xB=hJ-v21+esT6Zqj2f53XiwD8tBW4qFkuVy@mail.gmail.com>
X-Pobox-Relay-ID: C71BE9F2-3880-11E0-95AC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166771>

On Mon, Feb 14, 2011 at 10:09 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I've had it on my TODO list for a while now to:
> ...
> 2. improve the cherry-pick conflict UX. I was thinking of out
> CHERRY_HEAD on conflict and then adding a cherry-pick --continue
> option which acts like rebase --continue. CHERRY_HEAD is what was
> being picked at the time of conflict and can be used by the bash
> completion script for proper prompting, as well as obviously the
> --continue option.

Yes, we have so far only "use commit -c $that_one", which is an
obvious and low hanging fruit for improvement.
Thanks.
