From: "Eric Raible" <raible@gmail.com>
Subject: RFH: gitk equivalent of "git log -p --full-diff file.cpp"
Date: Mon, 6 Oct 2008 19:04:14 -0700
Message-ID: <279b37b20810061904n4f50f650l81590cb6fd239282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn1x9-0000j1-AQ
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYJGCEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbYJGCEZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:04:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:30742 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYJGCEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 22:04:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3120818wfd.4
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 19:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7kfikJcGa1zQlRNgZgM9oI2w+r82CbF7n+oMyBiaDdQ=;
        b=KoCm6HV4oxGUEOHPdWPNmFnHuHmtT2HFlmv2zRec8hP1dGjwkqj3aPyazOYFbcDq/8
         QqlbtzfC4u9f0tXaZzpjTMsqz3RaJgKaaa1eWCPbWTu43C14Rq6WIDatPUeO/6zHm7PH
         5LddOXCcj2Z2LxrNXZ4Mz0awMlovvFzNr8V8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=I9xO08GPCAsPJYx+kW6vu8bZLS3fDMmQ6j3tTFTaFEXHqG7mYSurPE2YPflRxsc2Dr
         24brlW18zMXpUV3lg677vLdLd86+vJmiQMLBGxbqMmU46QJGYbY3OrjaAeVH6zHg7GnK
         Ke9EhMtjHUFmMFqCdajQ1TBm6wt/XDRD5Ag0I=
Received: by 10.142.134.20 with SMTP id h20mr2321116wfd.21.1223345054244;
        Mon, 06 Oct 2008 19:04:14 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Mon, 6 Oct 2008 19:04:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97653>

Hello All -

Hopefully I'm just being dense, but there's a useful tortoisesvn feature that
(so far) I haven't found in gitk.  Blasphemy!  Sniveling windoze luser, etc^2.

Anyway what I'm looking for is the gitk equivalent of:

    git log -p --full-diff file.cpp

That is to say: I want to see all commits which touch a given
file along with all of the other files changed by that commit.

    gitk -p --full-diff EntryPoints.cpp

doesn't quite do it - it treats the "extra" diffs as part of the commit msg.
Anyone got more if a clue than me?

Thanks - Eric

PS - Aside from aliases, am I missing a simpler spelling of the above
     git log command?
