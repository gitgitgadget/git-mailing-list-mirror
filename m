From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: [JGIT] maven build fails on OS X
Date: Fri, 6 Feb 2009 15:08:15 +0000
Message-ID: <320075ff0902060708m5ec566b9g755829c25c7727d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSKv-0004pb-Gq
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZBFPIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBFPIR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:08:17 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:36628 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZBFPIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:08:16 -0500
Received: by ey-out-2122.google.com with SMTP id 25so231262eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 07:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=xQmsW33MD9XJ4yvpnSEANf40PLWE/TrA3d00dXglIoc=;
        b=PdRcSs14UJwgg5dh7O7xxJiWwz3hxXDBOXQBCppnlQoy9xamcRho6+F7QGW9VHaEzW
         lUh2133usx2WZnPOsIOhq+vYC7+5GL9KSmWnPKL76VdPi1VHFWQqz97qpEacJbA7Xo5Q
         4ecwjuvwWivH2vi0mfXoOXlGVWD3+VVCsmDAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=HqWF4iGWNQOBXYzZ2j49Sqn6kF8gAJTnuVCJEy5AkbrlUqaNAVYaby1PzAGzWqNvyO
         eNvg4qR3y0D7iigSyz1FtPza1KA5pb+0URI9HyWrGu95STLHb5taqsyshd8eAPz4QR6p
         awHPSk1ZLKoFJ+aEvKX2S169nJA7kxZ0/g638=
Received: by 10.103.172.7 with SMTP id z7mr760134muo.129.1233932895157; Fri, 
	06 Feb 2009 07:08:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108725>

I don't know if this is known about - I get failures running the m2
build for jgit:

Failed tests:
  testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
  testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevCommitParseTest)
  testParse_implicit_mixed_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
  testParse_explicit_bad_encoded(org.spearce.jgit.revwalk.RevTagParseTest)
  testDequote_OctalAll(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
  testDequote_Latin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
  testDequote_RawLatin1(org.spearce.jgit.util.QuotedStringGitPathStyleTest)
  testGetText_DiffCc(org.spearce.jgit.patch.GetTextTest)

Curiously, the tests work in eclipse and from ./make_jgit.sh - I
suspect some environment setting with the mac's charset.

I can try and fix it if it's new, but I wanted to check first..
