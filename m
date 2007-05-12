From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 0/3] Fix assorted white space damage
Date: Sat, 12 May 2007 13:09:13 +0200
Message-ID: <e5bfff550705120409v629425aesc910927c26871323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 13:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpTi-0003u2-DN
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbXELLJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756628AbXELLJP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:09:15 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:30059 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614AbXELLJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:09:14 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1283085nzf
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:09:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=piLk/vFaaBpYySEQkiQ1ypxUSa4pjIwBNMkiGcFd/rx1YudugFbFvRTG2hQjGA+4QG8GgrDC8uYpnlxO1urfmk6FzYtZb4zn5MpGNaT7pJGrBsLZAbEwQYT4i2gcBKrmxaTNcYSn/R416MVrmWPI3WU3YUqIj8P+ZH6PyfNKeug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dWQ00nLZPhAoaIIi20xQZ1o29OMsrVOAiYB4dqPsA3LtqYc89FuCVK0OlqnNKms9L+zHCyw4zEotefpTXdZU9yJqauJZ7ObneVQNp7/CVupMAo7WCQSQPwnvEX1AWUF1f2yYydvrGp20QE3vEiN3TfSsmKvSA0DV11MtJrDDYwE=
Received: by 10.115.49.16 with SMTP id b16mr218037wak.1178968153411;
        Sat, 12 May 2007 04:09:13 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 04:09:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47035>

Following there is a 3  patch series to remove stealth whitespace.

I have used the new 'cleanfile' script by H. Peter Anvin, just merged
in Linux tree.

The script cleans up various classes of stealth whitespace.  In
particular, it cleans up:

  - Whitespace (spaces or tabs)before newline;
  - DOS line endings (CR before LF);
  - Space before tab (spaces are deleted or converted to tabs);
  - Empty lines at end of file.


Tested with

make
make install
make test


  Marco
