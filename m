From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Tue, 01 Apr 2014 15:03:38 -0700
Message-ID: <xmqqppl0yaf9.fsf@gitster.dls.corp.google.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 00:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV6mZ-0003pw-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 02 Apr 2014 00:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaDAWDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbaDAWDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B77078C5C;
	Tue,  1 Apr 2014 18:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1X+Ljn3dwkPGxI5HeaJJdxIuZPQ=; b=S0AcfR
	B4rNOyIIZLR4T2lPVHrMeo+JGrRLVvoa6Y+Fb7JKfOl90Ilz6ki+NDWdB89/2HDt
	zwePaWlhYMqmiT9d6+3EoseBWzEg49cAEEPsx6612Nr429i3npE5QPCo3vZboFv6
	bAKCwZZQJecXuCtbEkOVUFelFw6u8J5VSDG8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u5XI5+UTh8BkUtkTLLXiXUHx0cxChnXq
	DSzSNZtLBKbtKXjfErUyROHBsbkV7stEj4XaNd8y6pCHNrPnc6muvPD5LGwifcNh
	ddeTMdf/DRin8L0Jcstamh+AiMjvIu+LcG6QqvSEL01HHNvZRKAnkwn7QckoshCQ
	kSVcYfj4SC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84A6578C5A;
	Tue,  1 Apr 2014 18:03:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B904F78C58;
	Tue,  1 Apr 2014 18:03:40 -0400 (EDT)
In-Reply-To: <xmqqppl128q8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 31 Mar 2014 17:29:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7BDA2556-B9E9-11E3-B450-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245663>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't reverted the merge of that "submodule update" topic yet; I
> should do that soonish.
> ...

Sigh...  This is giving me a lot of headache.

As 23d25e48 (submodule: explicit local branch creation in
module_clone, 2014-01-26) has been in 'master' since fairly early
during this cycle, a lot of topics that are not planned to be on the
'maint' branch has forked from the tip of 'master' and are now
contaminated by that commit.

I think I have a preparatory patch to correctly revert 00d4ff1a
(Merge branch 'wt/doc-submodule-name-path-confusion-2', 2014-03-31)
and 06c27689 (Merge branch 'wk/submodule-on-branch', 2014-02-27),
and also a part of 384364b (Start preparing for Git 2.0,
2014-03-07), but I am not sure what to do with them ;-<))

Anyhow...
