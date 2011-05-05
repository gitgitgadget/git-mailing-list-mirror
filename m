From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/annotate-tests: Use echo & cat instead of sed
Date: Wed, 04 May 2011 22:39:55 -0700
Message-ID: <7vk4e5bt90.fsf@alter.siamese.dyndns.org>
References: <1304570617-17603-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Arjen Laarhoven <arjen@yaph.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu May 05 07:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHrIO-0003f2-4u
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 07:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab1EEFkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 01:40:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1EEFkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 01:40:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78F3F3656;
	Thu,  5 May 2011 01:42:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iN98m9hZcRiixtfOqdzUO72jbU4=; b=oyweGJ
	e4ymYa2oSpgbMpLNSdAA2nUko6w4zIip9ZjINAiFty6MgA/tBvXXkd0H6cvrcWVt
	WV5oMizsEntMeM7oPOmTIgJG1Jg0XS7BDbhKOe4YqFJ/nsIuE4GOWlqYlgcUAa68
	hp5CqVJPGdmL6Qp6fdUVAFLlLOz3lsg5v8GQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+kgnbFiziogPIpP1CaVstMqC9uBOcRc
	8bNU+smszc6TGtmS/S9jsKs5ExJo7+FnJ2yov3PivyNw2iAKv+nMJnqVDgGu5ccU
	FABfA8K+XVYXtad2UKO70Vj558FEQHePi/3iHaro8C5o2U6eSUa6ythfhxZHCsvz
	zM3jDnk4lII=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 489A9363A;
	Thu,  5 May 2011 01:42:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CD193639; Thu,  5 May 2011
 01:42:00 -0400 (EDT)
In-Reply-To: <1304570617-17603-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu, 5 May 2011 00:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68ABABDA-76DA-11E0-A8A8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172797>

An earlier patch from Arjen Laarhoven

  From: Arjen Laarhoven <arjen@yaph.org>
  Subject: [PATCH] annotate.sh: Fix failing test on OS X
  Date: Wed,  4 May 2011 15:36:21 +0200
  Message-ID: <1304516181-92364-1-git-send-email-arjen@yaph.org>

seems to attempt to address the same issue but with a twist to deal with
an incomplete line at the end of file.

Arjen, does Brian's patch look good to you, too?  It is much less tricky
and should look obviously correct even to people who sees the code in
question for the first time.

Thanks, both.
