From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sun, 20 Jan 2013 11:02:08 -0800
Message-ID: <7vobgjllu7.fsf@alter.siamese.dyndns.org>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
 <379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
 <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com>
 <7vehhfn1r0.fsf@alter.siamese.dyndns.org> <kdheeh$ntf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0A4-0006jd-9c
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab3ATTCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:02:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3ATTCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:02:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 753DFA883;
	Sun, 20 Jan 2013 14:02:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=axEhNa1smk4ePjSlD7NNG7vlKTI=; b=BfZmtF
	Vx9zVpG6b0qL0hyBDKVnu8OP6d7IAzMMcK+QUj72wl5U7p2Eqxg1CfsiMJUPOn+t
	iBzJOllx08invd7dYdqllh9jZ7S7IxdODa6eEDnh5M8Om0+kipW07P1nj/tbuDBW
	xCMODhSI3HoUZKPAlelBsy1Ig0a2Cis7LSZnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7V85syGcAvc8HdPpfid3Ijc2P1Liu2j
	KMrBLntrwf4UUzWlDIgeTFiZNNQYjYISGc9xz8U4vGOhi6pzWHPmWTVeC85RUkbZ
	Cth/10BRobPE0/ySYDtdGNhf4MKXQrIUqldVKwdzWkJEdfW4kPOK1YbBMkKw8Rga
	wpntfUReOLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A73FA881;
	Sun, 20 Jan 2013 14:02:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDDEFA87D; Sun, 20 Jan 2013
 14:02:09 -0500 (EST)
In-Reply-To: <kdheeh$ntf$1@ger.gmane.org> (Joachim Schmitz's message of "Sun,
 20 Jan 2013 19:53:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E44B4BDC-6333-11E2-8597-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214034>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Because then it could get confused with "git", the command? That would
> be lower case even at the beginning of a sentence, wouldn't it?

Is it a real-world problem?

I think in a prose when you refer to "git" the command, you would
say something like

	The `git` command started as a thin wrapper to many
	subcommand of the `git-subcmd` form.
