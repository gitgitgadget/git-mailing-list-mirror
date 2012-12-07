From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 13:08:55 -0800
Message-ID: <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
 <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
 <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:09:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th5AZ-0001Ux-AT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 22:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424553Ab2LGVI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 16:08:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424546Ab2LGVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 16:08:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B075CA2D2;
	Fri,  7 Dec 2012 16:08:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/V2DYoOfMsjrJJJQBPiP4yPe4zQ=; b=RkEJ+g
	klNKNqj6LhklFO4rnE7WItxpxBHA8DR/G/ycAENK6WJnEm/eArdNR1Fw0Ylt4kFh
	eZcPUrkK3RjKvcY++CaP1KjvLPdJsD8Rti+x10Q5U86XYsTWKgUcGaIh+p/ekTls
	xZ9mDkE6mwVyVx/1v/yWHeX6KqMQI3H2N7CSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZvnKlLHTyMNz63XVL30GbhcW/w1ZMFQ6
	kveKsTdnm0UymnMhs9EfPAVyJs5uO37t98Wiu08UJdpyO+tKMrJMhOk1I6g8zJpq
	CDNEUONHulSgOxfne9c0x+5bnoQd8MV8UiseW8woE1oEvGda23ayeo8alwXAXSq9
	PAsaCFGxTsI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB08A2D1;
	Fri,  7 Dec 2012 16:08:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14824A2D0; Fri,  7 Dec 2012
 16:08:56 -0500 (EST)
In-Reply-To: <50C25539.9010206@xiplink.com> (Marc Branchaud's message of
 "Fri, 07 Dec 2012 15:44:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50592F96-40B2-11E2-8D5C-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211194>

Marc Branchaud <marcnarc@xiplink.com> writes:

> It's FreeBSD 7.2, which I know is an obsolete version but I'm not able to
> upgrade the machine.  I believe FreeBSD's sh is, or is derived from, dash.

Finally.  Yes, as you suspected, I am perfectly fine to explicitly
set IFS to the default values.

I wanted to have specific names to write in the commit log message,
in-code comments and possibly release notes.  That way, people can
decide if the issue affects them and they should upgrade once the
fix is made.
