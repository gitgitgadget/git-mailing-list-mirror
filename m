From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Guided merge with override
Date: Mon, 16 Jun 2008 13:46:38 +0930
Message-ID: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 06:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K869w-0003gj-Tm
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 06:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbYFPEQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbYFPEQm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 00:16:42 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:34627 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYFPEQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 00:16:42 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2983734mue.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=YJSN12sgWls2bJisDICMjQftuYhkquWYtqtTavYhRA4=;
        b=bM9OQcCZkjJYa9aw8rzoo2KpvgY9U1kSiN3igvsC1xlocZa6eIkoTg5uSsPUzNN2k2
         8K5u7gqQgvgCwvScbwFyzYJBA+Hb2JyyTub7LBQfy1kLttVNXCgFIk8EMcgTKQQ4HakS
         +KHWLXscBTybI7ArybMxVLjiQ1TpKuAUolcjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Vy3J4ifhwaJMUmpWS0qum5O0pJ8ja8uHXSTMyeAlUHif4PgbzFbBFWw0g7EtN02vsj
         L4n6j2B1iojmUAy20FfV5IJKjZUAQCdreJfRFKiuTdOA5NZ1GkFbFb5JbYfTAq2OrAAW
         yIBRdvkaohwbVsZfmig8l3u/oB4pGgUX+UyGU=
Received: by 10.82.106.14 with SMTP id e14mr338284buc.78.1213589798499;
        Sun, 15 Jun 2008 21:16:38 -0700 (PDT)
Received: by 10.82.107.11 with HTTP; Sun, 15 Jun 2008 21:16:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85163>

I have a two repositories A and B.  B is a tiny subset of the files in
A and all have been
modified.   If I do a "git pull B" into A, I get conflicts. I always
want to resolve these
by accepting the version from B. Is there a magic "override" switch to
let me do this?

Cheers,
Geoff Russell
