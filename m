From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Tue, 28 May 2013 14:25:45 -0700
Message-ID: <7vppwayexy.fsf@alter.siamese.dyndns.org>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
	<CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
	<7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
	<CACsJy8Ct-ei7qbAW4qviQ6=q93ygxDcxRs9F3iHHV4-4Qz6qUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 23:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhRSm-0008NF-DG
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 23:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933596Ab3E1VZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 17:25:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933523Ab3E1VZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 17:25:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAAA323CE8;
	Tue, 28 May 2013 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kTpY5FxKCE7ajsPpqMuJMh4KF2U=; b=OFBtyz
	kr3YbzzNuZguZSL/lb0R/loBEfRlVFdeZ8hOdsrlRKAZl5mdP6QTYwlj6ptvAbFr
	RZgnw8IdA+xs/Vzn2a0Dcpb8tkuBViZZj0ouxVQlPiBvJQ769c28YDnbtYPMCgQk
	vV62TkOPK0+s8T2baFrP1RSphEreSDdd5E0Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N9MFNkjt4OPTZKpbRtI726SX/9J1R+op
	R+vJL9Apcp7zWpbz5X7tJt4vmhOSCM6zHXq4FnJvq9I1RHMVPOJSTBvCDuiSKiuB
	JGjIXpBTmwoLmb2bmhyPsX+WUgi/Qi7CXWuBo9dIB6h2CRWVUQ731Kdp6/BVlk3z
	rPhJjl8ykdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FFF23CE7;
	Tue, 28 May 2013 21:25:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210D023CE3;
	Tue, 28 May 2013 21:25:47 +0000 (UTC)
In-Reply-To: <CACsJy8Ct-ei7qbAW4qviQ6=q93ygxDcxRs9F3iHHV4-4Qz6qUA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 27 May 2013 17:36:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29702E22-C7DD-11E2-839E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225687>

Duy Nguyen <pclouds@gmail.com> writes:

> Point taken. I guess the message would be something like this?
>
> Refname '%.*s' is ignored. It may be created by mistake.
>
> Or should we be more elaborate?

I dunno; with s/may be/may have been/, I think it is better than
"refname is ambiguous".
