From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: mistake in Release Notes for 1.6.2
Date: Thu, 15 Jan 2009 23:13:03 +0100
Message-ID: <200901152313.03747.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:14:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNaTl-0007uV-Rs
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935109AbZAOWMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 17:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935100AbZAOWMc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:12:32 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57401 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbZAOWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:12:30 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 22068FBC27D6;
	Thu, 15 Jan 2009 23:12:29 +0100 (CET)
Received: from [89.59.96.34] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNaRw-0002pK-00; Thu, 15 Jan 2009 23:12:29 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+NCbv/cUiu8H83fQieqE6xIgwbPy8BgfN8TrR+
	D6VggsawpP7CaOYjYHc0rbYYn7hueKjL/v5yfxhrOA3O4AgBQ9
	aOrOJSI+Yx68xP4A0Tmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105884>

Hello Junio,

Documentation/RelNotes-1.6.2.txt:
> * git-cherry defaults to HEAD when the <upstream> argument is not given.

This is not correct, see commit f2968022 (2008-12-29):

    git-cherry: make <upstream> parameter optional

    The upstream branch <upstream> now defaults to the first tracked
    remote branch, which is set by the configuration variables
    branch.<name>.remote and branch.<name>.merge of the current branch.

    Without such a remote branch, the command "git cherry [-v]" fails with
    usage output as before and an additional message.

I guess it's a mistake in hurry, not every default value is HEAD :)

Markus
