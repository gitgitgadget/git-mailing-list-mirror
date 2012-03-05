From: dag@cray.com (David A. Greene)
Subject: Re: [PATCH 1/2] Allow Overriding GIT_BUILD_DIR
Date: Mon, 05 Mar 2012 12:10:41 -0600
Message-ID: <nng399m3om6.fsf@transit.us.cray.com>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<7vaa3v4kwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: greened@obbligato.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 19:11:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4cNY-0006Uj-W3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 19:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab2CESLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 13:11:13 -0500
Received: from exprod6og108.obsmtp.com ([64.18.1.21]:39114 "EHLO
	exprod6og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199Ab2CESLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 13:11:10 -0500
Received: from stplmr01.us.cray.com ([136.162.34.13]) (using TLSv1) by exprod6ob108.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT1UBoptukY+s/5OIX/73XdyEohmDxFyV@postini.com; Mon, 05 Mar 2012 10:11:10 PST
Received: from transit.us.cray.com (transit.us.cray.com [172.31.17.53])
	by stplmr01.us.cray.com (8.14.3/8.13.8/hubv2-LastChangedRevision: 12441) with ESMTP id q25IAg3T017569;
	Mon, 5 Mar 2012 12:10:42 -0600
Received: from transit.us.cray.com (localhost [127.0.0.1])
	by transit.us.cray.com (8.14.3/8.13.6/client-5260) with ESMTP id q25IAfx2030537;
	Mon, 5 Mar 2012 12:10:41 -0600
Received: (from dag@localhost)
	by transit.us.cray.com (8.14.3/8.12.8/Submit) id q25IAfjk030536;
	Mon, 5 Mar 2012 12:10:41 -0600
In-Reply-To: <7vaa3v4kwo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 04 Mar 2012 22:33:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192260>

Junio C Hamano <gitster@pobox.com> writes:

> Both of your changes seem to have broken indentation to use 8-SP at
> the beginning of some (but not all) lines instead 1-HT.  I'll queue
> a fixed up version and push the result out in 'pu' later, so please
> double check to make sure I didn't screw up.

Right.  This is because you flagged an indentation issue with the
previous version of the patch.  I think what happened is that the
previous version included the 1-HT (what is HT - half-tab?) spacing but
it "looked funny" with the additional "+" from the diff line.

So in some way this was deliberate to make the patch look better.  I
have no problem with you (or me!) changing it back.

Thanks for taking these up!

                          -Dave
