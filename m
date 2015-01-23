From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-p4 maintainership change
Date: Fri, 23 Jan 2015 14:42:07 -0800
Message-ID: <xmqqppa5p1a8.fsf@gitster.dls.corp.google.com>
References: <20150123214849.GA3866@padd.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:42:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmvh-00028H-Da
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbAWWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:42:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752011AbbAWWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:42:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 497ED31CB7;
	Fri, 23 Jan 2015 17:42:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3vapAT9GpfqGx38l07qvcN+FO0=; b=tWGCen
	MrQsLgf268BYqqgdrEzoVc3yEd3b5zpERqqwV7zOAfJlSOdxplOdsUg96qfoI8yu
	PBHp8yQQNMWC2bctISY2xjdcyQi3nwgqQ72SkCYEfVm1e7ZvWhTkjphyprCYm9Dd
	xFduaTW9lloEr4xHjgU4OOyRuwSj2eRpzZZpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fmsCVRzB9qTObNF0VSGq8TTf6OznFKUl
	AJes8cXA3wF8I3BEK4ZXk3VWN+xGBpWuFJ5ku/Q0niaVO4lbAtANuAv6y2ImKlUA
	U2zhn6zzFoSD1C/R21VCR1t/MDGWOcpfwSv4VtZW9r3xw1SPDUVwzubXQ7WJqDoW
	2Fxs5EuXXPE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D1AF31CB6;
	Fri, 23 Jan 2015 17:42:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FAAE31CB5;
	Fri, 23 Jan 2015 17:42:10 -0500 (EST)
In-Reply-To: <20150123214849.GA3866@padd.com> (Pete Wyckoff's message of "Fri,
	23 Jan 2015 13:48:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 114E7EEC-A351-11E4-A694-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262973>

Pete Wyckoff <pw@padd.com> writes:

> Hi Junio. I'm fortunate enough to need no longer any git
> integration with Perforce (p4). I work only in git these days.
> Thus you might expect my interest in improving git-p4 would
> be waning.
>
> Luke, on the other hand, continues to need git-p4 and is
> active in improving it. I think you should consider accepting
> patches in that area from him directly. He's contributed many
> patches over the years and has helped users to debug their issues
> too.
>
> I'll certainly be available to comment on any dodgy code in there
> already, and can help with archeological, but will not likely do
> any substantive work to git-p4 in the near future.

Thanks for your help during all these years, and thanks Luke for
taking the area maintainership.
