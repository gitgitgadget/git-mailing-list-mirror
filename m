From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 09:45:03 -0700
Message-ID: <7vipnd3trk.fsf@alter.siamese.dyndns.org>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIk8B-00020z-6j
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1JYQpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 12:45:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab1JYQpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 12:45:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE0F54C0;
	Tue, 25 Oct 2011 12:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFx32PxAiFdGbXj8Ud/qXdNxDAY=; b=nmh2JX
	+2Xk0hrZbJtn77dECHyJ2HZzQOOuGZ8ijsdTicSQP12UXC8ICdY+B5X5451peIIA
	2m+bRU+d6VDW59NXlagIqtmVWLCPmHomBU8SlzbLx02PfeIQG/iF5uvPDV43TLie
	abKVNB8pxpjMH0132QpeKhhVdwOg+ENXsCJ/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kavhbOIlJHSIs+6lhvyhfRa6xhx3Yag0
	OgD5H3biLWNU4cmlnWV+uTbEHZD5db6JWjT1sSXIza/GSPYtumBJHGEZWkgdImms
	Zylx44Yhepzqkuuk9wNK1I0QbJAlFngvPGlskm9/10ckmU1DelwkSj6WKx48mP1E
	14WDeEF6Gds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F1254BF;
	Tue, 25 Oct 2011 12:45:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0051F54BC; Tue, 25 Oct 2011
 12:45:04 -0400 (EDT)
In-Reply-To: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com> (Eugene
 Sajine's message of "Tue, 25 Oct 2011 11:58:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0C1A754-FF28-11E0-9B69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184220>

Eugene Sajine <euguess@gmail.com> writes:

> We have built git 1.7.6.4 and we have a following problem with it:
> .,,
> It doesn't seem to be the case with 1.7.4.1
>
> Was there any change between those versions that i missed, or may be
> there is some property we have to specify during build?

Nothing I can think of offhand that you need to specify _differently_
between the build procedures of these two versions.

Just a wild guess. perhaps you specified prefix=/usr/local/git-1.7.4.1/
eons ago when you built and installed 1.7.4.1 like this:

    make prefix=/usr/local/git-1.7.4.1 all install

and then you did it differently when you installed 1.7.6.4, e.g.

    make all
    make prefix=/usr/local/git-1.7.6.4 install
