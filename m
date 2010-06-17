From: mobi phil <mobi@mobiphil.com>
Subject: false error when using git-http-backend without git-daemon-export-ok
Date: Fri, 18 Jun 2010 00:31:16 +0200
Message-ID: <AANLkTim8UKU7br5b_T7LLZHbkl6eottA1w9T71jlxoSi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 00:31:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPNcJ-0003dj-Rh
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760229Ab0FQWbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 18:31:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38435 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0FQWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 18:31:18 -0400
Received: by bwz7 with SMTP id 7so96134bwz.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 15:31:16 -0700 (PDT)
Received: by 10.204.46.205 with SMTP id k13mr122836bkf.143.1276813876115; Thu, 
	17 Jun 2010 15:31:16 -0700 (PDT)
Received: by 10.204.121.135 with HTTP; Thu, 17 Jun 2010 15:31:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149332>

Hello,

I would like to report a little annoyance when using git-http-backend.
If the git-daemon-export-ok file is not present in the remote exported
directory, git would report "<<PROJECT.GIT>>/info/refs not found: did
you run git update-server-info". This is misleading.

(http://www.mobiphil.com/2010/03/git-on-shared-hosting-with-git-http-backend)

-- 
rgrds,
mobi phil

being mobile, but including technology
http://mobiphil.com
