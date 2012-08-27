From: <dag@cray.com>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 13:49:19 -0500
Message-ID: <nngsjb8i30w.fsf@transit.us.cray.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 20:49:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T64Nc-0000r0-IF
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab2H0St3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 14:49:29 -0400
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:52129 "EHLO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2H0St0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 14:49:26 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob107.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUDvBMqO5kkg1XrLTJRNCgkTgJID6fWrY@postini.com; Mon, 27 Aug 2012 11:49:26 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Mon, 27 Aug
 2012 13:49:20 -0500
In-Reply-To: <7vfw78s1kd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2012 10:10:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204366>

Junio C Hamano <gitster@pobox.com> writes:

>> I would be happy to be a guinea pig for libgit2 in order to improve it,
>> but I don't want to significantly impact git-subtree's move to core.
>> I'll have to figure out the right balance there given feedback.
>
> I expect it will take some time for libgit2 to allow our Makefile to
> start saying "LDFLAGS += -libgit2"; it will need to become as stable
> and widespread as other libraries we depend on, e.g. -lz and -lcurl.

Well that's a chicken-and-egg problem, isn't it.  How will a library
become widespread unless something uses it?

Would it be enough to have libgit2 as an installable package in the
major distributions?

                                 -Dave
