From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 17:33:36 -0700
Message-ID: <7vbq2i11jz.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806030738340.3473@woody.linux-foundation.org>
 <20080603231151.GR29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3gxg-00068I-Fw
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbYFDAdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 20:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYFDAdv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:33:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYFDAdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:33:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 04B922DF4;
	Tue,  3 Jun 2008 20:33:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62E392DF2; Tue,  3 Jun 2008 20:33:45 -0400 (EDT)
In-Reply-To: <20080603231151.GR29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 4 Jun 2008 01:11:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6229394-31CD-11DD-9DAA-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83735>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jun 03, 2008 at 07:40:21AM -0700, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> Right. But git shouldn't do duplicate parents. I agree it's a mis-use of 
>> git merge, but either we should have errored out or we should have pruned 
>> the parents.
>> 
>> Yes, the end result is "tecnically correct", but it's not optimal.
>
> I think the current git-merge.sh already handles this: 6ea23343
> introduced the usage of git-show-branch --independent to filter out
> duplicated parents.

Good eyes.  I guess I was sloppy when I wrote the log message for that
one and failed to talk about the bugfix ;-).
