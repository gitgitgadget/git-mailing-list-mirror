From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 10:51:58 -0700
Message-ID: <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:52:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBZP-0004sq-FE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796Ab3CYRwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:52:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758191Ab3CYRwB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:52:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA105AE08;
	Mon, 25 Mar 2013 13:52:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ExmTHKIdxsbQygQ3EF35Dg+AXCE=; b=A0kBtS
	/CjcRWhghm8hx9oPGynWLSi40uTGLcVb/GnUllWuCBuJ1jtunRyABDdAPD15wtbE
	3PpfvGOxwWRl57V7H+PRu4acF7JVPnc5dhCSMqF6cB5qFSP2UaOd1RUp9zxmfe7n
	EGAB8nLO7/FbqduT2o4ni9mjyBa/DgXZCOo1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=siTuVIhPEeh90Hg2KdkrVcmbEH2WOEpX
	/QofM3tker6Dhk4SBqtqalWMOc1OYOSW41GFV5T+EYVE8MWMyjZ5ZIBAtPrYJect
	E1al7vzbQ+KdBvvoaWujIYr/6zEqKnsB9eHpLSJ5ScGnfork+s9Vy6LLbc3y+QIg
	rVpnS+SqTGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA51AE07;
	Mon, 25 Mar 2013 13:52:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1940FAE05; Mon, 25 Mar 2013
 13:52:00 -0400 (EDT)
In-Reply-To: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 24 Mar 2013 23:08:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B17E2260-9574-11E2-998A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219050>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Git 2.0 is coming soon, so I'm excited about breaking a lot of
> backward compatibility ;)

Don't.

I lack the sense of humor normal people seem to have, so even with
the smiley, anybody making such a comment will be thrown into my "do
not pay attention to them" box ;-).
