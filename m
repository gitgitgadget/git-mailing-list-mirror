From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is exploding
Date: Tue, 01 Nov 2011 13:14:59 -0700
Message-ID: <7vsjm7lhvg.fsf@alter.siamese.dyndns.org>
References: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
 <vpqty6n1ybs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLKjq-0001J3-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 21:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab1KAUPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 16:15:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076Ab1KAUPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 16:15:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7092D53B7;
	Tue,  1 Nov 2011 16:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7/MT1r9ffarRPFhJ3CwQyAljKc=; b=ltuMfM
	9OX4wyHNC6Cb0gcOG+xvKbrRrMVlo/mXqA+2LeyPwNv+gc7OhPmjrM6KaLorC6OV
	Yuz4DmNYW1eHjpFkZWxCIvJB2RSm2bLk1DOSbOpiefJdSNRR9xYJh+LwpNZPiye6
	5XGJ1q+SX9EDCFXI09KFNQlYAqZ8l9jTgfOGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNkl7WSkjPuynBi9OKKQn7RgzhtXFG+h
	xp/78l02dLmZhQhYWXfPKty7pphM0+8DfvfoLMwQQsSW9udgkEC7/ZXoRQfi8DtB
	Yz4ZLeNedxWdrrnLXmC5JmluQfkg7xTiCyxtYBj6S7R4oWUIZl2uk3DYAhUf7BCc
	wHZ3ulMR8X0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6353953B6;
	Tue,  1 Nov 2011 16:15:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6885553AE; Tue,  1 Nov 2011
 16:15:01 -0400 (EDT)
In-Reply-To: <vpqty6n1ybs.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 01 Nov 2011 19:39:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DB04E08-04C6-11E1-81D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184584>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> http://www.ohloh.net/p/compare?project_0=Git&project_1=Subversion&project_2=mercurial&submit_2=Go
> => Git has 2,659 users on ohloh, Subversion has 7,667 and Mercurial has
> 795.

Git costs $11M (6 years old) while Subversion costs $6.7M (11 years old)?
