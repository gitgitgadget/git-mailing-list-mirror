From: Dmitry Potapov <dpotapov@gmail.com>
Subject: git grep '(' = segfault
Date: Mon, 27 Apr 2009 21:46:04 +0400
Message-ID: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 19:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyUv5-000857-S5
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 19:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbZD0RqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756859AbZD0RqH
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 13:46:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:26441 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbZD0RqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 13:46:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so17839fgg.17
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ZAtWY/PHkDMSBnd/EpBtkU9Ogr2Jc88nqC7Wtm350pw=;
        b=LBh0nFTlr42pcCX1fViuW3jDB6nm8k67EE0GQeGvFIjhrTkuGhx45bn2UTuowGN2+J
         Ec6vsEmntybCwMyGoqfqV7xH+qTTLPsA54eim5foZ8nkHtPshoPxgIwJuOksviMUxNLm
         YMrKJwrNsApXbNasNQlw4BePvw2LIyesm/M/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Ia7zVtLOf2WJmw7IypHPEhk7lCAtRYVmU2821QcaNXYwFDHgq2ktbFmRocIDKukzDC
         mcM3aDm5NkvtM1YGQyYz2qeD8BClDcElVKdA9MHMfGwC16tey3VL+mOuPbAJEB8LBiMW
         rhq3Ws+wqHd0iK/Zd9KgxozuCsxga28S/6FhE=
Received: by 10.86.93.17 with SMTP id q17mr3479471fgb.75.1240854364878; Mon, 
	27 Apr 2009 10:46:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117695>

Hi,

I have tried a few version of Git and got "Segmentation fault" when
run:

$ git grep '('

I am not very familiar with grep code and don't have time to dig
into it right now. So, maybe someone else can take a look at it.

Thanks,
Dmitry
