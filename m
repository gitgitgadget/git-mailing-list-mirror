From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Thu, 18 Aug 2011 21:16:51 -0700
Message-ID: <7vpqk2593g.fsf@alter.siamese.dyndns.org>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
 <7vd3g272tk.fsf@alter.siamese.dyndns.org> <rmiliuq2qlg.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:17:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuGW2-0001jo-S1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 06:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab1HSEQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 00:16:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab1HSEQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 00:16:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D59428D;
	Fri, 19 Aug 2011 00:16:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cv6lEwOLI7u8AZEFdQr7zWi7498=; b=gENjXT
	e3TLvOoFyJObURzmKIsPRFkkh/QNJxAAL6DGKraeEyvpp8b05YahWwOorTFNMLNR
	iao/js03Q4l5H6NAjz+Kn4FfnSavUvDW2tV4TMGRe3RyVSKYQJVpCVgvylH0nXWZ
	angFugRqVnhN9zl9bw4GipGZfqIc1qZMG500M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pae5NAN8aLnDrFQLtRkGVhiLatz0k3YD
	qMpsHG7xEgMcLfYACaitj4aJenkPwrF1t4G9FNYkYGJzPVallVmpd025p01nyFry
	g9+hk/6TW1FCG9/Jix1x0mG4Ly/up/LkIuDg6k++3Tgx1SOY3+dzDviKjoU1DGlH
	pbZg5mCYAzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F047B428C;
	Fri, 19 Aug 2011 00:16:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88488428B; Fri, 19 Aug 2011
 00:16:52 -0400 (EDT)
In-Reply-To: <rmiliuq2qlg.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Thu, 18 Aug 2011 20:27:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 111566B6-CA1A-11E0-BCC6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179670>

Greg Troxel <gdt@ir.bbn.com> writes:

> If what I'm doing is an abuse of update-index, do you or anyone else
> have a suggestion to make a directory in the index match a tree object?

"ls-tree -r HEAD foo" is probably what you meant to say.
