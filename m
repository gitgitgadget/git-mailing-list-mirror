From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Wed, 24 Nov 2010 09:13:10 -0800
Message-ID: <7vpqtutzkp.fsf@alter.siamese.dyndns.org>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org>
 <m3mxp668cy.fsf@localhost.localdomain>
 <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
 <201011200142.26522.jnareb@gmail.com> <4CEC6E2A.9080605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 24 18:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLIuM-000855-9W
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 18:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0KXRNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 12:13:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0KXRNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 12:13:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 720D82ECD;
	Wed, 24 Nov 2010 12:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3vp6dHKFQMK9/yThOF7Jb7I4kd0=; b=fIgTMP
	Ebobrj2W3d+aM+5JrEL7wfvVjszoct81ZWETiRwGn1f1E2x7ns5dBXZGen/egyZd
	cgsASKZa2C1MCo0jvRKZkn2TpTVcsI1KvstCrkyv1Ur7jHaTGeyLHGB6WFUj9ex6
	1gtfrvFalVJyyr7vmHADfGjPpwGrQinA/oQ5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CavG/PEyfFMke6mecbKIhYNwCCbuLY6Y
	IG/XG6ecJo4fHvsfzmeB9hsLj0L+RUPmkEWg/k4ps7dek9oiNRJ8vUu1Qw5ynGoZ
	zoPUm6riJckHCf7YYZ5SDrfaKG+jMN3Kwx5BFwq86mwDyc0T8/wmuLWQZ8f5b/rG
	LzJONInLceM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41AD42ECC;
	Wed, 24 Nov 2010 12:13:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 393CE2ECB; Wed, 24 Nov 2010
 12:13:25 -0500 (EST)
In-Reply-To: <4CEC6E2A.9080605@kernel.org> (J. H.'s message of "Tue\, 23 Nov
 2010 17\:45\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28BF6702-F7EE-11DF-8734-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162068>

"J.H." <warthog9@kernel.org> writes:

> While I don't disagree, being able to support other caching systems
> would be nice, we have this now, it's tested and it works.  I'd argue
> this is a step 1, step 2 case at this point.

I would have to agree; getting some cache layer that is known to work (you
are battle testing your updates on a busy site of yours as you develop,
right?) early, quick and dirty with minimum changes, is more beneficial
than waiting for a large rewrite thats "gets it perfect this time".

> I'm currently working from on top of Jakub's last tree, though I've got
> some questions about his reasoning on a few things now that I've been
> digging into it.

Thanks both for keeping the ball rolling.
