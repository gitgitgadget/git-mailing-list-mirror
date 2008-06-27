From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 14:28:29 -0700
Message-ID: <7vd4m2r2iq.fsf@gitster.siamese.dyndns.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
 <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org>
 <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
 <20080627161220.GB6201@leksak.fem-net>
 <20080627163411.GA2058@genesis.frugalware.org>
 <20080627171948.GC6201@leksak.fem-net>
 <20080627192819.GC2058@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:29:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLVm-0006Ju-Fj
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326AbYF0V2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758291AbYF0V2q
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:28:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184AbYF0V2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 17:28:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A8428CB75;
	Fri, 27 Jun 2008 17:28:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A66A6CB72; Fri, 27 Jun 2008 17:28:31 -0400 (EDT)
In-Reply-To: <20080627192819.GC2058@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 27 Jun 2008 21:28:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02F74224-4490-11DD-A41E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86635>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Jun 27, 2008 at 07:19:48PM +0200, Stephan Beyer <s-beyer@gmx.net> wrote:
>> -m <msg>::
>> 	The commit message to be used for the merge commit (in case
>> 	it is created). The `git-fmt-merge-msg` script can be used
>> 	to give a good default for automated `git-merge` invocations.
>> 
>> So it is not mentioned that a standard message is appended, and thus the
>> original behavior is somehow "buggy" :)
>
> Ah, OK. Then the code and the documentation differs and that's a bug,
> sure.
>
> From git-merge.sh:
>
> # All the rest are the commits being merged; prepare
> # the standard merge summary message to be appended to
> # the given message.
>
> I did builtin-merge based on git-merge.sh, not the manpage. ;-)

Following git tradition, manpage came after the command's behaviour has
been long established.  It will be a behaviour change, and it is open to
debate if the new behaviour is better or if the proposed change of
behaviour hurts existing users.
