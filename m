From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: inaccurate commit message message?
Date: Sun, 5 Sep 2010 07:37:35 +1000
Message-ID: <AANLkTinbq8z-ygVUWPRq9PA95-+8O8SwOJCLkfMKCg9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 23:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0RG-0000OR-0O
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0IDVh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 17:37:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37039 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0IDVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 17:37:56 -0400
Received: by wyf22 with SMTP id 22so1443639wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=wjoLB4lMYSMi1CCYIjb10cHe487cFlxq0A80BAnqAKE=;
        b=YvrLV7OTfJ04Bt5TGZ/P49JtD91+abr7KglNAL4US7mdb7MH2z6ROXrFToSNVUJ9Db
         bozczvAmcN2GKUwhx/FAC59S+kEQ7E9tfyp0/3dvcL8f0+UkJU4rPIPz8tAlToe3liXD
         1GVLbpNe2nS9y5AiqT8LLCPLVo3xF/nuf8NfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=C6Kmh1MlTuTMJN0NEnzvFHcuOFXnz6ol4moDmB1PMD2HPBNGVdcfuN865A/KZMOkDi
         DT1r5ChRdXcX0u/apgfYSWGk4d9BJHdDbqpgQKKVFcNRWBJUrAWCpVmRxMHMd4J61QTH
         setqCESwO3BL6bEcz9Eh4x5Crt17QuqDTuyHY=
Received: by 10.216.22.5 with SMTP id s5mr1859862wes.79.1283636275085; Sat, 04
 Sep 2010 14:37:55 -0700 (PDT)
Received: by 10.216.25.9 with HTTP; Sat, 4 Sep 2010 14:37:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155361>

The commit message message says "Lines starting with '#' will be
ignored", but fails to say "Lines below this message will be ignored,
even if they don't start with '#'".
If the second sentence is true, I think it (or something equivalent)
should be said, especially because of the relevance during commit
--verbose.

In fact the documentation for commit --verbose explicitly says to note
that the diff lines won't start with '#'s, as if warning people that
those lines might show up in the commit message.
Yet they do not seem to show up... (and I don't think they should)
