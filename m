From: "A B" <gentosaker@gmail.com>
Subject: git bisect on multiple cores
Date: Tue, 8 Apr 2008 12:58:47 +0200
Message-ID: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 12:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjBY4-00048j-T9
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 12:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYDHK6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 06:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYDHK6t
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 06:58:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:33576 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYDHK6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 06:58:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1717918wah.23
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LGK8tDF//fDRpPryxAIdenaqGXdSEeOzGKpGSqigwGc=;
        b=Hze21KFpgo57EGRXfiqDWm+FQMwz3MYefFySR9InnziQugeIv0+nByx287uNFpn5NeyJqTkAPGwxwRQGPB4FiXSB6gqZH2WRVx0v89Ll0Ylby/vFHN/BBKWZEvVjBnF2EQrtig0q6P9NYnx+ushEgW0//DfwGdKzTKcLEw2b2jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k/ZEufUDpwA3h7eiUce11kbRAFHSFIXQfPw4/NFgZYbBnd7txVmHIuL/gDR/GIcLqCahtL/lKisR9fjdwvz1IB6ZKZCTZifAjTytS8Pc3o4hvJygYBNs2ave5AVZsHCNCNAz77TftvUKNy6J9y5l892+Jq/BGCCWxLbsRP/Oxco=
Received: by 10.115.50.5 with SMTP id c5mr1160483wak.190.1207652327711;
        Tue, 08 Apr 2008 03:58:47 -0700 (PDT)
Received: by 10.114.125.17 with HTTP; Tue, 8 Apr 2008 03:58:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78995>

git bisect is really cool. I use it for the first time.
Just a thought, if you have a multiple core computer, can't you make
git build new versions in the background while testing the previuos
version? Alright, if you build 2 versions, one of them will never be
tested, but you will perhaps save some time by letting it build in the
background?

Just a thought...
