From: John Bito <jwbito@gmail.com>
Subject: git diff looping?
Date: Mon, 15 Jun 2009 18:37:21 -0700
Message-ID: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 03:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGNc9-0001pa-8L
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 03:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZFPBhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbZFPBhU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 21:37:20 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:7512 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZFPBhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 21:37:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so9490967and.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CESQgqc918gKAtIl8CPKJWsR+Q20wOWyg7tXQEwlUeg=;
        b=XzU04Hy25zyt5x3/KSpOJ+BD8jR25UNIZlLZrK/f642P5y2BGC5NvZ4soZfHZMgh+3
         iStsNZDFcu2n1k6/iTeke1husVSzkSS3P//3vMp/WeCid/ytoAgwfcIlxIE5Jc6ZmVIM
         VdYPv/WDUaFAM6u/OPTHCHJLyiQbgr09TnjjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fBUN4o0uBqcIEj1zVr8ne+5KzHv0uQpuWGSZO5SRcqxE5dUsm/LaIeTd8nb2Gukth2
         vLIgt5a//nNvDfxrz4CH/BagPwOuBQczfY6TYcrQnmtGK8n+9/LCLEkyKSf9fLekI67r
         bJIJZGXdrLTjHYPCgvJPVV/018yb+MSDmBeZc=
Received: by 10.100.42.14 with SMTP id p14mr9678507anp.199.1245116241324; Mon, 
	15 Jun 2009 18:37:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121645>

Running Git 1.6.1 on Solaris 10, git diff seems to go into a loop -
consuming CPU and producing no output after a little bit.  While the
repository isn't small, it's not huge (it's
http://repo.or.cz/w/egit.git). I've tried the following:

$ git diff v0.4.0  > ~/t.diff
$ git diff v0.4.0 HEAD  > ~/t.diff
Both sit indefinitely eating most of 1 CPU
$ git fsck
Exits quickly with no output.

I don't mind going to a newer version of Git, but I'd like to have
some idea of the source of the problem before I start trying things.

Thanks!
John
