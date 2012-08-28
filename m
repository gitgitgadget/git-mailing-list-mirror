From: <dag@cray.com>
Subject: Re: libgit2 status
Date: Tue, 28 Aug 2012 12:59:46 -0500
Message-ID: <nngr4qqhp7x.fsf@transit.us.cray.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
	<nngsjb8i30w.fsf@transit.us.cray.com>
	<7v6284qfw8.fsf@alter.siamese.dyndns.org>
	<20120827214027.GA511@vidovic>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	<greened@obbligato.org>, <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q55-0001ri-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab2H1R7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 13:59:55 -0400
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:38988 "EHLO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2H1R7y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 13:59:54 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob101.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUD0HFLBb+8S/9JIFg91xjdaXBAWRdTla@postini.com; Tue, 28 Aug 2012 10:59:54 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Tue, 28 Aug
 2012 12:59:47 -0500
In-Reply-To: <20120827214027.GA511@vidovic> (Nicolas Sebrecht's message of
	"Mon, 27 Aug 2012 23:40:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204436>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Do you expect one big merge of a very stable libgit2 at some point?

I don't think there's any need to merge libgit2 into the git project
source.  As a library, it should be perfectly usable as a project of its
own, just like libcurl and libz.

> Otherwise, what about going with this optionnal "LDFLAGS += -libgit2"
> ASAP with good disclaimer that it's only intended for development and
> testing purpose? Then, git-core could slowly rely on functions of
> libgit2, one after the other.

This makes a lot of sense to me.

                            -David
