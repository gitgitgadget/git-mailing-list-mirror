From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 07:54:55 -0700
Message-ID: <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 16:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ3My-000209-69
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 16:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab0GNOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 10:55:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab0GNOz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 10:55:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D199C4326;
	Wed, 14 Jul 2010 10:55:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rmqswLbtW2MaQCdO2bQ3QiSLH5c=; b=mfPN7U
	w2jXqkrNnbDcGnocW6hrIygL0JwmXtzuo57fkm2nG7NxzboXTthp5d0y7+A0CG5Q
	TN1XUyp7Ahpi2z976ESbBZb5C/nlXwvZbASTiw/WryDk9vbip2E6irtoV55QobTo
	0/vAOg1w5fc3hxIabAFzjsRTAsajLQp1lALTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tWZB58HEDwRHuJ/PiqalMlS8tkUwAP1I
	+NP4LgtNPJrrrxnvknx/aPnidF1//Mh23jPDJVNt+Nl7Ow5/zRWamwS4xPkAHWEm
	yL4BkHuB2gcuhHK8+2C0hf7h+COgF7YcASImCfZVDtsxFsquid871f0t72ztFTA0
	RbWtW0JkI70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BADEC4322;
	Wed, 14 Jul 2010 10:55:10 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2729C431E; Wed, 14 Jul
 2010 10:54:57 -0400 (EDT)
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed\, 14 Jul 2010 01\:36\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCB17A30-8F57-11DF-ABC8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150992>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> For the convinience of fellow Git developers, here's a series to get
> svnrdump merged into git.git.

Given you'll be maintaining a variant that can link with 1.6 subversion
libraries anyway, I'd rather see you host this as an independent, related
project, perhaps at repo.or.cz and/or github.com, and add a link to point
at it at https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

Thanks.
