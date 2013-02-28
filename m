From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] git log -L
Date: Thu, 28 Feb 2013 11:56:25 -0800
Message-ID: <7v7glsi55i.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB9b4-0007Pt-1g
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 20:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3B1T43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 14:56:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab3B1T42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 14:56:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA010BE1B;
	Thu, 28 Feb 2013 14:56:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eMaqXgxh8AqvVNGf86LXwEZ7HQ=; b=eqPyqv
	LusmqLVPaXQmq6eJzIaoCxjQ1NJJR6KpO7VgXrvI8VLYJHdKfeVmVoT9qMrN/6XP
	SCgPxsL9Of6ylM+yHDvgUlT75G3XNHRBWMR8eSCIBUyp2E1H/d9FodXe7Xj3n6s4
	1BDk74WW85soAn5VbDtyzwz3CXgZ5g7nT3ayE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OQqu135W26i3TTOKNIgqcaNJFg+cAeDi
	4csc669nl4fOpGjfdZ5FVmODOfjcuGCv5g4Hhb3NKy/u/lpSSVAnhZP3qiKmSmvi
	AsgXd9xk815VtJxGzLbplYn1mrPPc3UUx9RB+4khMvy23W3wpwBg8tKib9M2ueQf
	6V5ii+LJ5Yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFAF5BE1A;
	Thu, 28 Feb 2013 14:56:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F82BBE19; Thu, 28 Feb 2013
 14:56:27 -0500 (EST)
In-Reply-To: <cover.1362069310.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu, 28 Feb 2013 17:38:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0040E02-81E0-11E2-95E1-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217253>

Thomas Rast <trast@student.ethz.ch> writes:

> For an instructive example, apply it and run
>
>   git log -L:archiver:archive.h
>
> in your git.git.

Fun ;-)

This is queued at the tip of 'pu' so that poeple can have fun.

Thanks.
