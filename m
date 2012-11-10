From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help requested - trying to build a tool doing whole-tree commits
Date: Sat, 10 Nov 2012 08:57:41 -0800
Message-ID: <7vlie9pf96.fsf@alter.siamese.dyndns.org>
References: <20121109182024.81074BC66D4@golux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXENo-0000eh-FH
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 17:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab2KJQ57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 11:57:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2KJQ56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 11:57:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 408E59EFE;
	Sat, 10 Nov 2012 11:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3RPuMUDRIEByHfMGZfQEvJVUg88=; b=HB8nZd
	unSmKCXyuiwPL56TknUt53SooHqfsJz+54CHakqrOnARbGH4qTNSmEiEFixZhuYh
	K+sUZM30mjKi/kbBUMrGRA9J66HFxKgEAaljwbvHUkJH8mPrkB13UcLVUNu4irx/
	bINzNTP/ISKNrB+TJvdtILlqmVna8u52NiXes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+ZHGslb9SB/YP80B/jjVrvEwoR/8vWm
	Sn9cSIfn1LZF3nYuZzPGCYWe56R9kaFqMeAKiiffmggLXI6hTuUUdycoT/N2hlCY
	QRF97HCfulUGSZ7Rq0qONQtssae1nj9EcA4snz3ILDaI2CMoMz1kW73Svcdw7gMT
	kVNp2XSCuwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DEF09EFD;
	Sat, 10 Nov 2012 11:57:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E49649EF6; Sat, 10 Nov 2012
 11:57:46 -0500 (EST)
In-Reply-To: <20121109182024.81074BC66D4@golux> (unknown@unknown.invalid's
 message of "Fri, 9 Nov 2012 13:20:24 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0AFC694-2B57-11E2-9CE5-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209283>

Unknown <unknown@unknown.invalid> writes:

> (Apologies if this arrives twice. I'm on the road, with somewhat flaky email.)
>
> Because of my work on reposurgeon, I am sometimes asked to produce git
> repositories for very old projects that not only are still using CVS
> but have ancient releases not in the CVS repository, preserved only
> as tarballs.

Perhaps not exactly what you are looking for, but don't we have
import-tar somewhere in contrib/fast-import hierarchy (sorry, not on
a machine yet, and I cannot give more details).
