From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: list git-credential in plumbing commands
Date: Wed, 08 Aug 2012 09:58:33 -0700
Message-ID: <7vmx25tj5y.fsf@alter.siamese.dyndns.org>
References: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:58:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9aj-0007Wa-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab2HHQ6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:58:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758508Ab2HHQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C329285CF;
	Wed,  8 Aug 2012 12:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aTQvRWoMOJaqvjqjp+/ooWHySKA=; b=sOJF+G
	AuMHxQsM2vZKGtbdbCWfnCzLGJAII8nf914Ub0kwwTO577Hg9shrl/Fu0LI3kzbH
	YOSro1ItRYDNAvFsU2yd0SklfJZ7X7C3h3QP/Dt9vxgRwRnO5vIT+vd2OL6HE0xZ
	1/CjPt+IYxiIxm60g05t4rWEoUprHJdmBQTYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pYs1DkRNfUa5IsyymNzqQFXq65V3t7AF
	+xmeuZE39WFDLOz+BWysMAdEj/XBWUmBeg/wVWf5ESXg3Ei5C0/msD17rnXvFx35
	7+dvNPfPqlbLkoiuZsm2HhOy7ELspXxW1XpIa6ZHSyZ0nHyGInwXlaSls/ykhmEt
	e+aeEBDGrEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A0685CE;
	Wed,  8 Aug 2012 12:58:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31E7C85CD; Wed,  8 Aug 2012
 12:58:35 -0400 (EDT)
In-Reply-To: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed, 8 Aug 2012 09:58:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AA080DC-E17A-11E1-BC0D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203099>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Commit e30b2feb1b (Jun 24 2012, add 'git credential' plumbing command)
> forgot to add git-credential to command-list.txt, hence the command was
> not appearing in the documentation, making it hard for users to discover
> it.
>
> While we're there, capitalize the description line for git-crendential
> for consistancy with other commands.

consistency?

>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks.

There really should be an easier way for the maintainer to notice
this kind of glitch without being told (better yet, the submitter of
a new command to notice it).  Perhaps the check-docs target in the
Makefile needs some updating?
