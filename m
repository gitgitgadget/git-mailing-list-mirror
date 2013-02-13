From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 11:53:19 -0800
Message-ID: <7vmwv86le8.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
 <7vy5es9o0g.fsf@alter.siamese.dyndns.org> <1360777065.13768.17.camel@mas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iOp-000866-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 20:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996Ab3BMTxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 14:53:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab3BMTxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 14:53:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30BABB777;
	Wed, 13 Feb 2013 14:53:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7DdcJ1oUMEQo04vFyCWxO9KC7/w=; b=CQqzPJ
	teAbrNlatP24GnkP8pkeSGcvakyphtqszwxODp7GktXVgN8hq48FBj04HEzVqkYG
	d9ErhOh2zEMMh5T91krdYfARHB7Ljkx3pLFmRbymeQlGrrC+homAE3F/pFPtQQft
	1fTHcC5HQGwdWm1WTEIS+O+n/MFofF2XiCHXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Isov4cztkHEbd3qUrcjDJTDTZfsk2byL
	ETywgVALrjPPXZir44BwdPdGP7qiqEBydop7n8Rmqk+Q4rq0cLaGA1m7FAhPQjyt
	f/q9ESzYyOGHJ5E1jmfFJeP91nEMcYdgnC9vXa40vCU+j18BrwVTt+YfHcR5qjcu
	xYSxEDLpZLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DD83B776;
	Wed, 13 Feb 2013 14:53:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94EB1B773; Wed, 13 Feb 2013
 14:53:20 -0500 (EST)
In-Reply-To: <1360777065.13768.17.camel@mas> (Martin Erik Werner's message of
 "Wed, 13 Feb 2013 18:37:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 047D5774-7617-11E2-ADA8-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216279>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

>> Strictly speaking, you have 6 not 4 combinations (shell variable
>> set/unset * config missing/set to false/set to true).  I think these
>> additional tests cover should all 6 because "config missing" case
>> should already have had tests before bash.showDirtyState was added.
>> 
>
> Indeed, I only mentioned 4 since the other ones existed already, and I
> didn't change them, but maybe it should be mentioned as "combined with
> previous tests (...) cover all 6 combinations (...)" then?

It should be sufficient to change the third line of your original to
say "the config option being missing/enabled/disabled, given a dirty
file." and nothing else, I think.

>> Sign-off?
>
> Ah, just forgot the -s flag on that commit, yes it should be Signed-off
> by me.

OK, I'll locally amend the patch.  Thanks.
