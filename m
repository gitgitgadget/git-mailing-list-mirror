From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] gitk i18n implementation: Add Makefile with rules for po file creation and installation.
Date: Wed, 07 Nov 2007 13:38:47 -0800
Message-ID: <7vbqa5ag7s.fsf@gitster.siamese.dyndns.org>
References: <200711071839.08570.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpscA-0007gr-MS
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXKGViz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbXKGViz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:38:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38970 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbXKGViy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:38:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A6C5B2F9;
	Wed,  7 Nov 2007 16:39:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DE5B92281;
	Wed,  7 Nov 2007 16:39:11 -0500 (EST)
In-Reply-To: <200711071839.08570.stimming@tuhh.de> (Christian Stimming's
	message of "Wed, 7 Nov 2007 18:39:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63863>

Christian Stimming <stimming@tuhh.de> writes:

> The compiled .msg files will be installed into $(sharedir)/gitk/lib/msgs
> according to Junio's mailing list proposal on 2007-07-28.
> ---
> These patches are against master of gitk.git at git.kernel.org.
>
> Just in case any of the mailers might mess up whitespaces, I've also
> attached all 9 patches in the attached tarball.
>
>  Makefile |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
>  create mode 100644 Makefile

There is a slight issue of merging this into git.git, as the
initial "coolest merge ever" was done with the understanding
that gitk will remain a single file project.

The simplest way without using submodule (because it would
require everybody who follow git.git to update to 1.5.3 or
later, which I'd rather not to do at this point yet) would be to
merge gitk.git with the subtree strategy to a subdirectory,
which I think will be what I'll end up doing.
