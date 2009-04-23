From: Caleb Cushing <xenoterracide@gmail.com>
Subject: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 03:46:05 -0400
Message-ID: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 09:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwtfx-0004yp-0O
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 09:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759018AbZDWHqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 03:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759008AbZDWHqL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 03:46:11 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:46299 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758997AbZDWHqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 03:46:09 -0400
Received: by an-out-0708.google.com with SMTP id d40so271575and.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=XR2lnQj2QBr6dWI+qqHYftcedFbFqsbY/SAR80PFpxo=;
        b=bIame8RSQkpl5qbMCQimZ6mgzexW997sJChccP7QOfsq8XAla1tcB/0pSkl2bS6WcX
         cXBszp/M4FJ1vOZABreIgpKhlJySWndjrkpuL57prbuMKicldXiiPjM1MpuRdD4gn0cw
         zpSgdkda39rI59w9psqiUl6LeOzvjsSp3WEYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dkXuw5gVP3TT/ARk1JRHoWBmHt0uBQ2/ELjd0+UqKg+qrB5IqsyyWTGGVDD/Z8kzBv
         Y/VV1wH/rvC62RUGVCi9kiHMc1RFcSdIA2L9t7yjNvOPv94UpYKH6NvYFlWt2/XtW6lC
         mthytWq2pilQAHQR7aSlhP03SiwAdEgVGAYvY=
Received: by 10.100.133.2 with SMTP id g2mr1113779and.23.1240472765111; Thu, 
	23 Apr 2009 00:46:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117306>

so I do the same merge all the time... sorta, I'm not sure rerere
would actually work because the file is different each time... I just
have to delete it each time. and I want to automate the process.
checkout merge rm commmit, problem is commit brings and editor up, I
want to commit with the 'auto inserted merge message' that is
generated, without seeing the editor, how do I do this?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
