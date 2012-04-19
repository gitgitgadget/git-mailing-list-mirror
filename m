From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding a new option to git-push: --(no-)create-branch
Date: Wed, 18 Apr 2012 17:46:53 -0700
Message-ID: <7vk41cim4i.fsf@alter.siamese.dyndns.org>
References: <4F8F3A25.1080407@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Thu Apr 19 02:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKfWX-0000Hb-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 02:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab2DSAq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 20:46:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2DSAq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 20:46:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC76E6120;
	Wed, 18 Apr 2012 20:46:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wsU960N1NtuD935lpe3COjBVngk=; b=e1Lehp
	737E8ER1sojkSMLQYXyfTSyyaR7Ou1qgvwNthtLe5RaMM+ovQOSX1jo4n4Z5NNV3
	xBFjoxfGNFSxdaIqdZ3vtwOHMmOuLlBREMOwvZ+xG5fczNP16yur+rjg9IRWlMbh
	SP5p8scPPMdgjAft7ZploTctoArlh7f+tUIHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFYdCYkPfVD2FyRJXcQzU4e0BsVrbpOd
	g/EInpQtsoko6TsfVHvmpWu3NZbUH1qO7h3JoADTY3yZiw1qebAEyfswL4UtZ7YI
	r57wMEqq3v5HRPrY/O1TpMGZiaiUdxZSXqwQJg29Ls5YTTOy5WItMqUArwBXPrM2
	Mue1fCawN4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4362611F;
	Wed, 18 Apr 2012 20:46:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2187C611D; Wed, 18 Apr 2012
 20:46:55 -0400 (EDT)
In-Reply-To: <4F8F3A25.1080407@hoelz.ro> (Rob Hoelz's message of "Thu, 19 Apr
 2012 00:03:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 293A716E-89B9-11E1-98CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195919>

Rob Hoelz <rob@hoelz.ro> writes:

> However, I will often make a typo like this:
>
> git push origin master:msater

Why isn't "git push origin master" explicit enough?
