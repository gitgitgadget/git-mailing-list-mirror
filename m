From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 22:25:00 -0700
Message-ID: <7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
 <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>
 <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
 <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Gray <n8gray@n8gray.org>, Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 07:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQB0z-0008U7-H2
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 07:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab2EDFZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 01:25:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2EDFZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 01:25:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0503446;
	Fri,  4 May 2012 01:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wnDvWcPEhzpHmPHfnAe3ta2VvkQ=; b=GFfdBU
	7yvd0mhWsopRvQPyZOm7/fW6Ic2bA0XzfefaNE/r7td7pwggqcUdWFEWYT/8I755
	VYSBlF1s3AWgWSlebMbp0V3zHORaQNCwe7byozQFrl2ac1cOKEDgqIs/VPgl9daK
	WPDySbKY3JhxjG7RkC1CAL+E37D2OY5Y56SuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fE8MSDqipRvgQaHdKPFwPuME6AnmUmTg
	DueJyEC51/zl5L5s0qv+J+TslTiRDSi07EYAP8FhAGwQM/vFapeQuqSwyxpjw+yI
	MU8gzlGXr2j7MZ+heNwHBEzSN1vdtmkHjsIPPBv3pckZN3P5SnkTg6LEH2xUI1j3
	ryap2dZtm4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FBBE3445;
	Fri,  4 May 2012 01:25:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F34D3442; Fri,  4 May 2012
 01:25:02 -0400 (EDT)
In-Reply-To: <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com> (Michael
 Witten's message of "Fri, 04 May 2012 04:35:40 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FA58240-95A9-11E1-97BE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196989>

Michael Witten <mfwitten@gmail.com> writes:

> As for a seemingly conservative suggestion, how about using a little
> more structural white space:
>
>   To $uri_for_central_repo
>    ! [rejected]        HEAD -> feature_0 (non-fast-forward)
>
>   error: failed to push some refs to '$uri_for_central_repo'
>
>   To prevent you from losing history, non-fast-forward updates were rejected
>   Merge the remote changes (e.g. 'git pull') before pushing again.  See the
>   'Note about fast-forwards' section of 'git push --help' for details.
>
> Alas! Error output like this is constructed in the code in a way that
> potentially makes adding such white space non-trivial.
>
> Perhaps the error message system needs an overhall; rather than spitting
> out error messages from anywhere, they ought to be corralled and collated
> by a dedicated subsystem.

Didn't somebody recently rework these messages quite extensively?
