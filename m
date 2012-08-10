From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merging confusion and question
Date: Fri, 10 Aug 2012 13:16:38 -0700
Message-ID: <7vy5lmijtl.fsf@alter.siamese.dyndns.org>
References: <5021B20D.2030702@palm.com>
 <7v393yupjp.fsf@alter.siamese.dyndns.org>
 <CABURp0q6OXF5Mu3m20z5ZwL4kz0A0HgZynVMLZZBMNXtga01Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvdW-0005b8-LC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab2HJUQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:16:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645Ab2HJUQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:16:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2996796DB;
	Fri, 10 Aug 2012 16:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/FyMFo9ezGeVsQcsaUGwajHdoFM=; b=Mt4aSQ
	eo4m4QyCJVZaHCNkuiexsvQba0qGBMOQTBIDRCogN4WOwL9wcna3GZewYrit0q6F
	EUfq2uNbR8UP5D8AW9qdt51FUQfVgh7Iv7r8g9bwW4Dgz5s4izSGG04QdAgmhCVF
	Art0gb9P5Ol09CF9bAQhDCcrBQqRrpbVk0byw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ym9JL7N1NJwHlJ4ZjLZqNNOoQR2qHyT5
	g9xm/TL+72npx775hs2x3D7aoL2Obf8mjJfGP48UKK286BpZInOMz1P4K9YFqG12
	Zxy4ohD3fX/Nm62F5NJOL4E0cA6QZYPlFvJ26Nh2o29C84mDoq0uA6MJNL64elr3
	ZQLjHVIQhQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16F7D96D9;
	Fri, 10 Aug 2012 16:16:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8207F96D8; Fri, 10 Aug 2012
 16:16:39 -0400 (EDT)
In-Reply-To: <CABURp0q6OXF5Mu3m20z5ZwL4kz0A0HgZynVMLZZBMNXtga01Vg@mail.gmail.com> (Phil
 Hord's message of "Fri, 10 Aug 2012 15:37:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B10A0E2-E328-11E1-B53A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203257>

Phil Hord <phil.hord@gmail.com> writes:

> I agree that 'git reset --hard' should be mentioned in the hint for
> newbies, but this conflicts with my desire to avoid giving chainsaws
> to toddlers.

Exactly.  So what are you suggesting?

Perhaps force the user to go through a series of quiz when "git
merge" was run by the user for the first time to make sure she at
least read the sections on merges and conflict resolutions in the
documentation to understand the fundamentals, and refuse to proceed
until the user passes?

I personally do not see a good way out.  Even telling new users not
to do merges, rebases, or resets but to only build a straight linear
history is not a fix, as the user will never gain the necessary
understanding by doing only limited and simple things.
