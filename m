From: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Subject: [PATCH 0/2] gitweb use sections
Date: Mon, 28 Jul 2008 23:34:26 -0300
Message-ID: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
Cc: gitster@pobox.com,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 04:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNf3s-0004by-Hb
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYG2Cej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYG2Cej
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:34:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:52360 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYG2Cei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:34:38 -0400
Received: by qw-out-2122.google.com with SMTP id 3so394563qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 19:34:37 -0700 (PDT)
Received: by 10.214.43.9 with SMTP id q9mr1059446qaq.84.1217298877792;
        Mon, 28 Jul 2008 19:34:37 -0700 (PDT)
Received: from solid.profusion.mobi ( [201.82.39.16])
        by mx.google.com with ESMTPS id 6sm751651ywp.3.2008.07.28.19.34.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 19:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90553>

The following two patches will add sections to gitweb so usability is
improved for large project listing. It looks like:

    http://staff.get-e.org/

but it's a new code that also supports owner sort.

Patches orverview:

 * [PATCH 1/2] gitweb: sort projects by path.
   This one is required to fix project sort. Since we use paths, we
   should compare individual components to make it look like a
   tree. Since we now can enable sections this error will be more
   evident, so there is the fix.

 * [PATCH 2/2] gitweb: add section support to gitweb project listing.
   The real section work. This will add use_sections variable and if
   it evaluates to true sections will be enabled. Just project and
   owner sections are implemented.

I hope it looks good for inclusion. Last time I did perl was about 8
years ago, please point any problems and I'll fix them.


--
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri@gmail.com
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
