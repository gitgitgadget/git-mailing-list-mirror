From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] pull: add the --gpg-sign option.
Date: Mon, 03 Feb 2014 10:04:09 -0800
Message-ID: <xmqqr47kf4yu.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-10-git-send-email-sandals@crustytoothpaste.net>
	<xmqqlhy1m27b.fsf@gitster.dls.corp.google.com>
	<20140201010100.GB635004@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 19:04:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WANsb-0006T0-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaBCSEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:04:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbaBCSEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:04:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED3B769366;
	Mon,  3 Feb 2014 13:04:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9065Lm3hkwzQ41xUD2sIgh01PmM=; b=QiWo7g
	nRZ/V8SDGq7uiVXfxPDK0l2eZ/IYLJHyXGVso71zNPKYQpaLZOKpQILkWIeZ3fGt
	CoLdaJfUD8waiUE6eDv6KVn3aClZkEKaQt8BprG5SgSrqcvbQUczqFvooP29w/S+
	BLrmAoS2HbMoP0dpECQDMw2ivdW674Kf+Dz/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNynLYyNGLgIJOfUxfp725h8mUqmvqZA
	ECBSPYQ/+gWy1tQVNdRAnjkKa5Cwff5eXKFjwHK9Kcy3WfxEHBbyPGMC9AcMxFOe
	suB1ZVAt5vJB0aj8bS8nLLqGD2TTKEhn8JZ8JVgzBdmNpbKtW/zKqipVUDKap7eJ
	dl3hQ/XwjJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEEE769365;
	Mon,  3 Feb 2014 13:04:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1713469362;
	Mon,  3 Feb 2014 13:04:12 -0500 (EST)
In-Reply-To: <20140201010100.GB635004@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 1 Feb 2014 01:01:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 95EA90F2-8CFD-11E3-8E9D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241442>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  It also happens to fix the issue where the help
> text is improperly quoted.  With your suggested fix, it is now quoted
> (ugly, but quoted):

I do not see anything ugly about the output below.  Of course you
could do -S'brian ...', but both look sensible.

>   Stopped at aba3d3ff83b59627adbdafe1b334a46ed5b7ec17... am: add the --gpg-sign option
>   You can amend the commit now, with
>   
>   	git commit --amend  '-Sbrian m. carlson <sandals@crustytoothpaste.net>'
>
> Since I expect most users are going to use -S, either because they have
> a key specifically specified in .gitconfig, or because the default key
> is the right thing anyway, I don't see this as a huge problem.  I think
> I'll probably end up fixing it anyway and then send out the reroll.
