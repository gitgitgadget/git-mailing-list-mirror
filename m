From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: gitk bug
Date: Wed, 30 May 2007 20:31:20 -0300
Message-ID: <f329bf540705301631q7906eb1dv9291fd088cd88282@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 01:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtXdf-0001qS-Lr
	for gcvg-git@gmane.org; Thu, 31 May 2007 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbXE3Xb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbXE3Xb3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 19:31:29 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:11399 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXE3Xb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 19:31:28 -0400
Received: by an-out-0708.google.com with SMTP id d31so784370and
        for <git@vger.kernel.org>; Wed, 30 May 2007 16:31:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kaKFlRP22uNZn6hZeBwP4GE2q3AAh1C/AuljeGEloXYUGltzjK7IW9PySaDP7r0LeCfWwoE5LriipU4kUfd9yJpU7Khhykd7D6OBT9U9vN3pRF4tTIf/cX9D7ZF6uRBcnCyR8i26EignycUY0q5OI2ZGQVumvkjpf7ua+bZYzAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a3vTvA3YpdDRU0sEl8uCVnykpAPQ56sEEzuT2uM0HW2nmG/NtGGbni53M4zX+jmnFK3fuPWqcB6Fn6zmRxgjwrPOgfHeXzn/JYsHWVMvlBIh3NsprtlEu8HPccnE5dAzDCK5cUTQGqDDCDwAvVEu9SOsPle5WMyvyWlxT86usVM=
Received: by 10.100.228.6 with SMTP id a6mr6378359anh.1180567880503;
        Wed, 30 May 2007 16:31:20 -0700 (PDT)
Received: by 10.100.94.14 with HTTP; Wed, 30 May 2007 16:31:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48789>

git init
mkdir -p x/y/z
echo hoi > x/y/z/file1
echo hoi > x/y/z/file2
git add .
git commit -m 'start'
gitk


->

click "Tree". Open "x" directory.

Result:

can't read "treeheight(y/)": no such element in array
can't read "treeheight(y/)": no such element in array
    (reading value of variable to increment)
    invoked from within
"incr treeheight($x) $n"
    (procedure "treeopendir" line 15)
    invoked from within
"treeopendir $w $e"
    (procedure "treeclick" line 20)
    invoked from within



this is with


commit 322bcd9a9a2c0081c66414bde64e0d443c9ec922
Merge: a77a33a... 8558fd9...
Author: Junio C Hamano <junkio@cox.net>
Date:   Tue May 29 01:24:20 2007 -0700


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
