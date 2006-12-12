X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bahadir Balban" <bahadir.balban@gmail.com>
Subject: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 10:05:08 +0000
Message-ID: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 10:05:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YccF2Cl6dK59zW8Lk1X+94pqr//EqrDYLZ5Pfltas+KJffV+HylBJg1iG8Zaplst2aOX8+TcWGo/gpmeRaMdi5CurlFQC6iUk6YzLveXEIacjVaXgaveCB9sw/7JRp4YgbvPrPi7zQniYOExq092uz5jWzt/Z5Dyak4bjw01Fj8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34075>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu4Vf-00073A-TK for gcvg-git@gmane.org; Tue, 12 Dec
 2006 11:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751025AbWLLKFL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 05:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWLLKFL
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 05:05:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:64175 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751025AbWLLKFK (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 05:05:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so193434nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 02:05:08 -0800 (PST)
Received: by 10.82.139.17 with SMTP id m17mr788836bud.1165917908469; Tue, 12
 Dec 2006 02:05:08 -0800 (PST)
Received: by 10.82.186.15 with HTTP; Tue, 12 Dec 2006 02:05:08 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

When I initialise a git repository, I use a subset of files in the
project and leave out irrelevant files for performance reasons. Then
when I need to make changes to a file not yet in the repository, the
file is treated as new, and if I reset the change or change branches
the file is gone.

Is there a good way of adding new files to git as if they had existed
from the initial commit (or even better, since a particular commit)?
This way I would only track the new changes I made to an existing
file.

Thanks,
