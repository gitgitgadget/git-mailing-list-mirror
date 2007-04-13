From: "Andrew Grover" <andy.grover@gmail.com>
Subject: Everyday git webpage could also mention setgid on dirs
Date: Fri, 13 Apr 2007 12:59:04 -0700
Message-ID: <c0a09e5c0704131259k2de9df19l770f23f47ddf2f5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 21:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcRvM-0006yd-Aw
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 21:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXDMT7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXDMT7I
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 15:59:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:53679 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964796AbXDMT7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 15:59:05 -0400
Received: by wr-out-0506.google.com with SMTP id 76so964087wra
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 12:59:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FkXmmLosR8eMEWPokbindamlLa/Z/f+tEHx5IjduEI99ScY4SJgQQMAWbQ2ZvTVcpPXne0EbJclzXmHcivo/paj4iEQ9bGItOSie/Eq61eU9lEwt3N+sLdhu3BjuAa2HSfsaCBokdRQ1r2eQ3Tbf01mk3lTRjt+jv81QKhgu2Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RQapvl0p+elrhAHhlWa3Gi+ElfFHsvBl10EP3dAIPph2LcKNjaDBeSh0XXo66tss87U2VUlWfuTX+dpFfKQlsLmoVyVsFJP4AyDBGCTyj8FaOMDkksdxnXCtOHn/xBtjAvbRekjUZaagKNMu9MgI3ajnO0tucKGgb+0V8n+EPcw=
Received: by 10.115.107.1 with SMTP id j1mr1087506wam.1176494344811;
        Fri, 13 Apr 2007 12:59:04 -0700 (PDT)
Received: by 10.114.38.20 with HTTP; Fri, 13 Apr 2007 12:59:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44427>

Referring to: http://www.kernel.org/pub/software/scm/git/docs/everyday.html

Under the "CVS-style shared repository" section, I think it should
mention that in addition to making the shared repository writable to
the group, it is also necessary to set the gid bit on all directories,
so future added files also have the correct group.

Regards -- Andy
