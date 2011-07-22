From: Adam Monsen <haircut@gmail.com>
Subject: .gitattributes not forcing EOLs correctly for a CRLF-ending file
 on *NIX
Date: Fri, 22 Jul 2011 08:34:20 -0500
Message-ID: <4E297C5C.8030104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 15:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkFs8-0002Sr-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 15:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab1GVNe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 09:34:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60046 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1GVNe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 09:34:27 -0400
Received: by iyb12 with SMTP id 12so1980412iyb.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=tH82gyNcKuqob6cYVBFV7Pwwzlh/CHXUdPFkbluArzE=;
        b=EOkquBCylPj3Oqhfad3grAkXy3u44/dVQ7Lk1GohfsWs9wZ1I5pIDvPoF2+qmyNoLB
         1p11pJJB7o3l2BzJcK0k/8+aWzFGl5cHnf1I0cuHa4v60fuPMojyxlghqggYuuUNqX4t
         GgZL0S9t7Am/QTNFk4G/2P7wMWoutXK4ubXnM=
Received: by 10.231.84.208 with SMTP id k16mr1439935ibl.57.1311341666423;
        Fri, 22 Jul 2011 06:34:26 -0700 (PDT)
Received: from [10.1.1.119] (mail.tri-county.com [72.164.238.234])
        by mx.google.com with ESMTPS id er13sm1632088ibb.53.2011.07.22.06.34.23
        (version=SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 06:34:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177644>

Anyone have ideas why my .gitattributes file isn't working?

Repo:  git://chordii.git.sourceforge.net/gitroot/chordii/chordii

File "INSTALL.WINDOWS" (in the top-level directory of the repo) should
always have crlf line endings, but my git 1.7.4.1 client says the file
is modified after a fresh clone. I'm on Ubuntu GNU/Linux, I have
core.autocrlf set to "input". The top-level .gitattributes file contains
one line: "INSTALL.WINDOWS eol=crlf".

More likely I'm misusing .gitattributes or the core.autocrlf setting.
