From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Mon, 23 Feb 2009 17:36:04 -0800
Message-ID: <7vvdr0obuj.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 <m3ocwwrxtg.fsf@localhost.localdomain>
 <7v3ae8rvvd.fsf@gitster.siamese.dyndns.org>
 <200902211118.32185.jnareb@gmail.com>
 <43d8ce650902230441n51c9e5a8h722682cda778aa7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmEy-00025u-8e
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZBXBgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZBXBgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:36:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbZBXBgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:36:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 12A609CE5F;
	Mon, 23 Feb 2009 20:36:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E18789CE5E; Mon,
 23 Feb 2009 20:36:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85D31182-0213-11DE-9760-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111194>

John Tapsell <johnflux@gmail.com> writes:

> It sounds like we have some sort of plan then.  Will Nana's patch be
> committed into mainline git?  Then we can add the --abort porcelain

I do not know what plan you are talking about, but that's not how the
development works.  If something is merged to 'pu', and you have a cool
feature you would want to take advantage of it, you can build your cool
feature on top of that particular topic.  If the result looks reasonable
they would cook for a while in 'next' for further polishing and then
finally go to 'mainline'.

I personally did not think "--keep" would need to be be part of a
reasonable "merge --abort" implementation, but I may have missed some
description of a viable design discussed on the list.
