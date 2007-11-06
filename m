From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: git-log -p --raw broken?
Date: Tue, 6 Nov 2007 19:48:43 -0300
Message-ID: <f329bf540711061448iab9d4a9q37e13b846dbc5ff1@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 23:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXEC-00035M-TS
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXKFWsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbXKFWsp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:48:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:20345 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXKFWsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:48:45 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1493882nze
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 14:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Kumtyn9y+MY5PM+h8bc7fPdGc3KRz+DwlEQgxwler0Q=;
        b=ggdwLYJD/LdxuF8lMXQbW6I3kBZQDouWbXJmqU1vdDRV5zoDA5gbuDrs7yx8LvAUeZzXFLuRKxjz7kw7BGK1nI8jQQE+Dsyl8W2QFbM8a8A5XqLV3HZT+dy9QCVyhkYpOJ/9fysU4kFXpO3UL1crkM7jBHX38vwjAhHhuvAwzX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gDpco0gPRrpo0HQseqJuRXD00wUbVB+3BK4gWy+jlMy9Ln3Sdeqe1jv16bbvCcu2bupfEZRFL0dcgHd9aslSnCL0gjZiLPPTOKOaPAziCan3DlY3ryL9EtjewooEyJNZTjg1QeHAVN1so6RWays3Sj4xQxPcXvFd5YEXC5X7/80=
Received: by 10.115.90.1 with SMTP id s1mr1287162wal.1194389323535;
        Tue, 06 Nov 2007 14:48:43 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Tue, 6 Nov 2007 14:48:43 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63742>

Hi,

I'm trying to get a list of

  git diff-tree -t -r --raw COMMITTISH

where COMMITTISH comes from git-rev-list, using a limited number of
processes. The manual page suggests that I should be able to do

 git log -p --raw COMMIT-RANGE

however, when I try that, I get always get the same style output,
which is the (to me: useless) human readable output.

Am I missing something?
-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
