From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Trac+Git: rev-list with pathspec performance?
Date: Mon, 4 Oct 2010 15:38:45 -0500
Message-ID: <20101004203845.GG6466@burratino>
References: <13399611.436896.1286218134223.JavaMail.root@mail.hq.genarts.com>
 <27777603.436995.1286223710787.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rrU-0007WS-Kd
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab0JDUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:42:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55754 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab0JDUmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:42:05 -0400
Received: by bwz11 with SMTP id 11so3983942bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8sfgmwHCBBJlB6C8gR/r67Gw9bl8H/PTt6f/ocgjwrQ=;
        b=a4yPyuQADr62IPwMvusvqsW7BR68GcqtGuZOIWkD7DJq+CaWNp1QNiEGICUhRg8S7R
         0DN7Ob+Nbt30+aHRFQAoB3IpMyU4cLaMJjRt185/gasPiqvkg6M/2pXw2MRyhxcfQahU
         RYiUMYLnv7GPUggjyAe4ill+D704nvYwzslpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PGMQWeMsOFW4IU2kkkNhjuRRf0bOn2WCGfOk43Ezh24raGrNQmDi8xCarqds/StyWK
         F1kdaykrBfcbZCT2NwIFL7KOxbZvKG/OTCTDJZkm50Q7j96Bc9q0rH83PYB2PLlbDmkP
         uF7JNz25+sVWslHfixzqVVBZ4OIx4lYUHwwr4=
Received: by 10.223.111.133 with SMTP id s5mr9718768fap.34.1286224923471;
        Mon, 04 Oct 2010 13:42:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id f28sm2487935faa.24.2010.10.04.13.42.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:42:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27777603.436995.1286223710787.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158110>

Stephen Bash wrote:
> Is there a more efficient way to obtain the last commit that changed
> each file in a directory?

Yes.

http://yhbt.net/git-set-file-times
