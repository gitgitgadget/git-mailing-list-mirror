From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] CodingGuidelines:  make it clear which files in Documentation/ are the sources
Date: Thu, 09 May 2013 13:37:18 -0700
Message-ID: <7vobcj99fl.fsf@alter.siamese.dyndns.org>
References: <201305082024.r48KOH55003964@freeze.ariadne.com>
	<7vy5bpdx64.fsf@alter.siamese.dyndns.org>
	<201305092018.r49KIY5N024319@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Thu May 09 22:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaXaf-0003hb-NE
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 22:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab3EIUhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 16:37:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3EIUhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 16:37:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D141D286;
	Thu,  9 May 2013 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7F2RJoBgy+WLJniaPIVsoLJDwEg=; b=E/RPhz
	D8n2UYh40FNjyEJIdG7APnwfGb8bvD3TWk/AS5EJ9ZKjaPCOHQPboj6TvoQAOod0
	4cC6yibUTWKxzAu611iB6RqyGx8/3w0+drqldMVKbSirHkW7XyXz6Wi9C67bK2uA
	lQZplKJgFfDHx65TM106CShB5beniopfCA4Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAgFPa6f2TAAgfa1HIhHJWN57Ar1iYTY
	hslqHfVfiL8gPZLar6xHWi6f04J0YFEMSokmpIryBSuHsN+XWJNv1UT64vlUaZ6O
	lApNo0xivpmgIDUxFAtKFq3lONm6oKpRgkk/w+50X312RUAgW7yz+x52g2JTtPBB
	JtKtZa8G9sY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD701D285;
	Thu,  9 May 2013 20:37:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ECDA1D284;
	Thu,  9 May 2013 20:37:20 +0000 (UTC)
In-Reply-To: <201305092018.r49KIY5N024319@freeze.ariadne.com> (Dale
	R. Worley's message of "Thu, 9 May 2013 16:18:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EF44912-B8E8-11E2-B25E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223779>

worley@alum.mit.edu (Dale R. Worley) writes:

> body, the "From e87227..." line will have no place to go.  And perhaps
> it is an important part of the patch, since "git format-patch" outputs
> it?

As you noticed (correctly), the output of "format-patch" is meant to
be usable by "am" that reads from the UNIX mbox format.  "From whom"
(not "From: whom") lines are traditional message boundaries, and
when you are sending your own patch, none of the RFC822 headers (nor
the "From whom" line) needs to be repeated in the message body.

Thanks.
