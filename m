From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug in git-send-mail (the 'next' branch)
Date: Tue, 18 Mar 2008 08:55:37 -0700 (PDT)
Message-ID: <m3abkwvxfr.fsf@localhost.localdomain>
References: <f36b08ee0803180652g68caa4cci21b0c59020c0fd07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5E6-000683-4C
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934668AbYCSUmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934676AbYCSUmx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:42:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38894 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934666AbYCSUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:42:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1311981ugc.16
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 13:42:50 -0700 (PDT)
Received: by 10.86.50.8 with SMTP id x8mr8000560fgx.30.1205855738573;
        Tue, 18 Mar 2008 08:55:38 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.235])
        by mx.google.com with ESMTPS id e11sm21345005fga.5.2008.03.18.08.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 08:55:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2IFtaj9024345;
	Tue, 18 Mar 2008 16:55:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2IFtaAq024342;
	Tue, 18 Mar 2008 16:55:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f36b08ee0803180652g68caa4cci21b0c59020c0fd07@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77541>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> There is a bug in git-send-mail in the 'next' branch. If first
> paragraph of the file in all indented by 1 space, and 1st line of the
> paragraph is at the first line of the file, then the whole
> paragraph disappears silently. If it's intentional, there should be a warning
> or something. And If it's *not* indented (as if it expects message
> header lines at this place), then it appears in the message body, so
> there is some inconsistency here.

I guess that this bug is in "header flowing" code; headers in email
message can span multiple lines by some use of indenting. That is
where one can search for the source of this bug...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
