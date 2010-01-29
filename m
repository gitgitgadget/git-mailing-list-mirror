From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 12:48:16 -0800
Message-ID: <7veil8iqnj.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naxld-0003g1-GN
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0A2Us3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802Ab0A2Us3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:48:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab0A2Us2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:48:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA3295406;
	Fri, 29 Jan 2010 15:48:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7eBrJjyXyFyQRrOoJIl1GGeuY2w=; b=AKBmMb
	zx0G09ZR1w3MS0thuokQj2RF//1WCXYtjQp+vgl76JvdKVn+2j8cc8q+/jgRmq0I
	6n04/QORx+U6RIHYoYIgL3CnU1VDNACoxbR0pK/72oNjjZot4ofanvDyqdWsrXAP
	JhnkrWrxkiEgztf5dfOmn4L1Dbl1KRhAYM8wY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SUN5K4qr3czHT0L5hO0N1UoPrb5HIogU
	j/5m/NLdEV2vpHVC2l4ychSyHdvPy/DMlO/vTPKW85ZIclD+mVFPkLW5CGeqIxI8
	GieZ+CHAVCDMyd74NgAV7wICOUkUF5h9sh/EcrD1GExwzyqUL+KS5ECUiErqNV3i
	PFrhT6LvNq4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A29295404;
	Fri, 29 Jan 2010 15:48:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A816495403; Fri, 29 Jan
 2010 15:48:17 -0500 (EST)
In-Reply-To: <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 29 Jan 2010 21\:35\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A39BF71E-0D17-11DF-8699-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138354>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> master^ is a commit (the first parent of master), not a branch (local
>> or otherwise).
>
> Perhaps we should change the message to say "not a branch" if it's not
> a reference to a remote branch? Or simply changing the text to "not a
> (local) branch"?

I think "not a branch" is a good suggestion, whether the target of
checkout is "master^" or "origin/topic".

These days, you can say "git checkout topic" to automagically create a
local "topic" branch that forks from "origin/topic" remote tracking branch
when you have one, thanks to Dscho's UI improvement ideas (one less
reason you may end up on a detached HEAD state without wanting to).
