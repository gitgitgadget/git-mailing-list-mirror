From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FW: question about merge in 1.7.10
Date: Fri, 24 Feb 2012 13:55:52 -0800
Message-ID: <7v4nufopzr.fsf@alter.siamese.dyndns.org>
References: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local> <4F47E51B.6080401@in.waw.pl> <1F026B57884A5841B330471696849DE9114508EC@MBX021-W4-CA-5.exch021.domain.local> <7vbooox6xy.fsf@alter.siamese.dyndns.org> <1F026B57884A5841B330471696849DE911450B9B@MBX021-W4-CA-5.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S137S-0003jU-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171Ab2BXVz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:55:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917Ab2BXVz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:55:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 664167755;
	Fri, 24 Feb 2012 16:55:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8fbA0Hw+8XwpIRy5pht7mbjdK4Q=; b=rV6XY9
	+DR1tbpOW5o97rsOjpY+WR5uJYMKPAaxqdwt9wdFJ+k2XjH+B92L7wcZkKtFpTv9
	IQGZ+XB0/kMJbvKSRRzQ6Z3pn/kiazCxUd1dEHx0Eu9ugNt1/j+93ZE00EW0w+KT
	YYTpO0W9zdJ7So9fVJbKW9Udqlx51eaNYjhLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ptz69pfCCUrtK/vElJycV431ePjeOLYM
	yZYYiH/mn0X5HKQU1KM+zpyyv6jUqEndH1Llvfz5PO9/Bi/kghqYWnnR7Q9iBgUC
	iiRdr26RX1ZRoVrPrt10tG4mGMUDKMOMlepzTVmypZifiDXfQXoSSVNc6Z0ecIXC
	D5P9JhfYb/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CC4D7753;
	Fri, 24 Feb 2012 16:55:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C555D7751; Fri, 24 Feb 2012
 16:55:54 -0500 (EST)
In-Reply-To: <1F026B57884A5841B330471696849DE911450B9B@MBX021-W4-CA-5.exch021.domain.local> (Marlene Cote's message of "Fri, 24 Feb 2012 21:24:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 534A4B84-5F32-11E1-80B2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191490>

Marlene Cote <Marlene_Cote@affirmednetworks.com> writes:

> Sorry.  You are correct.  You said it would open an editor session.  

Whew.  I was really worried that we may be sending a wrong message and
making users needlessly afraid of changes.

Thanks for a prompt response.
