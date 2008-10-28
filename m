From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Per-hunk whitespace cleaning in pre-commit?
Date: Tue, 28 Oct 2008 13:45:18 +0100
Message-ID: <57518fd10810280545mc74fccfp59a30bd0c2946e4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 13:46:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kunxy-0000b5-8G
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 13:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYJ1MpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 08:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYJ1MpU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 08:45:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:19279 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbYJ1MpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 08:45:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2589384wfd.4
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=xSM8hPNG2WLVpBJtnx3L4o4tsCf8hgVaLveowzvvcpw=;
        b=xT3U0hnOGqsHwcYVgR62kshROeinFCj6E4UNOVyED8bx1SkruVYEjOJoZ5jvA5cSVE
         c4+gA7+hi8EILvA+wPT8JRmkj/ZkVx4QbeBfE4AXq++lQLadZBeD7rCN+PBBVvlaLkpw
         QGVfOTA2yPDPPkIzon9QQNmS3eioih3KWxYPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=OIhkRXSIYxujC5/XgWZa7ayG8Pdg/4tSGXLXQATtxdKc1cncoSA7yTKFD9Cs9lojcX
         hEXqJl+foFeKsI/YggQLHXbcUZVo6YBOrpkDJdwDIoJ/HnBSddxnquVQHE2K5RcXsHGH
         nvUQ2cVTXiF/9CAtxLT3OcljG660QWYSCQQ4g=
Received: by 10.142.80.7 with SMTP id d7mr3328667wfb.173.1225197918463;
        Tue, 28 Oct 2008 05:45:18 -0700 (PDT)
Received: by 10.143.6.18 with HTTP; Tue, 28 Oct 2008 05:45:18 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 757c1ee530b50b6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99286>

I like the idea of whitespace fixing in pre-commit, but I'd prefer if
it only cleaned whitespace on the hunks that have changed, rather than
on the entire file.
Has anyone come up with a pre-commit version that does this?
