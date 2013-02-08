From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Fri, 08 Feb 2013 14:54:50 -0800
Message-ID: <7v6222za9x.fsf@alter.siamese.dyndns.org>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley>
 <7vr4kqzfw5.fsf@alter.siamese.dyndns.org>
 <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3wqj-0005iN-IT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 23:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947094Ab3BHWyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 17:54:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab3BHWyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 17:54:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 800F1CC5C;
	Fri,  8 Feb 2013 17:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4zOyJuLt0o7VLKqPb2TwKq4ZiX0=; b=yievBn
	qPVcXATYoIjf1Jb4xjTa4QZP/5NqRVS80c7cBld04uGkNGXN8bx7c0JPgGjWkcaZ
	Gz3NFbp9FSuxA6kX08M5Vf71a3BSla6IyCwYFjKcgPCaam4OCzzkeX/lIIiZFROJ
	fEdEbPjc7wyapdbJ4dl2jbE9dnanFK8Y//HQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c2xmukHmTm5QZu7vs0mu1vnGH/+9Lqy/
	EjteVAFJvSid7qRlzwvoH82/GnlG4Kaz0Zj3DQAlsjxO+JJcGObLlhW7ACyKOsfq
	I595DRJimsk16GyHcnurap3bYZldX8oOl9wpqILBLM4WgUPq4eNOfJKa+guY4WDR
	+IcrKEglozg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 754FCCC5B;
	Fri,  8 Feb 2013 17:54:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D83C0CC59; Fri,  8 Feb 2013
 17:54:52 -0500 (EST)
In-Reply-To: <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley> (Philip Oakley's
 message of "Fri, 8 Feb 2013 21:43:38 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CB9E248-7242-11E2-B25D-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215824>

"Philip Oakley" <philipoakley@iee.org> writes:

> My initial https://github.com/PhilipOakley/git/commit/e6217d simply
> updates
> -  N_("See 'git help <command>' for more information on a specific
> command.");
> +  N_("See 'git help <command>' for more information on a specific
> command.\n"
> +     "Or 'git help <guide>', such as 'tutorial' for an introduction
> to Git.");
> as a starter for the new users.

Yeah, that would be a good change to make to "git help<RETURN>"
output.

> My view is that help --all (-a) is essentially incomplete as it
> currently doesn't provide all the help.

It has always been about "tell me all subcommands", not about "give
me all the help you could give me".  You are not adding a "help"
subcommand to a system you wrote last week.  Changing the semantics
this late feels, eh, too late.
