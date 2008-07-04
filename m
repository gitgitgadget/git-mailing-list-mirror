From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git sequencer prototype
Date: Fri, 04 Jul 2008 15:09:41 -0700
Message-ID: <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <20080704210052.GA6984@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 00:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEtUk-0007DD-NE
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 00:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbYGDWJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 18:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbYGDWJz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 18:09:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862AbYGDWJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 18:09:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CB7E18B77;
	Fri,  4 Jul 2008 18:09:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CE19D18B6E; Fri,  4 Jul 2008 18:09:43 -0400 (EDT)
In-Reply-To: <20080704210052.GA6984@steel.home> (Alex Riesen's message of
 "Fri, 4 Jul 2008 23:00:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC9F8D48-4A15-11DD-9528-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87421>

Alex Riesen <raa.lkml@gmail.com> writes:

> Stephan Beyer, Tue, Jul 01, 2008 04:38:30 +0200:
>> Hi,
>> 
>> here is the patchset for the git-sequencer prototype, documentation,
>> test suite and a first git-am and git-rebase-i migration.
>> Indeed, monster patches. ;)
>
> BTW, how about renaming it in something short: git seq. There is
> already a seq(1) in GNU coreutils, which does roughly the same (prints
> a sequence of numbers), why not reuse the name?

Is it advantageous to use shorter but less descriptive name for this
command?  It will be a backend to am/rebase and not something the users
will type from the command line, won't it?
