From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Thu, 11 Jul 2013 09:45:23 -0700
Message-ID: <7v4nc1rqos.fsf@alter.siamese.dyndns.org>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
	<vpq7ggyal93.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Person <Benoit.Person@ensimag.imag.fr>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJzn-0004CI-55
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab3GKQp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:45:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab3GKQp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:45:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DD32FFD5;
	Thu, 11 Jul 2013 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oK75gaYJwM1e7ZUu7lDlBSDCHf4=; b=dxOrk2
	PzuOOiqMpDHEvJ0jDFF70B0Bud2Cf43p17W+4Cl9ljY+JewROd9aX98AavdsPQbp
	k4iQ8BdILIOeBlr0aWioHDzlqjzjx4YPD34sibuCyja6NFw/OGxd11zeNjO+qS8G
	HGEVa1hi2rly1diLtwITL20DYhN6zrp549i4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SMpdWJmrBjScbF8IzPrMRxKkcZk2jIG9
	5m3xf+s8k3yZ5TgfN2WUzdEhWymaRECTGmVXPQsQRCEUfp60rVhA5FweeJ30gT/D
	hGtkBImn8wrAwtc7uahUUMUwntfzb8Nr+4n2TEdC4fcjY7Bt2wfQtvGg/AicZdtf
	DgQ6lvfbbcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9942B2FFD4;
	Thu, 11 Jul 2013 16:45:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F41542FFCF;
	Thu, 11 Jul 2013 16:45:24 +0000 (UTC)
In-Reply-To: <vpq7ggyal93.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	10 Jul 2013 10:10:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48D69F38-EA49-11E2-A1F7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230117>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * bp/mediawiki-preview (2013-07-08) 7 commits
>>  - git-remote-mediawiki: add preview subcommand into git mw
>>  - git-remote-mediawiki: add git-mw command
>>  - git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
>>  - git-remote-mediawiki: update tests to run with the new bin-wrapper
>>  - git-remote-mediawiki: add a git bin-wrapper for developement
>>  - wrap-for-bin: make bin-wrappers chainable
>>  - git-remote-mediawiki: introduction of Git::Mediawiki.pm
>>
>>  Looks like this is in a fairly good shape?
>
> Yes it is. I think all remarks have been taken into account.

Thanks.
