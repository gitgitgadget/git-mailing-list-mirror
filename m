From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Mon, 17 Mar 2014 10:21:27 -0700
Message-ID: <xmqqd2hkg2qw.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<EA1EF5746EA7414CAE1320AA61100178@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "Ramkumar Ramachandra" <artagnon@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 18:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPbEN-0001fj-89
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 18:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbaCQRVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 13:21:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910AbaCQRVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 13:21:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 273677526D;
	Mon, 17 Mar 2014 13:21:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5BFsWzPev2zuBYpm7D7LCoPdWcU=; b=OWpv/z
	UGwqwww8ANzzWSt3r1r1xm4GmY8Lp2RMnLFzs5SWRxPh1I/RwxEGV8OAFKaPqFUf
	eUUg/N0100IBVkO79+CdcfzM6FQoc9l5m5eg6XFrm43Dx29/3qFVmeVYS+hSO2KR
	KCPTfOMussDFXhfXPB8G52JTNItIs7E74faoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jwtUY47wYKr7suQQcdTY9oZIzhFe3a32
	yNbf1oDDpCfnpsx7iReD55Ybi0zLWgS2iT3Sbc9bwBdl5bZkVAb9QlqrUQQm4dfS
	aAUbRcP9bitpQ8jfNbrutT80500Dd5FK0wMclLOEQwXrQew/AI3mnTWd0J6WPJur
	yc+vZP07Z90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152E57526C;
	Mon, 17 Mar 2014 13:21:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DAF175269;
	Mon, 17 Mar 2014 13:21:30 -0400 (EDT)
In-Reply-To: <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley> (Philip Oakley's
	message of "Sun, 16 Mar 2014 18:30:49 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 945DF140-ADF8-11E3-83BA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244258>

"Philip Oakley" <philipoakley@iee.org> writes:

>> * po/git-help-user-manual (2014-02-18) 1 commit
>> - Provide a 'git help user-manual' route to the docbook
>>
>> I am not sure if this is even needed.
>
> My rhetorical question would be "what should 'git help user-manual'
> do?" for the beginner, ...

Why would any _beginner_ even be expected to ask "git help"
everything, including "user-manual", in the first place?  Wouldn't
things like /usr/share/doc/git-doc/ be the place to help them in a
consistent manner across different programs instead?

> ... do we have a sort of policy on ensuring
> that the majority of user documentation should be available (or at
> least referenced) via the 'git help' mechanism?

I doubt that there should be such a policy.

"git help" is primarily to show the manual pages, and some technical
details docs that are referenced from manpages may need to be
reachable from it.  The user manual, on the other hand, may
reference individual manpages but because it is primarily a document
that shows the overall flow to employ different commands, individual
manpages referring to the user manual feels entirely the other way
around.
