From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Sat, 21 Feb 2009 01:18:30 -0800
Message-ID: <7v3ae8rvvd.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
 <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
 <3e8340490902202328r7caca98q973c17dc163e2028@mail.gmail.com>
 <m3ocwwrxtg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 10:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lao1r-00050C-3b
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 10:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbZBUJSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 04:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbZBUJSn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 04:18:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbZBUJSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 04:18:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1584A9B2BD;
	Sat, 21 Feb 2009 04:18:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2CC6B9B2BA; Sat,
 21 Feb 2009 04:18:32 -0500 (EST)
In-Reply-To: <m3ocwwrxtg.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 21 Feb 2009 00:34:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A07B54F8-FFF8-11DD-A564-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110933>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps this is the case fo "feature that waits for a user", namely
> 'git stash --no-reset', which would save a state just in case, perhaps
> in a separate area and not refs/stash (ORIG_STASH perhaps?).

Isn't that Nana's "git stash --keep" patch posted a few weeks ago sitting
in "pu"?
