From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 14:48:02 -0700
Message-ID: <7v62kx4axu.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fav-00072Q-4D
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1ILXHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334Ab1ILXHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 644C64A79;
	Mon, 12 Sep 2011 19:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=7rl2JgCqtW0PGx/P33almA8B470=; b=bTtr+3yD7esjGr2rIcv1
	uMKi4v8fYfDF9wN+ThmlKz633XkDNjrodn+AWEsP/K6AQk8S0gbTeFk4C1wXmhZz
	AoEUDxEtpLTBJyu5SJcIwutpzbCPaWMCg17vpc72YIlLdG5Xwlfp6O/1Yi1WQ0OX
	BN+mDotdUiCNhek8pRBLBfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YgvwpmsmMSudyP67dCiYraij1pJ3gse5jG65qCkhIRExl5
	e862sSfSjhgA6Zq+2yeHMUUpS5tg0GtOT5IMT6ymlfQwoDb66cdcAZfYBAPyepOi
	aj8ZlJphrfsYIOPCxWWnPD68oVEWkWQG4LsQzuA70FL4txIEB1RWQCV/5hUNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB094A78;
	Mon, 12 Sep 2011 19:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9F314A77; Mon, 12 Sep 2011
 19:07:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1E9F878-DD93-11E0-9575-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181245>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * nd/maint-autofix-tag-in-head (2011-08-26) 3 commits
>  - Accept tags in HEAD or MERGE_HEAD
>  - merge: remove global variable head[]
>  - merge: keep stash[] a local variable

Could you start thinking about re-rolling this for post 1.7.7 release?

Thanks.
