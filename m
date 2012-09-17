From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 13:35:17 -0700
Message-ID: <7vvcfctmka.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr>
 <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr>
 <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
 <vpqvcfcps2z.fsf@grenoble-inp.fr> <7v4nmwwqox.fsf@alter.siamese.dyndns.org>
 <vpqipbcpp69.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDi2U-000297-2d
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab2IQUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:35:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab2IQUfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:35:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3058141;
	Mon, 17 Sep 2012 16:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BdMnIXpR2AhsI3tNXhP1PNlVtEQ=; b=vcT99M
	PfDQL+KwLhecfLmRLbGsiEr3md8UbE3kY6KAhLciGPPLje3fvMRHYLnqfh+ST36c
	SZ7O1Q0Bi1PEQAj2O6HkkU+7vdujccxgYshV6uhoXW1vHS2ZsiyugL7QyMKXFPyd
	9ym/b7b7g1lbuTk9MXoafO1V40JUK+M9d6pP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F6FF3ZEAkBKMXHDAaSKKLPZP3v8e/bTw
	oIQzg1wrRumM1iWbUkW3lmZhRYstxGqhS3ywC99ZKKzuurF+JsUf/fapFE77APe3
	pGgJ0zs6eloTsr58TvkNLJuqTlZBs4eOvoK5H6jzQJFYld+BM1lr8SFphgzlozVQ
	AEcyDpIlfZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 084138140;
	Mon, 17 Sep 2012 16:35:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63F10813F; Mon, 17 Sep 2012
 16:35:19 -0400 (EDT)
In-Reply-To: <vpqipbcpp69.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 17 Sep 2012 18:52:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3242CE26-0107-11E2-BD70-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205740>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't been paying attention, but does that mean on that system,
>> a total stranger kseygold can write, modify, and remove whatever Ram
>> owns?  I am hoping that is not the case.
>
> I can see two reasons for having the same UID for two login names:
>
> 1) the sysadmin really messed up, and as you say, a total stranger has
> complete ownership of your files. Ramkumar, you should check that this
> is not your case.
>
> 2) the sysadmin explicitely gave two login names to the same physical
> person, as kinds of aliases for the same UID (e.g. the person got
> married, changed her name and login, but expects ~oldlogin to continue
> working). I'm not sure how common this is, and to which extend we want
> to support this in our test scripts.

I've only been assuming (1), but (2) feels like a legitimate (if
confusing) way to configure your system.

It is a separate issue if it is worth bending backwards to support
it in the test, though.
