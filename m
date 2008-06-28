From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 17:05:52 -0700
Message-ID: <7vd4m2mnj3.fsf@gitster.siamese.dyndns.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
 <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org>
 <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
 <20080627161220.GB6201@leksak.fem-net>
 <20080627163411.GA2058@genesis.frugalware.org>
 <20080627171948.GC6201@leksak.fem-net>
 <20080627192819.GC2058@genesis.frugalware.org>
 <7vd4m2r2iq.fsf@gitster.siamese.dyndns.org>
 <20080627213605.GD2058@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:07:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNyF-0004Xp-6j
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 02:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbYF1AGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 20:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYF1AGB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 20:06:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbYF1AGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 20:06:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D67E7ED41;
	Fri, 27 Jun 2008 20:05:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 38483ED40; Fri, 27 Jun 2008 20:05:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBF8AA56-44A5-11DD-B31D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86682>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Jun 27, 2008 at 02:28:29PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Following git tradition, manpage came after the command's behaviour has
>> been long established.  It will be a behaviour change, and it is open to
>> debate if the new behaviour is better or if the proposed change of
>> behaviour hurts existing users.
>
> If my opinion counts, I like the current ("prepend") one,...

Well, I do not think you are alone --- otherwise the original behaviour
would not be such ;-)

In any case, what is more important is that the proposed change is a
change in behaviour and the burden of proof that it does not hurt people's
existing scripts is on the party that wants to change it.
