From: ydirson@free.fr
Subject: Re: Help requested - trying to build a tool doing whole-tree
 commits
Date: Mon, 12 Nov 2012 14:11:22 +0100 (CET)
Message-ID: <1251602526.74686986.1352725882260.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <931951238.74665890.1352725212354.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git " <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXtnl-0003vt-7E
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 14:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab2KLNLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 08:11:31 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:39680 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab2KLNLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 08:11:30 -0500
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 652504C8068;
	Mon, 12 Nov 2012 14:11:23 +0100 (CET)
In-Reply-To: <931951238.74665890.1352725212354.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Originating-IP: [31.33.99.65]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209477>

esr:
>Junio C Hamano <gitster <at> pobox.com>:
>> Perhaps not exactly what you are looking for, but don't we have
>> import-tar somewhere in contrib/fast-import hierarchy (sorry, not on
>> a machine yet, and I cannot give more details).
>
>If I recall correctly, that can only be used for original import.

You may find my (old) ag-import-patch tool useful.  Although the name does not
imply it, it allows to import a series of releases that can be available either as
tarballs or as patches.

http://ydirson.free.fr/soft/git/argit.git/

There's not much doc in there, and not so much I can remember myself from the short
help string.  IIRC you can specify which base revision a patch applies to (ie. it
may apply to an older revision, not necessarily to the current HEAD).

It has also quite some bitrot (git-* direct invocation, use of cg-tag, surely more).
