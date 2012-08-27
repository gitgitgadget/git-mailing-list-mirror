From: <dag@cray.com>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 16:21:55 -0500
Message-ID: <nng4nnohvyk.fsf@transit.us.cray.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
	<nngsjb8i30w.fsf@transit.us.cray.com>
	<7v6284qfw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:22:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T66l8-00044w-8F
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 23:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab2H0VWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 17:22:02 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:33531 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2H0VWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 17:22:01 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUDvk9HhHYG5slFHGbzZ8sSdbmti3gAek@postini.com; Mon, 27 Aug 2012 14:22:01 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 27 Aug
 2012 16:21:56 -0500
In-Reply-To: <7v6284qfw8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2012 12:44:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204371>

Junio C Hamano <gitster@pobox.com> writes:

>> Well that's a chicken-and-egg problem, isn't it.  How will a library
>> become widespread unless something uses it?
>
> That something will not be the git core itself.  Otherwise we will
> lose a stable reference implementation to catch its bugs.

Well, the whole question here is whether git-subtree can become part of
core if it is based on libgit2.  It boils down to what you mean by
"widespread," I guess.  Does "widespread" mean "available as a package
in major distributions," "installed by default in major distributions"
or something else?

                                 -Dave
