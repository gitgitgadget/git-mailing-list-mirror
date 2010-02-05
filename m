From: Jay Soffian <jaysoffian@gmail.com>
Subject: Showing whitespace on minus lines of diff ouput
Date: Thu, 4 Feb 2010 20:47:52 -0500
Message-ID: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 02:48:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdDJ9-0006fu-58
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 02:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933489Ab0BEBrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 20:47:55 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:50619 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab0BEBrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 20:47:53 -0500
Received: by iwn27 with SMTP id 27so430410iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1D1g3q18a5L0rPGcxWAhpmDUXrff/oDTmQ3r8hjVX2o=;
        b=ZWRuhpsNiHjajQXq2+XCmpk1jS2MU7ATyjmtXIsHPJhI2+8ybq7YlyDoLP50fnh/7c
         1h1FBVWehxZJG9pWEl5CNwVKuuQg38ZCjeAca8UE8GJylUUCvQSomYDepKOKXr2l/KjD
         StihrA/jwgNYWLcv21cojh6+uhUs6jpClRKoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tcYe8kaZqUcwDG2nICH14Tf/vaHB8BfpKyzJlFwqxYbKHB+fTU5QjhYuSKKHZSv3TR
         4wqClmhjkaO0J3zL3IbxwGPFinlvk79N1OTQCuzfD5tsfBdBOG8AoXSYNFFVVRiyMZKx
         XTrNDRlnYg2psU9uOcNWbjlch2Kiwo/SnA1oo=
Received: by 10.231.148.208 with SMTP id q16mr1068983ibv.9.1265334472467; Thu, 
	04 Feb 2010 17:47:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139020>

The colored diff output is quite helpful to show introductions of whitespace.

However, if whitespace has been removed, it's impossible to see in the
diff output since whitespace is colorized on '+' lines, but not '-'
lines.

I'm looking at diff.c, but wow. Can someone more familiar with this
file point me toward how I'd make a patch to colorize whitespace on
'-' lines as well?

Thanks,

j.
