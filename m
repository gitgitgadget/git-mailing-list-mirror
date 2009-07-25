From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch from date never set
Date: Sat, 25 Jul 2009 16:03:40 -0700
Message-ID: <7v7hxwtlf7.fsf@alter.siamese.dyndns.org>
References: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
 <81b0412b0907251531u7566813fr10bdd70187e9aca6@mail.gmail.com>
 <325c62f60907251549o27ebc8f2gcd1d728adb662ffd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Dan Savilonis <djs@n-cube.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqHV-0005qX-6E
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZGYXDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbZGYXDs
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:03:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZGYXDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:03:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 580B413BDD;
	Sat, 25 Jul 2009 19:03:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA67513BDC; Sat,
 25 Jul 2009 19:03:41 -0400 (EDT)
In-Reply-To: <325c62f60907251549o27ebc8f2gcd1d728adb662ffd@mail.gmail.com>
 (Dan Savilonis's message of "Sat\, 25 Jul 2009 18\:49\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68C0ACF2-796F-11DE-9176-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124092>

Dan Savilonis <djs@n-cube.org> writes:

> On Sat, Jul 25, 2009 at 6:31 PM, Alex Riesen<raa.lkml@gmail.com> wrote:
>> Neither. This is not a date, but a part of "loosely defined" mbox format.
>>
>
> In the examples of mbox format I have found, the date in the From:
> line is generally the same as in the Date: line, albeit in a more
> ambiguous format. Further, the the git code treats it as a date and
> attempts to set it. It remains at the default date only because
> git_committer_info() is called without GIT_COMMITTER_DATE set.
>
> So is the code misleading? Was it designed to just meet the minimal
> requirement of having a date-like string to comform to the mbox
> format? What's the disadvantage to using the real commit date?

Having it as a fixed date-looking string was to help /etc/magic entry
people may want to invent to detect format-patch output.
