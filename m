From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: peek_remote return forever zero
Date: Tue, 6 Jun 2006 10:18:58 +0200
Message-ID: <34a7ae040606060118y709c3d67h85cbd88b314f25be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 06 10:19:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnWmF-0004cs-I3
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 10:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFFIS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 04:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFFIS7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 04:18:59 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:19213 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751151AbWFFIS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 04:18:59 -0400
Received: by wx-out-0102.google.com with SMTP id h28so856277wxd
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 01:18:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QnvTzeMC0zymDGyQvs6ar93q0l/TJDntHsW69aDtG6NfTtwLQ1QaadUpyT99Dmbz8uJOVjiIxw3iULlgTXV0F4O1FtBbrE8TD2h54R2bIcA9+wUqnfQGnhPQ4t4S6GdMdT2VYqhiqdnhKasP6W1j5jpKNSGphaSNs6bDBXLcdDg=
Received: by 10.70.50.19 with SMTP id x19mr7126005wxx;
        Tue, 06 Jun 2006 01:18:58 -0700 (PDT)
Received: by 10.70.94.12 with HTTP; Tue, 6 Jun 2006 01:18:58 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21367>

A question..

Why in peek-remote.c the peek_remote func.
return an int (and forever zero) ?

peek_remote return an int for future use
(and just for now zero) or we can replace it with a void?
