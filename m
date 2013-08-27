From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH v2 0/11] Modernize user-manual
Date: Tue, 27 Aug 2013 19:52:54 +0200 (CEST)
Message-ID: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:53:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENRs-0000lj-79
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab3H0Rw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:52:56 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:41191 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab3H0Rwz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:52:55 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 52E07107AD9;
	Tue, 27 Aug 2013 19:52:54 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 496A22E61A3;
	Tue, 27 Aug 2013 19:52:54 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 477AFCBC53;
	Tue, 27 Aug 2013 19:52:54 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 477AFCBC53
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377625974; bh=KdGZ+3waWRasWi9OUbM6qK3aLoooo6hWibN8M66TLeA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=WURciiol7NNNQL5TxRkHw8WI8zIyBsE3JbrvOpTHcVC1zoXukdlWLRYTVI/K1/a3f
	 TsBCeqlmdO2T7emuI18EadSJUYAB/Pw7HyoRUsYzAwT7GdXI4VUVj08lR1tHcsUZwZ
	 BbSgvweDgTVfScI6hWX17LNDKD9VZba6oB+vNhG0=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:52:54 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233120>

Hi,

this is v2 of my patches for user-manual.txt.

Thanks to Junio, Jonathan, Martin and Philip for your comments!

I think Philips remarks should be part of a separate patch series which then
also should address the current differences in layout between user-manual.html
and user-manual.pdf.

Changes in v2:

[PATCH 01/13] Call it "Git User Manual" and remove reference to very old Git version 
-> same as v1
[PATCH 02/13] Use current "detached HEAD" message 
-> fixed another occurence of "(no branch)"
[PATCH 03/13] Use current output for "git repack" 
-> add location where packfile is created
[PATCH 04/13] Use "git merge" instead of "git pull ." 
-> reverted changes in "Getting updates with git pull"
[PATCH 05/13] Fix some typos  and improve wording
-> better wording
[PATCH 06/13] Simplify "How to make a commit" 
-> better wording
[PATCH 07/13] Improve description in "How to merge" 
-> this patch was dropped
[PATCH 08/13] Improve section "Manipulating branches" 
-> add missing case for "current"
[PATCH 09/13] Improve section "Merge multiple trees" 
-> better wording
[PATCH 10/13] Remove unnecessary historical note from "Object storage format"
-> same as in v1
[PATCH 11/13] Remove obscure reference from "Examples"
-> this patch was dropped
[PATCH 12/13] Remove irrelevant reference from "Tying it all together"
-> same as in v1
[PATCH 13/13] "git prune" is safe now
-> weakend warning for "git prune"

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>

---
Thomas
