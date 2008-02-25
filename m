From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3] gitweb: Better cutting matched string and its
 context
Date: Mon, 25 Feb 2008 12:18:54 -0800
Message-ID: <7vskzghjrl.fsf@gitster.siamese.dyndns.org>
References: <200802222014.13205.jnareb@gmail.com>
 <20080224125920.24448.2179.stgit@localhost.localdomain>
 <7v8x19st7x.fsf@gitster.siamese.dyndns.org>
 <200802252107.59366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjnf-0006a8-9u
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbYBYUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbYBYUTL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:19:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbYBYUTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:19:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE3F7238A;
	Mon, 25 Feb 2008 15:19:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C2B012385; Mon, 25 Feb 2008 15:18:56 -0500 (EST)
In-Reply-To: <200802252107.59366.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 25 Feb 2008 21:07:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75062>

Jakub Narebski <jnareb@gmail.com> writes:

> Ooops. Sorry about that. I have forgot to transport context when
> doing copy'n'paste.
> ...
> BTW. the example was subtly wrong: you can search _lines_, like grep,
> you cannot search multiline.

Yeah, the original had:

        For example, if you are looking for "very long ... and how"
        in the first paragraph of message (if it were all on a single
        line), wouldn't you want to see:

and you dropped "if it were all on a single line" part, as you
forgot to transport context when doing copy-n-paste ;-)

> Below there is corrected commit message (rewritten to match code).

Thanks.  Will take a look later; I am at day-job today.
