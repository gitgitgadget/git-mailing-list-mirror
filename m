From: Yury Polyanskiy <polyanskiy@gmail.com>
Subject: Why not show ORIG_HEAD in git-log --decorate?
Date: Fri, 9 Apr 2010 12:07:00 -0400
Message-ID: <s2zea182b21004090907i9af49416za4fdb4650af5ae29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 18:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Gjd-00022U-OB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab0DIQHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 12:07:04 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:36271 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0DIQHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 12:07:02 -0400
Received: by qyk9 with SMTP id 9so1518808qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=WHt8KoFtFkPwVjXQqsJ5jEebrsvNwunnpFNyi/rwdB0=;
        b=n2dCTpLcmHn146E8D06coEUK/dPSdQiW0ydAyiQW8Cw5oAeK1xoK0mDCcopUeRp5sb
         ylt6WnLZaB/hfwRcM4tqW1EgdNtlVT+NV46XWUL2TDfU2DuEWDAKvq5Awrazqt2bhmqJ
         i2pg1xz8VeHe3DUXL0CA5e4glpjLascGqBcQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=scsDLN3tLDcWSLdjx+N699QsZoHzIqXuArX7Nn0Kg0LNlLolZr9WhuzasV/epMEPuA
         TmOOWWLwDXd7s3d9uCORimYe75N84YFfbIui/IBMMor0Uspg7t0K+V5S7avRVmDYxMKu
         c+Q6GcLquR7UPxfSSdWQdzhcOraao1ove2oB0=
Received: by 10.229.230.131 with HTTP; Fri, 9 Apr 2010 09:07:00 -0700 (PDT)
Received: by 10.229.227.149 with SMTP id ja21mr213282qcb.74.1270829220541; 
	Fri, 09 Apr 2010 09:07:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144449>

Hello list!

It would be very convenient if after git-pull I could see the new
merged-in commits in the git-log. The simplest solution for this is to
simply mark ORIG_HEAD in the output of git-log --decorate (and ideally
also in gitk).

Just thought to throw in this idea to developers. Perhaps it is not
that hard to implement.

Best,
Yury
