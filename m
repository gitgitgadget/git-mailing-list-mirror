From: Lance Linder <llinder@gmail.com>
Subject: git-p4 move/delete errors
Date: Thu, 27 May 2010 19:30:04 -0500
Message-ID: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 02:30:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHnSn-0003K6-GV
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 02:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab0E1AaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 20:30:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56149 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0E1AaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 20:30:06 -0400
Received: by wwb34 with SMTP id 34so475011wwb.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=RxbWEv4cgE8Z1arRfv6Tdl3fmAYpNBfR6a5k+hOH8TE=;
        b=DGuEuNLik5Ykw61ToGR3l7SXz2QtFzm+0px63qcsKH7gkhzBhiRe6vZSIJYQ1uDkxZ
         rc99B03I9kIyhf2du/KBbi+vkFZIYeYIN3M9XYx3+9WFYsNxX0Q0O1TXoyQzJ5+nR+MN
         SUMr4dnBCvrJ4UMIo3/QjzSFK7/Cs5+bTaO5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nkD8FoPwc3/J1kS4WmlEMBrUkRr4YPis4f+75XWNoAggIjiLcPQaE5XPM5/ebn5xMx
         s+i3DYSALDyGPUIr8+ntXSOFSXBlAGiPixksbbprlMo4zX4l+BIJplPJa2czkJT8Maj8
         8NhdHvX5j+kWKL++Ti3oJxdBQkcvZtCh9lreY=
Received: by 10.216.170.9 with SMTP id o9mr1144683wel.45.1275006604485; Thu, 
	27 May 2010 17:30:04 -0700 (PDT)
Received: by 10.216.70.142 with HTTP; Thu, 27 May 2010 17:30:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147908>

Hello,

Until recently I have been successfully using git-p4 with much joy and
happiness. Then suddenly git-p4 submit started throwing "Command
failed: p4 diff -du ..." when ever I delete or move a file.

We recently upgraded our perforce server ( Rev.
P4D/NTX86/2009.2/238357 (2010/03/15) ). It was about this time that
the problem came up. First thing I did of course was upgrade to the
latest version of git ( now on 1.7.1 ) but the problem still persists.
Next I updated my p4 client ( Rev. P4/MACOSX104U/2009.2/238357
(2010/03/15) ) but still same problem. All other submits work fine as
long as there are not any deletions or moves.

Here is the exact output from git-p4 submit:

git p4 submit
Perforce checkout for depot path //depo/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Applying c287e823b3da49dcaf3463a5153d73ac493ad48e test

tmp2.txt - file(s) not opened on this client.
//depo/tmp2.txt#3 - opened for delete
open for read: /depo/tmp2.txt: No such file or directory
Command failed: p4 diff -du ...

Anyone else seeing these issues?

Thanks,
Lance
