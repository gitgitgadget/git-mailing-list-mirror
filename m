From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] diff: Only count lines in show_shortstats
Date: Fri, 15 Jun 2012 15:00:39 -0700
Message-ID: <7vpq908cc8.fsf@alter.siamese.dyndns.org>
References: <eae8caaf80d3bc90051de3f8f022bda01016bfd8.1339796363.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 16 00:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfeZS-0007vL-Gc
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 00:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076Ab2FOWAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 18:00:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020Ab2FOWAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 18:00:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 256D998F4;
	Fri, 15 Jun 2012 18:00:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KUohweqgTgOj7FShhfz24EsWC+A=; b=WiOg6O
	orQyBLPYVTyNKWzcQ8DRi0rSisp4PsWlb1LV9nu7/IrXZbxk4Eb/fyNC6I22bzZT
	foz9hq28YyXYgZnnig5r4VrG8eAcsbMA1HrQS6ss1NDgyLsn02IXJFJBItdzKaGG
	u/uveblyp9yPL6lUBQsaIjklocwUpQLjJFvPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0wNPsFcrWGtD0zixrNgMWptd1yA27uJ
	s+lnB23BIovVGeiJypLel8R7oqQQ8JzwzitOsxOhOkGLMu5qPGIiuSLCg6jIhOot
	JORzKo3ftHXEUkqClUu2Ti2Q7A/H80TpElmfFLST7ZarFM9kAiNpk9rCpj9rcHUo
	I2oT/8G4UGE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB7B98F3;
	Fri, 15 Jun 2012 18:00:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A71D798F1; Fri, 15 Jun 2012
 18:00:40 -0400 (EDT)
In-Reply-To: <eae8caaf80d3bc90051de3f8f022bda01016bfd8.1339796363.git.eclipse7@gmx.net>
 (Alexander Strasser's message of "Fri, 15 Jun 2012 23:50:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BF344EE-B735-11E1-9CCB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200104>

Alexander Strasser <eclipse7@gmx.net> writes:

> Do not mix byte and line counts. Binary files have byte counts;
> skip them when accumulating line insertions/deletions.
>
> The regression was introduced in e18872b.

Thanks for a last-minute fix.  Will apply directly to 'master'.
