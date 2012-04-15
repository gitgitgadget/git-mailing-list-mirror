From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] completion: trivial cleanups and fixes
Date: Sun, 15 Apr 2012 14:45:46 -0700
Message-ID: <7vfwc4zn1x.fsf@alter.siamese.dyndns.org>
References: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJXGi-000646-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 23:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab2DOVpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 17:45:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab2DOVpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 17:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8843D67C6;
	Sun, 15 Apr 2012 17:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LXycNAF/arHz06rNfOAEgDsIcJk=; b=n45Esb
	wYGbzF9aUhdxThWz7Axy95/18LR0GlLCanhe/ZGENwAJQmJiIIHcakTf53zwKGif
	W1BL1459Xst75i/ZtgsLGzajQC1TGAMThHGkQqd1CYz3NvStmdFHWOPxZyXX/Pp3
	6qOq5//MSkqDGxIKgQQeH/bD9l6XQvQ37pLQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+H4BqEIGirFi1WJyvL65+6VInl6u+JU
	riPgM2gbtvXG15tz/hd7ISC/BA9l3PEWLPvvAXEcvxQkjfF/EXF8BrR+ah/ZDfim
	ajuvChdjTXFCESQuCh4a5onsF4M2TOLrvGysod8a1G++nFwpFSUskiJb1et6IWfn
	3jc27c54+xs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ED7867C5;
	Sun, 15 Apr 2012 17:45:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1506867C4; Sun, 15 Apr 2012
 17:45:48 -0400 (EDT)
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 15 Apr 2012 22:44:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CBBE22E-8744-11E1-B6A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195593>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Just a few simpliciations, improvements, and add some missing options.
>
> This series depends on the bash completion tests patch.

It looks like it addresses more or less all the issues raised
in earlier rounds.  Will queue.

Thanks all.
