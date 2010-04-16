From: Brendan Miller <catphive@catphive.net>
Subject: preventing destructive operations to central repository
Date: Thu, 15 Apr 2010 17:39:42 -0700
Message-ID: <j2yef38762f1004151739x497106eeo190b97f3eecc153f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 02:39:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Zb2-0003rF-Jk
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0DPAjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 20:39:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55379 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0DPAjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 20:39:43 -0400
Received: by vws5 with SMTP id 5so525151vws.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:39:42 -0700 (PDT)
Received: by 10.220.84.84 with HTTP; Thu, 15 Apr 2010 17:39:42 -0700 (PDT)
Received: by 10.220.124.129 with SMTP id u1mr440282vcr.145.1271378382602; Thu, 
	15 Apr 2010 17:39:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145040>

Let's say you have a bare git repository writeable by a number of
different people. How do you prevent them from borking the central
repository?

Also, is there an automated mechanism to ensure that the timeline
stays clean? Say, force people to rebase their repositories before
merging into the shared repository?

Thanks
