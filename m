From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 28 Nov 2007 17:26:14 -0800
Message-ID: <7vbq9dzvt5.fsf@gitster.siamese.dyndns.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
	<Pine.LNX.4.64.0711271109130.27959@racer.site>
	<alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
	<20071127150829.GB3853@fieldses.org>
	<alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
	<20071127153411.GA11731@fieldses.org>
	<alpine.LFD.0.99999.0711271047590.9605@xanadu.home>
	<20071127164243.GE11731@fieldses.org>
	<alpine.LFD.0.99999.0711271155250.9605@xanadu.home>
	<7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
	<20071129010606.GA5856@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:26:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxYAz-0006ni-9X
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbXK2B00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbXK2B00
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:26:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41940 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbXK2B0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:26:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2EF432F0;
	Wed, 28 Nov 2007 20:26:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CC709AE21;
	Wed, 28 Nov 2007 20:26:38 -0500 (EST)
In-Reply-To: <20071129010606.GA5856@fieldses.org> (J. Bruce Fields's message
	of "Wed, 28 Nov 2007 20:06:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66489>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Yeah.  I considered doing the above some time ago and ran into some
> differences between git-clone and "git init && git remote add && git
> fetch"--I think it may have just been that the latter didn't guess the
> HEAD in the same way.  That's fixed now, right?

"git remote add" by itself does not talk with remote, so unless you let
it do the initial fetch it is not fixable (and no, "git remote add -f"
currently does not do the guesswork either).
