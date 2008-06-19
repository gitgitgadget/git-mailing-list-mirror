From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 12:14:23 -0700
Message-ID: <7vr6attey8.fsf@gitster.siamese.dyndns.org>
References: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.DEB.1.00.0806191459150.6439@racer>
 <20080619154350.GA21625@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Pbu-0003lD-HP
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbYFSTOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYFSTOq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:14:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbYFSTOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 15:14:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 441531BAFA;
	Thu, 19 Jun 2008 15:14:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5754D1BAF8; Thu, 19 Jun 2008 15:14:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F69B6D46-3E33-11DD-8B9B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85515>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2008.06.19 15:00:19 +0100, Johannes Schindelin wrote:
>> Hi,
>>=20
>> On Thu, 19 Jun 2008, Pieter de Bie wrote:
>>=20
>> > This functionality was actually introduced in
>> >  0a02186f924aee1bd69f18ed01f645aa332ce0d1, but can only be activat=
ed by the
>> > configuration flag. Now we can also setup auto rebasing using the =
--rebase
>> > flag in git-branch or git-checkout, similar to how --track works.
>>=20
>> How about "--rebasing"?  I would scratch my head a bit how a new bra=
nch=20
>> and a rebase would go together.
>
> Hm, --rebasing sounds weird to me as well. Maybe --track=3Dmerge and
> --track=3Drebase, with --track being equal to --track=3Dmerge?

That looks like the best wording so far, although I suspect that the tr=
ue
reason why all of the above sounds confusing may be because the concept
itself is not clear.
