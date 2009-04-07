From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Showing the version of a file that's in the Index.
Date: Tue, 7 Apr 2009 22:10:05 +0200
Message-ID: <200904072210.05591.markus.heidelberg@web.de>
References: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHdi-00023n-TW
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbZDGUJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbZDGUJu
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:09:50 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48552 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbZDGUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:09:49 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 147C5FC9FFBE;
	Tue,  7 Apr 2009 22:09:48 +0200 (CEST)
Received: from [89.59.110.219] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrHcB-0000tK-00; Tue, 07 Apr 2009 22:09:48 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX182jVgLVPblsjas6z+I71zS9f+Zv3n5rKax1kAW
	5bOkgnXlnZg8q16/43Rw0d/bdih627WM1Wrw3c4oKNnD6YPKyX
	Ko2S0uLUAX+PB/HKcbWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115982>

Tim Visher, 07.04.2009:
> How do you go about showing the version of the file that's in an
> index.

With version do you mean content? Then

    git cat-file -p :0:file
or
    git cat-file -p :file

See git-rev-parse(1) "Specifying revisions", the last item.

Markus
