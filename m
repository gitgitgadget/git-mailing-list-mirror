From: Rick Martinez <rick.martinez@gmail.com>
Subject: Ref refs/heads/master is at *** but expected ***
Date: Mon, 6 Apr 2009 14:11:40 -0400
Message-ID: <1fc2d7d00904061111s65ece9bal9a5c1288c631843b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 20:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqtJu-0000YD-Kd
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 20:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZDFSLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 14:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbZDFSLn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 14:11:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:46255 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZDFSLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 14:11:42 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2231662yxl.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bjfO1wZ6iqjKPvhyQHDVtA3KocBqFTcK5u5zuwzkkd0=;
        b=avB1VocbyCspjJZca68CZ2TKyQqg3/xlXBR5izIczz8TvZilWBPXmDleGMwYrSy0Xt
         zAh+t68zT7GymYdoluQPqojSy/AyfiEOeFWvKD2BjCDzwvbxRCHSWUdXhGyhxu5yhYvO
         LIIypQMBsEAFpztt4AAmJfknMEkXdHiK+yncw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=obPST7fiT1GTjhmd81jn5llje9Lt59WaTFPnhotiU8NDMR2MTVKfnGyrPgNA3230CA
         +dOTTUMAn/tXe0RfaK0cK6U+5NP91R/HBbVpthHI8s4hNUN8lcBouI0zNIFDUsxJHpOt
         6TnLZba7cJSY258Z1g4rT3q7OLthz1TJmkxDw=
Received: by 10.150.205.13 with SMTP id c13mr8841526ybg.83.1239041500442; Mon, 
	06 Apr 2009 11:11:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115863>

Hey guys,

So I was doing an interactive rebase and when I continued after fixing
a conflict, I got:

error: Ref refs/heads/master is at
13c56aa5628c03953912a683136f38cad852471b but expected
25713c34497cf07e4476291e6cd720d8a667701c
fatal: Cannot lock the ref 'refs/heads/master'.

When I do a git status, I get:

# On branch master
# Your branch and 'origin/master' have diverged,
# and have 6 and 5 different commit(s) each, respectively.
#
nothing to commit (working directory clean)

Any ideas on what to do next to try and get my branch back in order?

Thanks!
Rick
