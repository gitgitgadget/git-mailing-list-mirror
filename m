From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: empty directories
Date: Mon, 23 Apr 2007 18:40:10 +0300
Message-ID: <f36b08ee0704230840xa37e149qffa15c5c685524c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg0eH-0006pg-4c
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 17:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXDWPkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXDWPkM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 11:40:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:11165 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbXDWPkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 11:40:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1831523wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 08:40:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kfmBH6aYqGUe+No7HFQ/yG1DXqJxD795+NYkhK8IbB8cKgBLoojaLrP8/DVjN2+GUuCop2z+47v6LUvXNgj/6TkhKSoQ/NTVK0pvdMsN3O/eH/ksFsAJfByIXgdtUW9oKq07FOrxuoIjFni4vlO97vlnCmtxwwNVb8d2NPrdGhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N8uC3nZy0Th7iHrPf8LdFIQ9emLKUMqRwsl5p4u1Ac7Ll/gBDUDXCQl9pgYiL6E2S4S3w+KZBfM5wcTDIK3Mv/+nxIHlEcpalh5g+z1Ak5o9JpN0h84UHBD53XuF8dE0NruCK+xz/PrHutnR6HErTIO1sOD46J2rnjhPVfOW/V8=
Received: by 10.90.97.11 with SMTP id u11mr4880082agb.1177342810283;
        Mon, 23 Apr 2007 08:40:10 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 08:40:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45329>

When I git-add empty directory (mkdir d1;git-add d1),
git refuses to add it [1].

I was told on #git chan that git cannot store empty dirs.
But when I do
         git-add -f emptyDir # where emptyDir is empty dir
, emptyDir is added and then cloned. What does it mean ?

Does it mean that if i git-add emptyDir with -f, it may break
something in the repo ? That I shall not try it ? Or it is ok ?

Thanks
Yakov
.....................................................................
[1] $ mkdir emptyDir
$ git-add emptyDir
The following paths are ignored by one of your .gitignore files:
emptyDir (directory)
Use -f if you really want to add them.
$
Note that the printed warning is misleading.
The name (emptyDir) is not in any .gitignore files.
It would be better to print the real reason for ignoring, no ?
