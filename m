From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Wed, 20 Aug 2008 14:15:58 -0700
Message-ID: <7vbpznpeup.fsf@gitster.siamese.dyndns.org>
References: <1219263969579-736663.post@n2.nabble.com>
 <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
 <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Andreas_F=C3=A4rber?= <andreas.faerber@web.de>,
	ir0s <imirene@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv3V-0007fk-8S
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbYHTVQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbYHTVQM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:16:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbYHTVQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 17:16:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EA68161898;
	Wed, 20 Aug 2008 17:16:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07D6761891; Wed, 20 Aug 2008 17:16:00 -0400 (EDT)
In-Reply-To: <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 20 Aug 2008 17:01:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35CEA8B2-6EFD-11DD-BE1A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93048>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On Wed, Aug 20, 2008 at 4:40 PM, Andreas F=C3=A4rber <andreas.faerber=
@web.de> wrote:
>> You need to name the local branch, not the remote one:
>>
>> $ git push origin mybranch
>>
>> It should then push to remotebranch.
>
> Not only that, but the "ahead of tracked branch" message depends on
> your local copy of the remote branch, not the remote copy of the
> remote branch.

I think we have long been doing so.  Daniel, correct me.
