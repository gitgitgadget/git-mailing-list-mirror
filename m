From: Klein W <wineklein@gmail.com>
Subject: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 15:17:24 -0500
Message-ID: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 21:17:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0c5C-0003Sl-D2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 21:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbaLOUR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 15:17:26 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:51616 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaLOUR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 15:17:26 -0500
Received: by mail-lb0-f196.google.com with SMTP id f15so2064982lbj.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 12:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5E7zrc8uk21QRGUtYOsMGjZvy181ZDJQxU/rEkDq3yY=;
        b=wvz+mcun8zgNEoiTNmCz3ehEaUty9umwUOZZ2LPDOpT2x4jeDVic03cMkCnNKYMJSd
         dDDs60nDqPx7x9FS4NNbHLnVWfbJDBF4XRVr+9IcZ5kPQup1rZcsQIKalP5kBA3UrHPL
         4OVANTdujY3ZPpBqIZbBNCzAAL8hLRBWDG90odtcbk7aYaSitUR7Q2/Bw/8GRjDNXZAJ
         olF4iRLtZJFCaSnzK55tfE7yBKCBM9oTgw9t02uTKXCuumy+HgHFjyhCN/xlX2D0xmKf
         p6IZu4rIgzRv3K2x9GiZhR3zr4PFmxyy2SskNmzx704PXk2/Rmy+UbFe3jkpLHjfrb1k
         Jv8g==
X-Received: by 10.152.23.38 with SMTP id j6mr24472853laf.81.1418674644308;
 Mon, 15 Dec 2014 12:17:24 -0800 (PST)
Received: by 10.114.216.100 with HTTP; Mon, 15 Dec 2014 12:17:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261419>

Is there any example of a remote helper [0] with push and fetch capabilities?

The git-remote-testgit.sh example [1] only has import/export capabilities.

Also, what are the advantages and disadvantages of a remote helper
with push/fetch capabilities vs a remote helper with import/export
capabilities?

Thanks.

[0] https://www.kernel.org/pub/software/scm/git/docs/git-remote-helpers.html
[1] https://github.com/git/git/blob/master/git-remote-testgit.sh
