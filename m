From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git describe oddity: ignoring recent tags...
Date: Mon, 23 Nov 2009 13:01:51 +0100
Message-ID: <46a038f90911230401sb2b1dd7u21b5d7edefe510eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 13:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCXcE-00041B-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 13:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbZKWMBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 07:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757123AbZKWMBq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 07:01:46 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:60473 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119AbZKWMBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 07:01:45 -0500
Received: by ey-out-2122.google.com with SMTP id 4so963038eyf.19
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Y7QOkGQg+skO/l8S4K6ojyKaNd6+oBzrTK6G46CLsTs=;
        b=O1ZFLuAUn5rHPmROfG0WoLx23jA+1GjLEKH0OilMcoC0t3RvreNkZ4F1HVnjSr1nQG
         Otp9f65SG/84k4nOQBIgBHAuo8WDOgkCUowngchGSJZRY0EObnScnoL0sPkmBkls8MPL
         dIY0OyodZwrUwA3alIFDgrnsERCxSFD1Gw/Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VF3ef3Jw8PlL7oCssDdTd/7CXu3F57U6vQDbyWNFsXGpI8rSy0czy/5pgFYe+noFg+
         mKCg1tTwhPJWysciaztXTrrhjGCgCs8EnHT67Fmb80wNhNKxWmKln19uZrBRHM495XW6
         ndvJctOGEEzya/cWtNxzk0nBjmv0lW/G2bKNU=
Received: by 10.213.23.146 with SMTP id r18mr4747022ebb.79.1258977711082; Mon, 
	23 Nov 2009 04:01:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133499>

Clone this repo: git://dev.laptop.org/projects/olpc-update -- or just
check visually the recent history here
http://dev.laptop.org/git/projects/olpc-update/log/

git describe origin/master will respond olpc-update-2.16-20-g2d4e4b8
when it is fairly clear to me that it should be
olpc-update-2.19-1g<hash>.

For some reason, recent tags are being ignored -- and cgit even
displays them differently in
http://dev.laptop.org/git/projects/olpc-update/log/ though it is
unclear to me why.

These tags are not 'lightweight', and no tags are signed either.
Passing --tags and --debug has not helped much.

Tested with 1.6.0.6 (Fedora 9 rpm) and 1.6.3.1.26.gf5b223 (on Karmic).



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
