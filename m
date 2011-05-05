From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: ignored file can be deleted silently
Date: Thu, 05 May 2011 21:51:58 +0200
Message-ID: <1304625118.18121.9.camel@mastrogen>
References: <BANLkTinEupQKfBofhH-qKD6gLGWyWRbGvw@mail.gmail.com>
	 <BANLkTi=C4pO83mT3pO0B_AMaK3RMOC4V8g@mail.gmail.com>
	 <7viptp9jos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:56:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4eo-000293-Jp
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1EET4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:56:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50431 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1EET4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:56:13 -0400
Received: by wwa36 with SMTP id 36so2740252wwa.1
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=z0qKMgmn8hdSlymnyqIr1nHF63goiL4tjqrWc31W9bk=;
        b=KQB1rEji8z9VeIyY39jmrkwylG73JYfHrRxx/BrnohXOeRQONb+q10C33ZwAvlGO/Z
         logq6xzj7ngRBf4AAGPICrIhOBmTuzIKaafDAJd3+JzVscVypE9O72FIOPoY22XNzO5w
         6bTggPt086pOcdmjn/suuby5PuCy5gHnDk0sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=vTaMNBX6YzmmEAPHn6psj12ISTGGyk9Gkh7Q3CySLhBsCUJ6KoCTt5zWFQ4B5Ywad1
         A9Rf52pIJhxk7Uogkc7QFzBR2T9Xs/9uOcGdyNcRZ/zD9S3gEvNvNDDns3z74pMnFMPb
         pn9o2hZSxWp0ukHuFPBArlcAfkPn/dbBoDirc=
Received: by 10.216.140.219 with SMTP id e69mr7269733wej.45.1304625372558;
        Thu, 05 May 2011 12:56:12 -0700 (PDT)
Received: from [192.168.1.12] (host49-74-dynamic.4-87-r.retail.telecomitalia.it [87.4.74.49])
        by mx.google.com with ESMTPS id c54sm1272928wer.6.2011.05.05.12.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 12:56:11 -0700 (PDT)
In-Reply-To: <7viptp9jos.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172895>

Il giorno gio, 05/05/2011 alle 09.49 -0700, Junio C Hamano ha scritto:
> No.  The real issue is that we have only two classes of paths.  Either
> ignored or unignored.

I totally agree agree with you
a third class would be perfect for the job..

even a *new* sintax in the ignore list could do
