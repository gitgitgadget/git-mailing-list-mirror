From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui translators - please update translations if necessary
Date: Sat, 02 Aug 2008 14:41:39 -0700
Message-ID: <7vod4bccx8.fsf@gitster.siamese.dyndns.org>
References: <20080802211714.GG24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOsI-0001Il-0s
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYHBVlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYHBVlq
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:41:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYHBVlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:41:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EF5B4735B;
	Sat,  2 Aug 2008 17:41:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 680624735A; Sat,  2 Aug 2008 17:41:41 -0400 (EDT)
In-Reply-To: <20080802211714.GG24723@spearce.org> (Shawn O. Pearce's message
 of "Sat, 2 Aug 2008 14:17:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CCE275CE-60DB-11DD-A323-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91188>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We're getting ready for the git 1.6 release in the not-too-distant
> future, and that will ship with gitgui-0.11.
>
> The current tip of my master branch builds as follows.  There have
> not been many changes in the interface so I don't think there is
> much (if any) translation work for this release.
>
>     MSGFMT    po/de.msg 402 translated.
>     MSGFMT    po/fr.msg 391 translated.
>     MSGFMT    po/hu.msg 391 translated.
>     MSGFMT    po/it.msg 390 translated, 1 untranslated.
>     MSGFMT    po/ja.msg 391 translated.
>     MSGFMT    po/ru.msg 387 translated, 4 untranslated.
>     MSGFMT    po/sv.msg 391 translated.
>     MSGFMT po/zh_cn.msg 367 translated, 7 fuzzy, 17 untranslated.

Hmm, I am confused.

Grepping po/*.po and po/git-gui.pot for POT-Creation-Date reveals that
po/de.msg is much more recent than po/git-gui.pot and all others are
translating the same POT.

Perhaps you wanted to update git-gui.pot first before sending this request
out?
