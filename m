From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions / suggestions about history simplification
Date: Sat, 21 Dec 2013 22:44:43 -0800
Message-ID: <7vr495jsf8.fsf@alter.siamese.dyndns.org>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
	<20131219190333.GE23496@pacific.linksys.moosehall>
	<xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
	<20131219205858.GJ23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Dec 22 07:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VucmJ-0006sD-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 07:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3LVGok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 01:44:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab3LVGoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 01:44:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C112E4D425;
	Sun, 22 Dec 2013 01:44:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vrDVzpfxxoQ/JyI7mOM+KxyNOwU=; b=kaJjA/
	NhQBDZRF4YvP9fOYm345iwONArErqdzcHLXh1KnQtCzLOaeea7fzTMcWR5hNMVJO
	x96cKWxrvzPbWYGIBXXt8PMWyJHWGNY49R02AsP+QcIDRiVC/NrxWk1dCfCG3LxF
	hxQ3muMShHX8KFLzQpSaH8yE6Lwf+CE0uLX6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=woFhbTK7n2ZZ1sx/kYCvsXi2lCy+uthu
	zuHS/x5kjoljudg0J7D9xjaIpQ3CAV2nARUmP+dh03cnuY0WNZc3WEIPzRIEPfdc
	fpVaTrJaGQfulAd5ghNk0KRvA5zfveCw4uIglXTUXgBoKTDtKq0V4AeXM1W9lNa4
	6c9Gut33SfI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1784D424;
	Sun, 22 Dec 2013 01:44:38 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DC104D422;
	Sun, 22 Dec 2013 01:44:37 -0500 (EST)
In-Reply-To: <20131219205858.GJ23496@pacific.linksys.moosehall> (Adam Spiers's
	message of "Thu, 19 Dec 2013 20:58:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 86AFFCDA-6AD4-11E3-A15A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239632>

Adam Spiers <git@adamspiers.org> writes:

>> I doubt it.  75% of the work for such a person to understand the
>> behaviour from such an example is to understand what kind of history
>> the example is building.
>
> Agreed.  And that's precisely why I wanted a real repository
> manifesting the given example: being able to view it in gitk makes
> that a lot easier to understand, for obvious reasons.
> ...
> Well I didn't roll my own; I just copied the example from the man
> page.  So it only tells you that I was spending a fair amount of
> effort trying to understand the man page ;-)

Oh, that part I would agree, but then ...

> Not if the man page says "if you wish to experiment with these options
> yourself, you can easily recreate the repository in this example by
> running the script contrib/foo bundled in the source distribution".
> ...
> The goal of sharing the series of commands is not to educate users
> through reading them, but simply to save them the time they would have
> to spend manually recreating the example scenario given in the man
> page.

... this part could be even easier if distro ships a sample repository,
not a recipe to create such a sample repository, no?
