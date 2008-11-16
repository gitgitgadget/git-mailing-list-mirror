From: Thomas Harning <harningt@gmail.com>
Subject: Re: git-daemon: single-line logging
Date: Sun, 16 Nov 2008 11:08:42 -0500
Message-ID: <F8349F16-7ABA-4C00-9AE3-F579197D27B8@gmail.com>
References: <alpine.LNX.1.10.0811131749420.16134@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Nov 16 17:10:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1kCL-0004M1-Vv
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 17:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYKPQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYKPQIu
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 11:08:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:17156 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYKPQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 11:08:49 -0500
Received: by ug-out-1314.google.com with SMTP id 39so233880ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=cxBbXCb3titdkN19EB7ZzMgC7WA+wYRMbcHTeukqaAg=;
        b=j066vHSZGgKkhe+KIW4NAqMCpvKZl71rbPn/uxR9Hyy3CfM4TuGXDZo8qQ3Ktb4VTf
         UBOuzMoXAho6Kjl/ogF7mstAYQnGcQRxeN99y1te0FuSE7zY2qZO0oC1+yCxXoQ9Qf2r
         HvOHxRPNVl9lvpAk0tTEZvBgrG8lUz5vPG6bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=sb2Drco5q5Kginfb6LF58hKzDtlng/3xEOqcHWfX550mdn5xqSKyzHHQcHgb5dNtjh
         KgTQKMLeOWxnf6M9KCYF1HDHjeeZoLyLwBYGuz/n3gL53IqJNW5yAFzR+X+uAk7UsByU
         z3/LmUHSmK8EXacVQzbCjvKUSm4ztBY9GZNnc=
Received: by 10.67.123.1 with SMTP id a1mr893773ugn.42.1226851727834;
        Sun, 16 Nov 2008 08:08:47 -0800 (PST)
Received: from ?192.168.0.202? (c-69-245-212-49.hsd1.in.comcast.net [69.245.212.49])
        by mx.google.com with ESMTPS id 39sm1565984ugb.43.2008.11.16.08.08.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 08:08:46 -0800 (PST)
In-Reply-To: <alpine.LNX.1.10.0811131749420.16134@fbirervta.pbzchgretzou.qr>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101139>

On Nov 13, 2008, at 11:51 AM, Jan Engelhardt wrote:
> I wrote this patch for my git-daemon to make it much easier to parse
> /var/log/git-daemon.log -- namely reducing the output from three lines
> per connected client to just one.

I think that this is a pretty good change, I'll have to try it out...

One thing I noticed was that there was some information lost in- 
transition...
The immediate information lost that I see is the port used.
