From: Junio C Hamano <gitster@pobox.com>
Subject: In preparation for 1.7.10-rc0
Date: Tue, 06 Mar 2012 22:28:48 -0800
Message-ID: <7vd38oq5zz.fsf@alter.siamese.dyndns.org>
References: <7vmx7uurnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Wong <normalperson@yhbt.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 07:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5AMt-0002iR-NC
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 07:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2CGG2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 01:28:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab2CGG2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 01:28:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC1A358C;
	Wed,  7 Mar 2012 01:28:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BejcCdLEibRG2j8tRDxN9+Oqo8Y=; b=h9ETeM
	GEKqWxeX6eAopTVSESt5kuKfWUa6THeGHfom8FDnj+D8Ag60+709hG35PsusuLtX
	CxbPssyoain2mH6sMEE0a1VCWuNR/CroYVXl3YSFIbo408bDAWp+ZprNwxntgQDv
	vcldsyTi8ANSwxjZYGOwTIaxtjJJFHuUCZB4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h8doBC0QQC+XG9iJDHU/Wqgkx0UFpcWI
	WOISLxf3XBGVkssCv9KucFDT9KSyUEDIOJ8J6X/P8TRLp7485CtuIadwwVunCSY7
	MR5ZqyQBOEP3mjhVE4OsthM+3rpKbu7zJMVbEWld0R2WR7II7rXjc5S+a2Vrc78t
	UNnnpUrM/jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46ACE358B;
	Wed,  7 Mar 2012 01:28:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDDE0358A; Wed,  7 Mar 2012
 01:28:49 -0500 (EST)
In-Reply-To: <7vmx7uurnj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 05 Mar 2012 23:15:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD2F40E0-681E-11E1-87BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192428>

There are a couple loose ends I would like to tie before we go deep
into the pre-release freeze for the upcoming 1.7.10.

* Subsystems

I recall that I received many months worth of accumulated gitk
updates during the last round from Paul.

Are there updates for this cycle coming soon?  The same question for
git-gui (Pat) and git-svn (Eric)?

* L10N

Immediately after 1.7.10-rc0 gets tagged may be a good time for the
l10n coordinator to pull from me, run "make pot" to update the
po/git.pot file and propagate the result to the language teams (oh,
we would also need to recruit language teams other than Chinese ;-),
so that the translations can be updated (or added).

Thanks.
